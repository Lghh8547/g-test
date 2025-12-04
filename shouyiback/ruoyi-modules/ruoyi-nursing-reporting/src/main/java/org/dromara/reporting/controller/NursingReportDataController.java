package org.dromara.reporting.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.domain.R;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.core.validate.QueryGroup;
import org.dromara.common.excel.core.ExcelResult;
import org.dromara.common.excel.utils.ExcelUtil;
import org.dromara.common.idempotent.annotation.RepeatSubmit;
import org.dromara.common.log.annotation.Log;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.web.core.BaseController;
import org.dromara.reporting.domain.bo.NursingReportDataBo;
import org.dromara.reporting.domain.bo.NursingReportDataImportVo;
import org.dromara.reporting.utils.CustomExcelParser;
import org.dromara.reporting.domain.vo.NursingReportDataVo;
import org.dromara.reporting.service.INursingReportDataService;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 护理数据填报Controller
 *
 * @author ruoyi
 * @date 2025-09-16
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/reporting/data")
public class NursingReportDataController extends BaseController {

    private final INursingReportDataService nursingReportDataService;

    /**
     * 查询护理数据填报列表
     */
    @SaCheckPermission("reporting:data:list")
    @GetMapping("/list")
    public TableDataInfo<NursingReportDataVo> list(@Validated(QueryGroup.class) NursingReportDataBo bo, PageQuery pageQuery) {
        return nursingReportDataService.queryPageList(bo, pageQuery);
    }

    /**
     * 自定义分页查询
     */
    @SaCheckPermission("reporting:data:list")
    @GetMapping("/page")
    public TableDataInfo<NursingReportDataVo> page(@Validated(QueryGroup.class) NursingReportDataBo bo, PageQuery pageQuery) {
        return nursingReportDataService.customPageList(bo, pageQuery);
    }

    /**
     * 导入数据
     *
     * @param file 导入文件
     */
    @Log(title = "护理数据填报", businessType = BusinessType.IMPORT)
    @SaCheckPermission("reporting:data:import")
    @PostMapping(value = "/importData", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public R<Void> importData(@RequestPart("file") MultipartFile file) throws Exception {
        // 使用自定义解析器处理可能包含合并单元格的Excel模板
        List<NursingReportDataImportVo> dataList = CustomExcelParser.parseNursingReportTemplate(file.getInputStream());
        nursingReportDataService.importReportData(dataList);
        return R.ok("导入成功，共导入" + dataList.size() + "条数据");
    }

    /**
     * 导出护理数据填报列表
     */
    @SaCheckPermission("reporting:data:export")
    @Log(title = "护理数据填报", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(@Validated NursingReportDataBo bo, HttpServletResponse response) {
        List<NursingReportDataVo> list = nursingReportDataService.queryList(bo);
        ExcelUtil.exportExcel(list, "护理数据填报", NursingReportDataVo.class, response);
    }

    /**
     * 获取护理数据填报详细信息
     *
     * @param reportId 主键
     */
    @SaCheckPermission("reporting:data:query")
    @GetMapping("/{reportId}")
    public R<NursingReportDataVo> getInfo(@NotNull(message = "主键不能为空")
                                          @PathVariable("reportId") Long reportId) {
        return R.ok(nursingReportDataService.queryById(reportId));
    }

    /**
     * 新增护理数据填报
     */
    @SaCheckPermission("reporting:data:add")
    @Log(title = "护理数据填报", businessType = BusinessType.INSERT)
    @RepeatSubmit(interval = 2, timeUnit = TimeUnit.SECONDS, message = "{repeat.submit.message}")
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody NursingReportDataBo bo) {
        return toAjax(nursingReportDataService.insertByBo(bo));
    }

    /**
     * 修改护理数据填报
     */
    @SaCheckPermission("reporting:data:edit")
    @Log(title = "护理数据填报", businessType = BusinessType.UPDATE)
    @RepeatSubmit
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody NursingReportDataBo bo) {
        return toAjax(nursingReportDataService.updateByBo(bo));
    }

    /**
     * 删除护理数据填报
     *
     * @param reportIds 主键串
     */
    @SaCheckPermission("reporting:data:remove")
    @Log(title = "护理数据填报", businessType = BusinessType.DELETE)
    @DeleteMapping("/{reportIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] reportIds) {
        return toAjax(nursingReportDataService.deleteWithValidByIds(Arrays.asList(reportIds), true));
    }

    /**
     * 审核护理数据
     *
     * @param reportIds 填报数据ID集合
     * @param auditStatus 审核状态（1已审核 2已退回）
     * @param auditComment 审核意见
     */
    @SaCheckPermission("reporting:data:audit")
    @Log(title = "护理数据审核", businessType = BusinessType.UPDATE)
    @PostMapping("/audit")
    public R<Void> audit(@RequestParam("reportIds") Long[] reportIds,
                         @RequestParam("auditStatus") String auditStatus,
                         @RequestParam(value = "auditComment", required = false) String auditComment) {
        return toAjax(nursingReportDataService.auditReportData(Arrays.asList(reportIds), auditStatus, auditComment));
    }

    /**
     * 检查指标编码是否唯一
     */
    @GetMapping("/checkIndicatorCodeUnique")
    public R<Boolean> checkIndicatorCodeUnique(String indicatorName, Long reportId, Long categoryId,
                                               Integer reportYear, Integer reportSeason) {
        return R.ok(nursingReportDataService.checkIndicatorCodeUnique(indicatorName, reportId, categoryId, reportYear, reportSeason));
    }
}
