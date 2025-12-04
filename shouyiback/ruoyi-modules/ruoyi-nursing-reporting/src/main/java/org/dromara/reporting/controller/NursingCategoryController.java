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
import org.dromara.common.excel.utils.ExcelUtil;
import org.dromara.common.idempotent.annotation.RepeatSubmit;
import org.dromara.common.log.annotation.Log;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.web.core.BaseController;
import org.dromara.reporting.domain.bo.NursingCategoryBo;
import org.dromara.reporting.domain.vo.NursingCategoryVo;
import org.dromara.reporting.service.INursingCategoryService;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 护理数据填报分类Controller
 *
 * @author ruoyi
 * @date 2025-09-16
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/reporting/category")
public class NursingCategoryController extends BaseController {

    private final INursingCategoryService nursingCategoryService;

    /**
     * 查询护理数据填报分类列表
     */
    @SaCheckPermission("reporting:category:list")
    @GetMapping("/list")
    public TableDataInfo<NursingCategoryVo> list(@Validated(QueryGroup.class) NursingCategoryBo bo, PageQuery pageQuery) {
        return nursingCategoryService.queryPageList(bo, pageQuery);
    }

    /**
     * 自定义分页查询
     */
    @SaCheckPermission("reporting:category:list")
    @GetMapping("/page")
    public TableDataInfo<NursingCategoryVo> page(@Validated(QueryGroup.class) NursingCategoryBo bo, PageQuery pageQuery) {
        return nursingCategoryService.customPageList(bo, pageQuery);
    }

    /**
     * 导出护理数据填报分类列表
     */
    @SaCheckPermission("reporting:category:export")
    @Log(title = "护理数据填报分类", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(@Validated NursingCategoryBo bo, HttpServletResponse response) {
        List<NursingCategoryVo> list = nursingCategoryService.queryList(bo);
        ExcelUtil.exportExcel(list, "护理数据填报分类", NursingCategoryVo.class, response);
    }

    /**
     * 获取护理数据填报分类详细信息
     *
     * @param categoryId 主键
     */
    @SaCheckPermission("reporting:category:query")
    @GetMapping("/{categoryId}")
    public R<NursingCategoryVo> getInfo(@NotNull(message = "主键不能为空")
                                        @PathVariable("categoryId") Long categoryId) {
        return R.ok(nursingCategoryService.queryById(categoryId));
    }

    /**
     * 新增护理数据填报分类
     */
    @SaCheckPermission("reporting:category:add")
    @Log(title = "护理数据填报分类", businessType = BusinessType.INSERT)
    @RepeatSubmit(interval = 2, timeUnit = TimeUnit.SECONDS, message = "{repeat.submit.message}")
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody NursingCategoryBo bo) {
        return toAjax(nursingCategoryService.insertByBo(bo));
    }

    /**
     * 修改护理数据填报分类
     */
    @SaCheckPermission("reporting:category:edit")
    @Log(title = "护理数据填报分类", businessType = BusinessType.UPDATE)
    @RepeatSubmit
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody NursingCategoryBo bo) {
        return toAjax(nursingCategoryService.updateByBo(bo));
    }

    /**
     * 删除护理数据填报分类
     *
     * @param categoryIds 主键串
     */
    @SaCheckPermission("reporting:category:remove")
    @Log(title = "护理数据填报分类", businessType = BusinessType.DELETE)
    @DeleteMapping("/{categoryIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] categoryIds) {
        return toAjax(nursingCategoryService.deleteWithValidByIds(Arrays.asList(categoryIds), true));
    }

    /**
     * 检查分类编码是否唯一
     */
    @GetMapping("/checkCategoryCodeUnique")
    public R<Boolean> checkCategoryCodeUnique(String categoryCode, Long categoryId) {
        return R.ok(nursingCategoryService.checkCategoryCodeUnique(categoryCode, categoryId));
    }
}