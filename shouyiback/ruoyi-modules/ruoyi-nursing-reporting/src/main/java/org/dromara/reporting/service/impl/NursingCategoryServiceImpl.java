package org.dromara.reporting.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.exception.ServiceException;
import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.reporting.domain.NursingCategory;
import org.dromara.reporting.domain.bo.NursingCategoryBo;
import org.dromara.reporting.domain.vo.NursingCategoryVo;
import org.dromara.reporting.mapper.NursingCategoryMapper;
import org.dromara.reporting.service.INursingCategoryService;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * 护理数据填报分类Service业务层处理
 *
 * @author ruoyi
 * @date 2025-09-16
 */
@RequiredArgsConstructor
@Service
public class NursingCategoryServiceImpl implements INursingCategoryService {

    private final NursingCategoryMapper baseMapper;

    @Override
    public NursingCategoryVo queryById(Long categoryId) {
        return baseMapper.selectVoById(categoryId);
    }

    @Override
    public TableDataInfo<NursingCategoryVo> queryPageList(NursingCategoryBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<NursingCategory> lqw = buildQueryWrapper(bo);
        Page<NursingCategoryVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 自定义分页查询
     */
    @Override
    public TableDataInfo<NursingCategoryVo> customPageList(NursingCategoryBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<NursingCategory> lqw = buildQueryWrapper(bo);
        Page<NursingCategoryVo> result = baseMapper.customPageList(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<NursingCategoryVo> queryList(NursingCategoryBo bo) {
        return baseMapper.selectVoList(buildQueryWrapper(bo));
    }

    private LambdaQueryWrapper<NursingCategory> buildQueryWrapper(NursingCategoryBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<NursingCategory> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getCategoryName()), NursingCategory::getCategoryName, bo.getCategoryName());
        lqw.eq(StringUtils.isNotBlank(bo.getCategoryCode()), NursingCategory::getCategoryCode, bo.getCategoryCode());
        lqw.eq(bo.getParentId() != null, NursingCategory::getParentId, bo.getParentId());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), NursingCategory::getStatus, bo.getStatus());
        lqw.between(params.get("beginCreateTime") != null && params.get("endCreateTime") != null,
            NursingCategory::getCreateTime, params.get("beginCreateTime"), params.get("endCreateTime"));
        lqw.orderByAsc(NursingCategory::getOrderNum, NursingCategory::getCategoryId);
        return lqw;
    }

    @Override
    public Boolean insertByBo(NursingCategoryBo bo) {
        NursingCategory add = MapstructUtils.convert(bo, NursingCategory.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setCategoryId(add.getCategoryId());
        }
        return flag;
    }

    @Override
    public Boolean updateByBo(NursingCategoryBo bo) {
        NursingCategory update = MapstructUtils.convert(bo, NursingCategory.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     *
     * @param entity 实体类数据
     */
    private void validEntityBeforeSave(NursingCategory entity) {
        // 检查分类编码唯一性
        if (!checkCategoryCodeUnique(entity.getCategoryCode(), entity.getCategoryId())) {
            throw new ServiceException("分类编码已存在!");
        }
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // 做一些业务上的校验,判断是否需要校验
            List<NursingCategory> list = baseMapper.selectByIds(ids);
            if (list.size() != ids.size()) {
                throw new ServiceException("您没有删除权限!");
            }
        }
        return baseMapper.deleteByIds(ids) > 0;
    }

    @Override
    public Boolean saveBatch(List<NursingCategory> list) {
        return baseMapper.insertBatch(list);
    }

    @Override
    public NursingCategoryVo queryByCategoryName(String categoryName) {
        LambdaQueryWrapper<NursingCategory> lqw = Wrappers.lambdaQuery();
        lqw.eq(NursingCategory::getCategoryName, categoryName);
        lqw.eq(NursingCategory::getStatus, "0"); // 只查询正常状态的分类
        lqw.last("LIMIT 1");
        return baseMapper.selectVoOne(lqw);
    }

    @Override
    public boolean checkCategoryCodeUnique(String categoryCode, Long categoryId) {
        LambdaQueryWrapper<NursingCategory> lqw = Wrappers.lambdaQuery();
        lqw.eq(NursingCategory::getCategoryCode, categoryCode);
        if (categoryId != null) {
            lqw.ne(NursingCategory::getCategoryId, categoryId);
        }
        long count = baseMapper.selectCount(lqw);
        return count == 0;
    }
}