package org.dromara.reporting.domain;

import com.baomidou.mybatisplus.annotation.*;
import org.dromara.common.tenant.core.TenantEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 护理数据填报对象 nursing_report_data
 *
 * @author ruoyi
 * @date 2025-09-16
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("nursing_report_data")
public class NursingReportData extends TenantEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 填报数据ID
     */
    @TableId(value = "report_id")
    private Long reportId;

    /**
     * 分类ID
     */
    private Long categoryId;

    /**
     * 指标名称
     */
    private String indicatorName;

    /**
     * 指标编码
     */
    private String indicatorCode;

    /**
     * 数据值
     */
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
    @OrderBy(asc = true, sort = 1)
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
    @Version
    private Long version;

    /**
     * 删除标志
     */
    @TableLogic
    private Long delFlag;

}