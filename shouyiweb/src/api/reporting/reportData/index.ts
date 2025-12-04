import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { ReportDataVO, ReportDataForm, ReportDataQuery } from '@/api/reporting/reportData/types';

/**
 * 查询护理数据填报列表
 * @param query
 * @returns {*}
 */

export const listReportData = (query?: ReportDataQuery): AxiosPromise<ReportDataVO[]> => {
  return request({
    url: '/reporting/data/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询护理数据填报详细
 * @param reportId
 */
export const getReportData = (reportId: string | number): AxiosPromise<ReportDataVO> => {
  return request({
    url: '/reporting/data/' + reportId,
    method: 'get'
  });
};

/**
 * 新增护理数据填报
 * @param data
 */
export const addReportData = (data: ReportDataForm) => {
  return request({
    url: '/reporting/data',
    method: 'post',
    data: data
  });
};

/**
 * 修改护理数据填报
 * @param data
 */
export const updateReportData = (data: ReportDataForm) => {
  return request({
    url: '/reporting/data',
    method: 'put',
    data: data
  });
};

/**
 * 删除护理数据填报
 * @param reportId
 */
export const delReportData = (reportId: string | number | Array<string | number>) => {
  return request({
    url: '/reporting/data/' + reportId,
    method: 'delete'
  });
};
