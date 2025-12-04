package org.dromara.reporting.domain.vo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import cn.idev.excel.annotation.format.DateTimeFormat;
import cn.idev.excel.annotation.format.NumberFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.dromara.common.excel.annotation.ExcelRequired;
import org.dromara.common.translation.annotation.Translation;
import org.dromara.common.translation.constant.TransConstant;
import org.dromara.reporting.domain.NursingReportData;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 护理数据填报视图对象 nursing_report_data
 *
 * @author ruoyi
 * @date 2025-09-16
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = NursingReportData.class)
public class NursingReportDataVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 填报数据ID
     */
    @ExcelProperty(value = "填报数据ID")
    private Long reportId;

    /**
     * 分类ID
     */
    @ExcelRequired
    @ExcelProperty(value = "分类ID")
    private Long categoryId;

    /**
     * 分类名称
     */
    @ExcelProperty(value = "分类名称")
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
    @NumberFormat("0")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "#,##0")
    private BigDecimal dataValue;

    /**
     * 数据单位
     */
    @ExcelProperty(value = "数据单位")
    private String dataUnit;

    /**
     * 统计周期（年/月/周/日）
     */
    @ExcelProperty(value = "统计周期", converter = org.dromara.common.excel.convert.ExcelDictConvert.class)
    @org.dromara.common.excel.annotation.ExcelDictFormat(dictType = "nursing_statistics_cycle")
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
     * 填报科室ID
     */
    @ExcelProperty(value = "填报科室ID")
    private Long deptId;

    /**
     * 填报科室名称
     */
    @Translation(type = TransConstant.DEPT_ID_TO_NAME, mapper = "deptId")
    @ExcelProperty(value = "填报科室名称")
    private String deptName;

    /**
     * 填报人ID
     */
    @ExcelProperty(value = "填报人ID")
    private Long reporterId;

    /**
     * 填报人姓名
     */
    @Translation(type = TransConstant.USER_ID_TO_NAME, mapper = "reporterId")
    @ExcelProperty(value = "填报人姓名")
    private String reporterName;

    /**
     * 审核状态（0待审核 1已审核 2已退回）
     */
    @ExcelProperty(value = "审核状态", converter = org.dromara.common.excel.convert.ExcelDictConvert.class)
    @org.dromara.common.excel.annotation.ExcelDictFormat(dictType = "nursing_audit_status")
    private String auditStatus;

    /**
     * 审核人ID
     */
    @ExcelProperty(value = "审核人ID")
    private Long auditorId;

    /**
     * 审核人姓名
     */
    @Translation(type = TransConstant.USER_ID_TO_NAME, mapper = "auditorId")
    @ExcelProperty(value = "审核人姓名")
    private String auditorName;

    /**
     * 审核时间
     */
    @DateTimeFormat("yyyy-MM-dd HH:mm:ss")
    @ExcelProperty(value = "审核时间")
    private Date auditTime;

    /**
     * 审核意见
     */
    @ExcelProperty(value = "审核意见")
    private String auditComment;

    /**
     * 数据来源（0手工录入 1Excel导入 2系统自动获取）
     */
    @ExcelProperty(value = "数据来源", converter = org.dromara.common.excel.convert.ExcelDictConvert.class)
    @org.dromara.common.excel.annotation.ExcelDictFormat(dictType = "nursing_data_source")
    private String dataSource;

    /**
     * 排序号
     */
    @ExcelProperty(value = "排序号")
    private Integer orderNum;

    /**
     * 状态（0正常 1停用）
     */
    @ExcelProperty(value = "状态", converter = org.dromara.common.excel.convert.ExcelDictConvert.class)
    @org.dromara.common.excel.annotation.ExcelDictFormat(dictType = "sys_normal_disable")
    private String status;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;

    /**
     * 创建时间
     */
    @DateTimeFormat("yyyy-MM-dd HH:mm:ss")
    @ExcelProperty(value = "创建时间")
    private Date createTime;

    /**
     * 创建人
     */
    @ExcelProperty(value = "创建人")
    private Long createBy;

    /**
     * 创建人账号
     */
    @Translation(type = TransConstant.USER_ID_TO_NAME, mapper = "createBy")
    @ExcelProperty(value = "创建人账号")
    private String createByName;

    /**
     * 更新时间
     */
    @ExcelProperty(value = "更新时间")
    private Date updateTime;

    /**
     * 更新人
     */
    @ExcelProperty(value = "更新人")
    private Long updateBy;

    /**
     * 更新人账号
     */
    @Translation(type = TransConstant.USER_ID_TO_NAME, mapper = "updateBy")
    @ExcelProperty(value = "更新人账号")
    private String updateByName;

    /**
     * 版本
     */
    private Long version;

}
