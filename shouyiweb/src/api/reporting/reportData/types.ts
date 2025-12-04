export interface ReportDataVO {
  /**
   * 填报数据ID
   */
  reportId: string | number;

  /**
   * 分类ID
   */
  categoryId: string | number;

  /**
   * 指标名称
   */
  indicatorName: string;

  /**
   * 指标编码
   */
  indicatorCode: string;

  /**
   * 数据值
   */
  dataValue: number;

  /**
   * 数据单位
   */
  dataUnit: string;

  /**
   * 统计周期（年/月/周/日）
   */
  statisticsCycle: string;

  /**
   * 统计开始时间
   */
  statisticsStartTime: string;

  /**
   * 统计结束时间
   */
  statisticsEndTime: string;

  /**
   * 填报年份
   */
  reportYear: number;

  /**
   * 填报季度
   */
  reportSeason: number;

  /**
   * 填报科室ID
   */
  deptId: string | number;

  /**
   * 填报人ID
   */
  reporterId: string | number;

  /**
   * 审核状态（0待审核 1已审核 2已退回）
   */
  auditStatus: string;

  /**
   * 审核人ID
   */
  auditorId: string | number;

  /**
   * 审核时间
   */
  auditTime: string;

  /**
   * 审核意见
   */
  auditComment: string;

  /**
   * 数据来源（0手工录入 1Excel导入 2系统自动获取）
   */
  dataSource: string;

  /**
   * 排序号
   */
  orderNum: number;

  /**
   * 状态（0正常 1停用）
   */
  status: string;

  /**
   * 备注
   */
  remark: string;

}

export interface ReportDataForm extends BaseEntity {
  /**
   * 填报数据ID
   */
  reportId?: string | number;

  /**
   * 分类ID
   */
  categoryId?: string | number;

  /**
   * 指标名称
   */
  indicatorName?: string;

  /**
   * 指标编码
   */
  indicatorCode?: string;

  /**
   * 数据值
   */
  dataValue?: number;

  /**
   * 数据单位
   */
  dataUnit?: string;

  /**
   * 统计周期（年/月/周/日）
   */
  statisticsCycle?: string;

  /**
   * 统计开始时间
   */
  statisticsStartTime?: string;

  /**
   * 统计结束时间
   */
  statisticsEndTime?: string;

  /**
   * 填报年份
   */
  reportYear?: number;

  /**
   * 填报季度
   */
  reportSeason?: number;

  /**
   * 填报科室ID
   */
  deptId?: string | number;

  /**
   * 填报人ID
   */
  reporterId?: string | number;

  /**
   * 审核状态（0待审核 1已审核 2已退回）
   */
  auditStatus?: string;

  /**
   * 审核人ID
   */
  auditorId?: string | number;

  /**
   * 审核时间
   */
  auditTime?: string;

  /**
   * 审核意见
   */
  auditComment?: string;

  /**
   * 数据来源（0手工录入 1Excel导入 2系统自动获取）
   */
  dataSource?: string;

  /**
   * 排序号
   */
  orderNum?: number;

  /**
   * 状态（0正常 1停用）
   */
  status?: string;

  /**
   * 备注
   */
  remark?: string;

}

export interface ReportDataQuery extends PageQuery {

  /**
   * 分类ID
   */
  categoryId?: string | number;

  /**
   * 指标名称
   */
  indicatorName?: string;

  /**
   * 指标编码
   */
  indicatorCode?: string;

  /**
   * 数据值
   */
  dataValue?: number;

  /**
   * 数据单位
   */
  dataUnit?: string;

  /**
   * 统计周期（年/月/周/日）
   */
  statisticsCycle?: string;

  /**
   * 统计开始时间
   */
  statisticsStartTime?: string;

  /**
   * 统计结束时间
   */
  statisticsEndTime?: string;

  /**
   * 填报年份
   */
  reportYear?: number;

  /**
   * 填报季度
   */
  reportSeason?: number;

  /**
   * 填报科室ID
   */
  deptId?: string | number;

  /**
   * 填报人ID
   */
  reporterId?: string | number;

  /**
   * 审核状态（0待审核 1已审核 2已退回）
   */
  auditStatus?: string;

  /**
   * 审核人ID
   */
  auditorId?: string | number;

  /**
   * 审核时间
   */
  auditTime?: string;

  /**
   * 审核意见
   */
  auditComment?: string;

  /**
   * 数据来源（0手工录入 1Excel导入 2系统自动获取）
   */
  dataSource?: string;

  /**
   * 排序号
   */
  orderNum?: number;

  /**
   * 状态（0正常 1停用）
   */
  status?: string;

    /**
     * 日期范围参数
     */
    params?: any;
}



