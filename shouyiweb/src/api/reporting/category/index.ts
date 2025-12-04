import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { CategoryVO, CategoryForm, CategoryQuery } from '@/api/reporting/category/types';

/**
 * 查询护理数据填报分类列表
 * @param query
 * @returns {*}
 */

export const listCategory = (query?: CategoryQuery): AxiosPromise<CategoryVO[]> => {
  return request({
    url: '/reporting/category/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询护理数据填报分类详细
 * @param categoryId
 */
export const getCategory = (categoryId: string | number): AxiosPromise<CategoryVO> => {
  return request({
    url: '/reporting/category/' + categoryId,
    method: 'get'
  });
};

/**
 * 新增护理数据填报分类
 * @param data
 */
export const addCategory = (data: CategoryForm) => {
  return request({
    url: '/reporting/category',
    method: 'post',
    data: data
  });
};

/**
 * 修改护理数据填报分类
 * @param data
 */
export const updateCategory = (data: CategoryForm) => {
  return request({
    url: '/reporting/category',
    method: 'put',
    data: data
  });
};

/**
 * 删除护理数据填报分类
 * @param categoryId
 */
export const delCategory = (categoryId: string | number | Array<string | number>) => {
  return request({
    url: '/reporting/category/' + categoryId,
    method: 'delete'
  });
};
