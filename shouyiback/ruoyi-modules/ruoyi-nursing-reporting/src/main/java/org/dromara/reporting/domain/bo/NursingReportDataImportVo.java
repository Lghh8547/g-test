package org.dromara.reporting.domain.bo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import cn.idev.excel.annotation.format.DateTimeFormat;
import cn.idev.excel.annotation.format.NumberFormat;
import org.dromara.common.excel.annotation.ExcelRequired;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 护理数据填报Excel导入对象 nursing_report_data
 *
 * @author ruoyi
 * @date 2025-09-16
 */
@Data
@ExcelIgnoreUnannotated
public class NursingReportDataImportVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 分类名称
     */
    @ExcelRequired
    @ExcelProperty(value = "分类")
    private String categoryName;

    /**
     * 指标名称
     */
    @ExcelRequired
    @ExcelProperty(value = "指标名称")
    private String indicatorName;

    /**
     * 指标编码
     */
    @ExcelRequired
    @ExcelProperty(value = "指标编码")
    private String indicatorCode;

    /**
     * 数据值
     */
    @ExcelRequired
    @ExcelProperty(value = "数据值")
    @NumberFormat("#,##0")
    private BigDecimal dataValue;

    /**
     * 数据单位
     */
    @ExcelProperty(value = "数据单位")
    private String dataUnit;

    /**
     * 统计周期（年/月/周/日）
     */
    @ExcelProperty(value = "统计周期")
    private String statisticsCycle;

    /**
     * 统计开始时间
     */
    @DateTimeFormat("yyyy-MM-dd")
    @ExcelProperty(value = "统计开始时间")
    private Date statisticsStartTime;

    /**
     * 统计结束时间
     */
    @DateTimeFormat("yyyy-MM-dd")
    @ExcelProperty(value = "统计结束时间")
    private Date statisticsEndTime;

    /**
     * 填报年份
     */
    @ExcelRequired
    @ExcelProperty(value = "填报年份")
    private Integer reportYear;

    /**
     * 填报季度
     */
    @ExcelProperty(value = "填报季度")
    private Integer reportSeason;

    /**
     * 排序号
     */
    @ExcelProperty(value = "排序号")
    private Integer orderNum;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;

}