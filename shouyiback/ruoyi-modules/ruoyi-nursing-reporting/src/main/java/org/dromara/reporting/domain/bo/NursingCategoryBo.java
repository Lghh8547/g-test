package org.dromara.reporting.domain.bo;

import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.reporting.domain.NursingCategory;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

/**
 * 护理数据填报分类业务对象 nursing_category
 *
 * @author ruoyi
 * @date 2025-09-16
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = NursingCategory.class, reverseConvertGenerate = false)
public class NursingCategoryBo extends BaseEntity {

    /**
     * 分类ID
     */
    @NotNull(message = "分类ID不能为空", groups = {EditGroup.class})
    private Long categoryId;

    /**
     * 分类名称
     */
    @NotBlank(message = "分类名称不能为空", groups = {AddGroup.class, EditGroup.class})
    private String categoryName;

    /**
     * 分类编码
     */
    @NotBlank(message = "分类编码不能为空", groups = {AddGroup.class, EditGroup.class})
    private String categoryCode;

    /**
     * 父分类ID
     */
    private Long parentId;

    /**
     * 显示顺序
     */
    @NotNull(message = "显示顺序不能为空", groups = {AddGroup.class, EditGroup.class})
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
    private Long version;

}