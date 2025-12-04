<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="指标名称" prop="indicatorName">
              <el-input v-model="queryParams.indicatorName" placeholder="请输入指标名称" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="填报年份" prop="reportYear">
              <el-input v-model="queryParams.reportYear" placeholder="请输入填报年份" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="填报季度" prop="reportSeason">
              <el-input v-model="queryParams.reportSeason" placeholder="请输入填报季度" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
              <el-button icon="Refresh" @click="resetQuery">重置</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </div>
    </transition>

    <el-card shadow="never">
      <template #header>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" plain icon="Upload" @click="handleImport" v-hasPermi="['system:reportData:add']">导入数据</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['system:reportData:add']">新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()" v-hasPermi="['system:reportData:edit']">
              修改
            </el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['system:reportData:remove']">
              删除
            </el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="reportDataList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="数据编号" align="center" prop="reportId" />
        <el-table-column label="分类" align="center" prop="categoryName" />
        <el-table-column label="指标名称" align="center" prop="indicatorName" />
        <el-table-column label="指标编码" align="center" prop="indicatorCode" />
        <el-table-column label="数据值" align="center" prop="dataValue" />
        <el-table-column label="填报年份" align="center" prop="reportYear" />
        <el-table-column label="填报季度" align="center" prop="reportSeason" />
        <el-table-column label="备注" align="center" prop="remark" />
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:reportData:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['system:reportData:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    <!-- 添加或修改护理数据填报对话框 -->
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="500px" append-to-body>
      <el-form ref="reportDataFormRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="分类" prop="categoryId">
          <el-select v-model="form.categoryId" placeholder="请选择分类">
            <el-option v-for="item in categoryList" :key="item.categoryId" :label="item.categoryName" :value="item.categoryId"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="指标名称" prop="indicatorName">
          <el-input v-model="form.indicatorName" placeholder="请输入指标名称" />
        </el-form-item>
        <el-form-item label="指标编码" prop="indicatorCode">
          <el-input v-model="form.indicatorCode" placeholder="请输入指标编码" />
        </el-form-item>
        <el-form-item label="数据值" prop="dataValue">
          <el-input v-model="form.dataValue" placeholder="请输入数据值" />
        </el-form-item>
        <el-form-item label="填报年份" prop="reportYear">
          <el-input v-model="form.reportYear" placeholder="请输入填报年份" />
        </el-form-item>
        <el-form-item label="填报季度" prop="reportSeason">
          <el-input v-model="form.reportSeason" placeholder="请输入填报季度" />
        </el-form-item>
        <el-form-item label="数据来源" prop="dataSource">
          <el-input v-model="form.dataSource" placeholder="请输入数据来源" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button :loading="buttonLoading" type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 用户导入对话框 -->
    <el-dialog v-model="upload.open" :title="upload.title" width="400px" append-to-body>
      <el-upload
        ref="uploadRef"
        :limit="1"
        accept=".xlsx, .xls"
        :headers="upload.headers"
        :action="upload.url + '?updateSupport=' + upload.updateSupport"
        :disabled="upload.isUploading"
        :on-progress="handleFileUploadProgress"
        :on-success="handleFileSuccess"
        :auto-upload="false"
        drag
      >
        <el-icon class="el-icon--upload">
          <i-ep-upload-filled />
        </el-icon>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <template #tip>
          <div class="text-center el-upload__tip">
            <!-- <div class="el-upload__tip"><el-checkbox v-model="upload.updateSupport" />是否上传数据</div> -->
            <span>仅允许导入xls、xlsx格式文件。</span>
            <!-- <el-link type="primary" :underline="false" style="font-size: 12px; vertical-align: baseline" @click="importTemplate">下载模板</el-link> -->
          </div>
        </template>
      </el-upload>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitFileForm">确 定</el-button>
          <el-button @click="upload.open = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="ReportData" lang="ts">
import { listReportData, getReportData, delReportData, addReportData, updateReportData } from '@/api/reporting/reportData/index';
import { listCategory } from '@/api/reporting/category/index';
import { ReportDataVO, ReportDataQuery, ReportDataForm } from '@/api/reporting/reportData/types';
import { globalHeaders } from '@/utils/request';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const categoryList = ref<any[]>([]);

const uploadRef = ref<ElUploadInstance>();
/*** 用户导入参数 */
const upload = reactive<ImportOption>({
  // 是否显示弹出层（用户导入）
  open: false,
  // 弹出层标题（用户导入）
  title: '导入护理数据',
  // 是否禁用上传
  isUploading: false,
  // 是否更新已经存在的用户数据
  updateSupport: 0,
  // 设置上传的请求头部
  headers: globalHeaders(),
  // 上传的地址
  url: import.meta.env.VITE_APP_BASE_API + '/reporting/data/importData'
});
/** 查询分类列表 */
const getCategoryList = async () => {
  const res = await listCategory();
  categoryList.value = res.rows;
};

const reportDataList = ref<ReportDataVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<ElFormInstance>();
const reportDataFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const initFormData: ReportDataForm = {
  reportId: undefined,
  categoryId: undefined,
  indicatorName: undefined,
  indicatorCode: undefined,
  dataValue: undefined,
  dataUnit: undefined,
  statisticsCycle: undefined,
  statisticsStartTime: undefined,
  statisticsEndTime: undefined,
  reportYear: undefined,
  reportSeason: undefined,
  deptId: undefined,
  reporterId: undefined,
  auditStatus: undefined,
  auditorId: undefined,
  auditTime: undefined,
  auditComment: undefined,
  dataSource: undefined,
  orderNum: undefined,
  status: undefined,
  remark: undefined
};
const data = reactive<PageData<ReportDataForm, ReportDataQuery>>({
  form: { ...initFormData },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    categoryId: undefined,
    indicatorName: undefined,
    indicatorCode: undefined,
    dataValue: undefined,
    dataUnit: undefined,
    statisticsCycle: undefined,
    statisticsStartTime: undefined,
    statisticsEndTime: undefined,
    reportYear: undefined,
    reportSeason: undefined,
    deptId: undefined,
    reporterId: undefined,
    auditStatus: undefined,
    auditorId: undefined,
    auditTime: undefined,
    auditComment: undefined,
    dataSource: undefined,
    orderNum: undefined,
    status: undefined,
    params: {}
  },
  rules: {
    indicatorName: [{ required: true, message: '指标名称不能为空', trigger: 'blur' }],
    dataValue: [{ required: true, message: '数据值不能为空', trigger: 'blur' }],
    reportYear: [{ required: true, message: '填报年份不能为空', trigger: 'blur' }],
    reportSeason: [{ required: true, message: '填报季度不能为空', trigger: 'blur' }]
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询护理数据填报列表 */
const getList = async () => {
  loading.value = true;
  const res = await listReportData(queryParams.value);
  reportDataList.value = res.rows;
  total.value = res.total;
  loading.value = false;
};

/** 取消按钮 */
const cancel = () => {
  reset();
  dialog.visible = false;
};

/** 表单重置 */
const reset = () => {
  form.value = { ...initFormData };
  reportDataFormRef.value?.resetFields();
};

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.value.pageNum = 1;
  getList();
};

/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value?.resetFields();
  handleQuery();
};

/** 多选框选中数据 */
const handleSelectionChange = (selection: ReportDataVO[]) => {
  ids.value = selection.map((item) => item.reportId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
};

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = '添加护理数据填报';
};

/** 修改按钮操作 */
const handleUpdate = async (row?: ReportDataVO) => {
  reset();
  const _reportId = row?.reportId || ids.value[0];
  const res = await getReportData(_reportId);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = '修改护理数据填报';
};

/** 提交按钮 */
const submitForm = () => {
  reportDataFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.reportId) {
        await updateReportData(form.value).finally(() => (buttonLoading.value = false));
      } else {
        await addReportData(form.value).finally(() => (buttonLoading.value = false));
      }
      proxy?.$modal.msgSuccess('操作成功');
      dialog.visible = false;
      await getList();
    }
  });
};

/** 删除按钮操作 */
const handleDelete = async (row?: ReportDataVO) => {
  const _reportIds = row?.reportId || ids.value;
  await proxy?.$modal.confirm('是否确认删除护理数据填报编号为"' + _reportIds + '"的数据项？').finally(() => (loading.value = false));
  await delReportData(_reportIds);
  proxy?.$modal.msgSuccess('删除成功');
  await getList();
};

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download(
    'system/reportData/export',
    {
      ...queryParams.value
    },
    `reportData_${new Date().getTime()}.xlsx`
  );
};

/** 导入按钮操作 */
const handleImport = () => {
  upload.title = '用户导入';
  upload.open = true;
};
/**文件上传中处理 */
const handleFileUploadProgress = () => {
  upload.isUploading = true;
};
/** 文件上传成功处理 */
const handleFileSuccess = (response: any, file: UploadFile) => {
  upload.open = false;
  upload.isUploading = false;
  uploadRef.value?.handleRemove(file);
  ElMessageBox.alert("<div style='overflow: auto;overflow-x: hidden;max-height: 70vh;padding: 10px 20px 0;'>" + response.msg + '</div>', '导入结果', {
    dangerouslyUseHTMLString: true
  });
  getList();
};
/** 提交上传文件 */
function submitFileForm() {
  uploadRef.value?.submit();
}

onMounted(() => {
  getList();
  getCategoryList();
});
</script>
