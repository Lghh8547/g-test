package org.dromara.reporting.service;

import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.reporting.domain.NursingReportData;
import org.dromara.reporting.domain.bo.NursingReportDataBo;
import org.dromara.reporting.domain.bo.NursingReportDataImportVo;
import org.dromara.reporting.domain.vo.NursingReportDataVo;

import java.util.Collection;
import java.util.List;

/**
 * 护理数据填报Service接口
 *
 * @author ruoyi
 * @date 2025-09-16
 */
public interface INursingReportDataService {

    /**
     * 查询单个
     *
     * @param reportId 主键
     * @return
     */
    NursingReportDataVo queryById(Long reportId);

    /**
     * 查询列表
     */
    TableDataInfo<NursingReportDataVo> queryPageList(NursingReportDataBo bo, PageQuery pageQuery);

    /**
     * 自定义分页查询
     */
    TableDataInfo<NursingReportDataVo> customPageList(NursingReportDataBo bo, PageQuery pageQuery);

    /**
     * 查询列表
     */
    List<NursingReportDataVo> queryList(NursingReportDataBo bo);

    /**
     * 根据新增业务对象插入护理数据填报
     *
     * @param bo 护理数据填报新增业务对象
     * @return
     */
    Boolean insertByBo(NursingReportDataBo bo);

    /**
     * 根据编辑业务对象修改护理数据填报
     *
     * @param bo 护理数据填报编辑业务对象
     * @return
     */
    Boolean updateByBo(NursingReportDataBo bo);

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
    Boolean saveBatch(List<NursingReportData> list);

    /**
     * 导入护理数据填报数据
     *
     * @param list 导入数据列表
     * @return
     */
    Boolean importReportData(List<NursingReportDataImportVo> list);

    /**
     * 审核护理数据
     *
     * @param reportIds 填报数据ID集合
     * @param auditStatus 审核状态
     * @param auditComment 审核意见
     * @return
     */
    Boolean auditReportData(Collection<Long> reportIds, String auditStatus, String auditComment);

    /**
     * 检查指标编码是否唯一
     *
     * @param indicatorCode 指标编码
     * @param reportId      填报ID
     * @param categoryId    分类ID
     * @param reportYear    填报年份
     * @param reportSeason   填报季度
     * @return
     */
    boolean checkIndicatorCodeUnique(String indicatorCode, Long reportId, Long categoryId, Integer reportYear, Integer reportSeason);
}