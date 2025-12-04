package org.dromara.reporting.service;

import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.reporting.domain.NursingCategory;
import org.dromara.reporting.domain.bo.NursingCategoryBo;
import org.dromara.reporting.domain.vo.NursingCategoryVo;

import java.util.Collection;
import java.util.List;

/**
 * 护理数据填报分类Service接口
 *
 * @author ruoyi
 * @date 2025-09-16
 */
public interface INursingCategoryService {

    /**
     * 查询单个
     *
     * @param categoryId 主键
     * @return
     */
    NursingCategoryVo queryById(Long categoryId);

    /**
     * 查询列表
     */
    TableDataInfo<NursingCategoryVo> queryPageList(NursingCategoryBo bo, PageQuery pageQuery);

    /**
     * 自定义分页查询
     */
    TableDataInfo<NursingCategoryVo> customPageList(NursingCategoryBo bo, PageQuery pageQuery);

    /**
     * 查询列表
     */
    List<NursingCategoryVo> queryList(NursingCategoryBo bo);

    /**
     * 根据新增业务对象插入护理数据填报分类
     *
     * @param bo 护理数据填报分类新增业务对象
     * @return
     */
    Boolean insertByBo(NursingCategoryBo bo);

    /**
     * 根据编辑业务对象修改护理数据填报分类
     *
     * @param bo 护理数据填报分类编辑业务对象
     * @return
     */
    Boolean updateByBo(NursingCategoryBo bo);

    /**
     * 校验并删除数据
     *
     * @param ids     主键集合
     * @param isValid 是否校验,true-删除前校验,false-不校验
     * @return
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 批量保存
     */
    Boolean saveBatch(List<NursingCategory> list);

    /**
     * 根据分类名称查询分类
     *
     * @param categoryName 分类名称
     * @return
     */
    NursingCategoryVo queryByCategoryName(String categoryName);

    /**
     * 检查分类编码是否唯一
     *
     * @param categoryCode 分类编码
     * @param categoryId   分类ID
     * @return
     */
    boolean checkCategoryCodeUnique(String categoryCode, Long categoryId);
}