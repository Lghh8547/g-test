package org.dromara.reporting.listener;

import cn.idev.excel.context.AnalysisContext;
import org.dromara.common.core.utils.ValidatorUtils;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.excel.core.DefaultExcelListener;
import org.dromara.reporting.domain.bo.NursingReportDataImportVo;

/**
 * 护理数据填报Excel导入监听器
 *
 * @author ruoyi
 * @date 2025-09-16
 */
public class NursingReportDataImportListener extends DefaultExcelListener<NursingReportDataImportVo> {

    public NursingReportDataImportListener() {
        // 显示使用构造函数，否则将导致空指针
        super(true);
    }

    @Override
    public void invoke(NursingReportDataImportVo data, AnalysisContext context) {
        // 先校验必填字段
        ValidatorUtils.validate(data, AddGroup.class);

        // 数据预处理
        processData(data);

        // 处理完毕以后判断是否符合规则
        ValidatorUtils.validate(data, EditGroup.class);

        // 添加到处理结果中
        getExcelResult().getList().add(data);
    }

    /**
     * 数据预处理
     *
     * @param data 导入数据
     */
    private void processData(NursingReportDataImportVo data) {
        // 处理分类名称，去除前后空格
        if (data.getCategoryName() != null) {
            data.setCategoryName(data.getCategoryName().trim());
        }

        // 处理指标名称，去除前后空格
        if (data.getIndicatorName() != null) {
            data.setIndicatorName(data.getIndicatorName().trim());
        }

        // 处理指标编码，去除前后空格并转换为大写
        if (data.getIndicatorCode() != null) {
            data.setIndicatorCode(data.getIndicatorCode().trim().toUpperCase());
        }

        // 处理数据单位，去除前后空格
        if (data.getDataUnit() != null) {
            data.setDataUnit(data.getDataUnit().trim());
        }

        // 处理统计周期，去除前后空格
        if (data.getStatisticsCycle() != null) {
            data.setStatisticsCycle(data.getStatisticsCycle().trim());
        }

        // 处理备注，去除前后空格
        if (data.getRemark() != null) {
            data.setRemark(data.getRemark().trim());
        }

        // 设置默认排序号
        if (data.getOrderNum() == null) {
            data.setOrderNum(1);
        }
    }
}