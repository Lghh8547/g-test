package org.dromara.reporting.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import org.dromara.common.mybatis.annotation.DataColumn;
import org.dromara.common.mybatis.annotation.DataPermission;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;
import org.dromara.reporting.domain.NursingReportData;
import org.dromara.reporting.domain.vo.NursingReportDataVo;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

/**
 * 护理数据填报Mapper接口
 *
 * @author ruoyi
 * @date 2025-09-16
 */
public interface NursingReportDataMapper extends BaseMapperPlus<NursingReportData, NursingReportDataVo> {

    @DataPermission({
        @DataColumn(key = "deptName", value = "dept_id"),
        @DataColumn(key = "userName", value = "reporter_id")
    })
    Page<NursingReportDataVo> customPageList(@Param("page") Page<NursingReportData> page, @Param("ew") Wrapper<NursingReportData> wrapper);

    @Override
    @DataPermission({
        @DataColumn(key = "deptName", value = "dept_id"),
        @DataColumn(key = "userName", value = "reporter_id")
    })
    default <P extends IPage<NursingReportDataVo>> P selectVoPage(IPage<NursingReportData> page, Wrapper<NursingReportData> wrapper) {
        return selectVoPage(page, wrapper, this.currentVoClass());
    }

    @Override
    @DataPermission({
        @DataColumn(key = "deptName", value = "dept_id"),
        @DataColumn(key = "userName", value = "reporter_id")
    })
    default List<NursingReportDataVo> selectVoList(Wrapper<NursingReportData> wrapper) {
        return selectVoList(wrapper, this.currentVoClass());
    }

    @Override
    @DataPermission(value = {
        @DataColumn(key = "deptName", value = "dept_id"),
        @DataColumn(key = "userName", value = "reporter_id")
    }, joinStr = "AND")
    List<NursingReportData> selectByIds(@Param(Constants.COLL) Collection<? extends Serializable> idList);

    @Override
    @DataPermission({
        @DataColumn(key = "deptName", value = "dept_id"),
        @DataColumn(key = "userName", value = "reporter_id")
    })
    int updateById(@Param(Constants.ENTITY) NursingReportData entity);

}