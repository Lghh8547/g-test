package org.dromara.reporting.domain;

import com.baomidou.mybatisplus.annotation.*;
import org.dromara.common.tenant.core.TenantEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 护理数据填报分类对象 nursing_category
 *
 * @author ruoyi
 * @date 2025-09-16
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("nursing_category")
public class NursingCategory extends TenantEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 分类ID
     */
    @TableId(value = "category_id")
    private Long categoryId;

    /**
     * 分类名称
     */
    private String categoryName;

    /**
     * 分类编码
     */
    private String categoryCode;

    /**
     * 父分类ID
     */
    private Long parentId;

    /**
     * 显示顺序
     */
    @OrderBy(asc = true, sort = 1)
    private Integer orderNum;

    /**
     * 分类状态（0正常 1停用）
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