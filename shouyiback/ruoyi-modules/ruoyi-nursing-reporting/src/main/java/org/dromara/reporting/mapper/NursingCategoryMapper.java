package org.dromara.reporting.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import org.dromara.common.mybatis.annotation.DataColumn;
import org.dromara.common.mybatis.annotation.DataPermission;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;
import org.dromara.reporting.domain.NursingCategory;
import org.dromara.reporting.domain.vo.NursingCategoryVo;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

/**
 * 护理数据填报分类Mapper接口
 *
 * @author ruoyi
 * @date 2025-09-16
 */
public interface NursingCategoryMapper extends BaseMapperPlus<NursingCategory, NursingCategoryVo> {

    @DataPermission({
        @DataColumn(key = "deptName", value = "create_dept")
    })
    Page<NursingCategoryVo> customPageList(@Param("page") Page<NursingCategory> page, @Param("ew") Wrapper<NursingCategory> wrapper);

    @Override
    @DataPermission({
        @DataColumn(key = "deptName", value = "create_dept")
    })
    default <P extends IPage<NursingCategoryVo>> P selectVoPage(IPage<NursingCategory> page, Wrapper<NursingCategory> wrapper) {
        return selectVoPage(page, wrapper, this.currentVoClass());
    }

    @Override
    @DataPermission({
        @DataColumn(key = "deptName", value = "create_dept")
    })
    default List<NursingCategoryVo> selectVoList(Wrapper<NursingCategory> wrapper) {
        return selectVoList(wrapper, this.currentVoClass());
    }

    @Override
    @DataPermission(value = {
        @DataColumn(key = "deptName", value = "create_dept")
    }, joinStr = "AND")
    List<NursingCategory> selectByIds(@Param(Constants.COLL) Collection<? extends Serializable> idList);

    @Override
    @DataPermission({
        @DataColumn(key = "deptName", value = "create_dept")
    })
    int updateById(@Param(Constants.ENTITY) NursingCategory entity);

}