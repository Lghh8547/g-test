package org.dromara.reporting.domain.vo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import cn.idev.excel.annotation.format.DateTimeFormat;
import org.dromara.common.excel.annotation.ExcelRequired;
import org.dromara.common.translation.annotation.Translation;
import org.dromara.common.translation.constant.TransConstant;
import org.dromara.reporting.domain.NursingCategory;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 护理数据填报分类视图对象 nursing_category
 *
 * @author ruoyi
 * @date 2025-09-16
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = NursingCategory.class)
public class NursingCategoryVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 分类ID
     */
    @ExcelProperty(value = "分类ID")
    private Long categoryId;

    /**
     * 分类名称
     */
    @ExcelRequired
    @ExcelProperty(value = "分类名称")
    private String categoryName;

    /**
     * 分类编码
     */
    @ExcelRequired
    @ExcelProperty(value = "分类编码")
    private String categoryCode;

    /**
     * 父分类ID
     */
    @ExcelProperty(value = "父分类ID")
    private Long parentId;

    /**
     * 显示顺序
     */
    @ExcelRequired
    @ExcelProperty(value = "显示顺序")
    private Integer orderNum;

    /**
     * 分类状态（0正常 1停用）
     */
    @ExcelProperty(value = "分类状态", converter = org.dromara.common.excel.convert.ExcelDictConvert.class)
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