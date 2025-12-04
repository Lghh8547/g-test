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
import org.dromara.common.satoken.utils.LoginHelper;
import org.dromara.reporting.domain.NursingReportData;
import org.dromara.reporting.domain.bo.NursingCategoryBo;
import org.dromara.reporting.domain.bo.NursingReportDataBo;
import org.dromara.reporting.domain.bo.NursingReportDataImportVo;
import org.dromara.reporting.domain.vo.NursingCategoryVo;
import org.dromara.reporting.domain.vo.NursingReportDataVo;
import org.dromara.reporting.mapper.NursingReportDataMapper;
import org.dromara.reporting.service.INursingCategoryService;
import org.dromara.reporting.service.INursingReportDataService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 护理数据填报Service业务层处理
 *
 * @author ruoyi
 * @date 2025-09-16
 */
@RequiredArgsConstructor
@Service
public class NursingReportDataServiceImpl implements INursingReportDataService {

    private final NursingReportDataMapper baseMapper;
    private final INursingCategoryService nursingCategoryService;

    @Override
    public NursingReportDataVo queryById(Long reportId) {
        NursingReportDataVo res = baseMapper.selectVoById(reportId);
        NursingCategoryVo nursingCategory = nursingCategoryService.queryById(res.getCategoryId());
        if (nursingCategory != null) {
            res.setCategoryName(nursingCategory.getCategoryName());
        }
        return res;
    }

    @Override
    public TableDataInfo<NursingReportDataVo> queryPageList(NursingReportDataBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<NursingReportData> lqw = buildQueryWrapper(bo);
        Page<NursingReportDataVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        result.getRecords().forEach(item -> {
            NursingCategoryVo nursingCategory = nursingCategoryService.queryById(item.getCategoryId());
            if (nursingCategory != null) {
                item.setCategoryName(nursingCategory.getCategoryName());
            }
        });
        return TableDataInfo.build(result);
    }

    /**
     * 自定义分页查询
     */
    @Override
    public TableDataInfo<NursingReportDataVo> customPageList(NursingReportDataBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<NursingReportData> lqw = buildQueryWrapper(bo);
        Page<NursingReportDataVo> result = baseMapper.customPageList(pageQuery.build(), lqw);
        result.getRecords().forEach(item -> {
            NursingCategoryVo nursingCategory = nursingCategoryService.queryById(item.getCategoryId());
            if (nursingCategory != null) {
                item.setCategoryName(nursingCategory.getCategoryName());
            }
        });
        return TableDataInfo.build(result);
    }

    @Override
    public List<NursingReportDataVo> queryList(NursingReportDataBo bo) {
        return baseMapper.selectVoList(buildQueryWrapper(bo));
    }

    private LambdaQueryWrapper<NursingReportData> buildQueryWrapper(NursingReportDataBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<NursingReportData> lqw = Wrappers.lambdaQuery();

        lqw.eq(bo.getCategoryId() != null, NursingReportData::getCategoryId, bo.getCategoryId());
        lqw.like(StringUtils.isNotBlank(bo.getIndicatorName()), NursingReportData::getIndicatorName, bo.getIndicatorName());
        lqw.eq(StringUtils.isNotBlank(bo.getIndicatorCode()), NursingReportData::getIndicatorCode, bo.getIndicatorCode());
        lqw.eq(StringUtils.isNotBlank(bo.getStatisticsCycle()), NursingReportData::getStatisticsCycle, bo.getStatisticsCycle());
        lqw.eq(bo.getReportYear() != null, NursingReportData::getReportYear, bo.getReportYear());
        lqw.eq(bo.getReportSeason() != null, NursingReportData::getReportSeason, bo.getReportSeason());
        lqw.eq(bo.getDeptId() != null, NursingReportData::getDeptId, bo.getDeptId());
        lqw.eq(bo.getReporterId() != null, NursingReportData::getReporterId, bo.getReporterId());
        lqw.eq(StringUtils.isNotBlank(bo.getAuditStatus()), NursingReportData::getAuditStatus, bo.getAuditStatus());
        lqw.eq(StringUtils.isNotBlank(bo.getDataSource()), NursingReportData::getDataSource, bo.getDataSource());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), NursingReportData::getStatus, bo.getStatus());
        lqw.between(params.get("beginCreateTime") != null && params.get("endCreateTime") != null,
            NursingReportData::getCreateTime, params.get("beginCreateTime"), params.get("endCreateTime"));
        lqw.between(params.get("beginStatisticsStartTime") != null && params.get("endStatisticsStartTime") != null,
            NursingReportData::getStatisticsStartTime, params.get("beginStatisticsStartTime"), params.get("endStatisticsStartTime"));
        lqw.orderByAsc(NursingReportData::getOrderNum, NursingReportData::getReportId);
        return lqw;
    }

    @Override
    public Boolean insertByBo(NursingReportDataBo bo) {
        NursingReportData add = MapstructUtils.convert(bo, NursingReportData.class);
        validEntityBeforeSave(add);
        // 设置默认值
        if (StringUtils.isBlank(add.getAuditStatus())) {
            add.setAuditStatus("0"); // 默认待审核
        }
        if (StringUtils.isBlank(add.getDataSource())) {
            add.setDataSource("0"); // 默认手工录入
        }
        if (StringUtils.isBlank(add.getStatus())) {
            add.setStatus("0"); // 默认正常
        }
        if (add.getReporterId() == null) {
            add.setReporterId(LoginHelper.getUserId()); // 设置当前用户为填报人
        }
        if (add.getDeptId() == null) {
            add.setDeptId(LoginHelper.getDeptId()); // 设置当前部门为填报科室
        }
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setReportId(add.getReportId());
        }
        return flag;
    }

    @Override
    public Boolean updateByBo(NursingReportDataBo bo) {
        NursingReportData update = MapstructUtils.convert(bo, NursingReportData.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     *
     * @param entity 实体类数据
     */
    private void validEntityBeforeSave(NursingReportData entity) {
        // 检查指标编码在同一分类、同一时间段内的唯一性
        if (!checkIndicatorCodeUnique(entity.getIndicatorName(), entity.getReportId(),
            entity.getCategoryId(), entity.getReportYear(), entity.getReportSeason())) {
            throw new ServiceException("指标编码在同一分类同一时间段内已存在!");
        }
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // 做一些业务上的校验,判断是否需要校验
            List<NursingReportData> list = baseMapper.selectByIds(ids);
            if (list.size() != ids.size()) {
                throw new ServiceException("您没有删除权限!");
            }
            // 检查是否有已审核的数据
            for (NursingReportData data : list) {
                if ("1".equals(data.getAuditStatus())) {
                    throw new ServiceException("不能删除已审核的数据!");
                }
            }
        }
        return baseMapper.deleteByIds(ids) > 0;
    }

    @Override
    public Boolean saveBatch(List<NursingReportData> list) {
        return baseMapper.insertBatch(list);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean importReportData(List<NursingReportDataImportVo> list) {
        if (list == null || list.isEmpty()) {
            throw new ServiceException("导入数据不能为空!");
        }

        for (NursingReportDataImportVo importVo : list) {
            // 根据分类名称查找分类ID
            NursingCategoryVo category = nursingCategoryService.queryByCategoryName(importVo.getCategoryName());
            if (category == null) {
                // 如果分类不存在，则新增分类
                NursingCategoryBo categoryBo = new NursingCategoryBo();
                categoryBo.setCategoryName(importVo.getCategoryName());
                categoryBo.setCategoryCode("IMPORT_" + System.currentTimeMillis()); // 设置唯一编码
                categoryBo.setParentId(0L); // 默认父分类ID为0
                categoryBo.setOrderNum(0); // 默认排序
                categoryBo.setStatus("0"); // 默认正常状态
                categoryBo.setRemark("数据导入时自动创建");
                nursingCategoryService.insertByBo(categoryBo);

                // 重新查询新建的分类
                category = nursingCategoryService.queryByCategoryName(importVo.getCategoryName());
            }

            // 转换为实体对象
            NursingReportData reportData = new NursingReportData();
            reportData.setCategoryId(category.getCategoryId());
            reportData.setIndicatorName(importVo.getIndicatorName());
            reportData.setIndicatorCode(importVo.getIndicatorCode());
            reportData.setDataValue(importVo.getDataValue());
            reportData.setDataUnit(importVo.getDataUnit());
            reportData.setStatisticsCycle(importVo.getStatisticsCycle());
            reportData.setStatisticsStartTime(importVo.getStatisticsStartTime());
            reportData.setStatisticsEndTime(importVo.getStatisticsEndTime());
            reportData.setReportYear(importVo.getReportYear());
            reportData.setReportSeason(importVo.getReportSeason());
            reportData.setOrderNum(importVo.getOrderNum());
            reportData.setRemark(importVo.getRemark());

            // 设置默认值
            reportData.setAuditStatus("0"); // 待审核
            reportData.setDataSource("1"); // Excel导入
            reportData.setStatus("0"); // 正常
            reportData.setReporterId(LoginHelper.getUserId());
            reportData.setDeptId(LoginHelper.getDeptId());

            // 校验数据
            validEntityBeforeSave(reportData);

            // 保存数据
            baseMapper.insert(reportData);
        }

        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean auditReportData(Collection<Long> reportIds, String auditStatus, String auditComment) {
        if (reportIds == null || reportIds.isEmpty()) {
            throw new ServiceException("审核数据ID不能为空!");
        }

        Long auditorId = LoginHelper.getUserId();
        Date auditTime = new Date();

        for (Long reportId : reportIds) {
            NursingReportData reportData = baseMapper.selectById(reportId);
            if (reportData == null) {
                throw new ServiceException("填报数据不存在!");
            }

            if (!"0".equals(reportData.getAuditStatus())) {
                throw new ServiceException("只能审核待审核状态的数据!");
            }

            reportData.setAuditStatus(auditStatus);
            reportData.setAuditorId(auditorId);
            reportData.setAuditTime(auditTime);
            reportData.setAuditComment(auditComment);

            baseMapper.updateById(reportData);
        }

        return true;
    }

    @Override
    public boolean checkIndicatorCodeUnique(String indicatorName, Long reportId, Long categoryId, Integer reportYear, Integer reportSeason) {
        LambdaQueryWrapper<NursingReportData> lqw = Wrappers.lambdaQuery();
        lqw.eq(NursingReportData::getIndicatorName, indicatorName);
        lqw.eq(NursingReportData::getCategoryId, categoryId);
        lqw.eq(NursingReportData::getReportYear, reportYear);
        if (reportSeason != null) {
            lqw.eq(NursingReportData::getReportSeason, reportSeason);
        }
        if (reportId != null) {
            lqw.ne(NursingReportData::getReportId, reportId);
        }
        long count = baseMapper.selectCount(lqw);
        return count == 0;
    }
}
