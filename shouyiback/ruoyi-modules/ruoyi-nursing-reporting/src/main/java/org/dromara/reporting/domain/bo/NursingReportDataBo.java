package org.dromara.reporting.domain.bo;

import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.reporting.domain.NursingReportData;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 护理数据填报业务对象 nursing_report_data
 *
 * @author ruoyi
 * @date 2025-09-16
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = NursingReportData.class, reverseConvertGenerate = false)
public class NursingReportDataBo extends BaseEntity {

    /**
     * 填报数据ID
     */
    @NotNull(message = "填报数据ID不能为空", groups = {EditGroup.class})
    private Long reportId;

    /**
     * 分类ID
     */
    @NotNull(message = "分类ID不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long categoryId;

    /**
     * 指标名称
     */
    @NotBlank(message = "指标名称不能为空", groups = {AddGroup.class, EditGroup.class})
    private String indicatorName;

    /**
     * 指标编码
     */
    @NotBlank(message = "指标编码不能为空", groups = {AddGroup.class, EditGroup.class})
    private String indicatorCode;

    /**
     * 数据值
     */
    @NotNull(message = "数据值不能为空", groups = {AddGroup.class, EditGroup.class})
    private BigDecimal dataValue;

    /**
     * 数据单位
     */
    private String dataUnit;

    /**
     * 统计周期（年/月/周/日）
     */
    private String statisticsCycle;

    /**
     * 统计开始时间
     */
    private Date statisticsStartTime;

    /**
     * 统计结束时间
     */
    private Date statisticsEndTime;

    /**
     * 填报年份
     */
    @NotNull(message = "填报年份不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer reportYear;

    /**
     * 填报季度
     */
    private Integer reportSeason;

    /**
     * 填报科室ID
     */
    private Long deptId;

    /**
     * 填报人ID
     */
    private Long reporterId;

    /**
     * 审核状态（0待审核 1已审核 2已退回）
     */
    private String auditStatus;

    /**
     * 审核人ID
     */
    private Long auditorId;

    /**
     * 审核时间
     */
    private Date auditTime;

    /**
     * 审核意见
     */
    private String auditComment;

    /**
     * 数据来源（0手工录入 1Excel导入 2系统自动获取）
     */
    private String dataSource;

    /**
     * 排序号
     */
    private Integer orderNum;

    /**
     * 状态（0正常 1停用）
     */
    private String status;

    /**
     * 备注
     */
    private String remark;

    /**
     * 版本
     */
    private Long version;

}