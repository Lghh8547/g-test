export interface CategoryVO {
  /**
   * 分类ID
   */
  categoryId: string | number;

  /**
   * 分类名称
   */
  categoryName: string;

  /**
   * 分类编码
   */
  categoryCode: string;

  /**
   * 父分类ID
   */
  parentId: string | number;

  /**
   * 显示顺序
   */
  orderNum: number;

  /**
   * 分类状态（0正常 1停用）
   */
  status: string;

  /**
   * 备注
   */
  remark: string;

}

export interface CategoryForm extends BaseEntity {
  /**
   * 分类ID
   */
  categoryId?: string | number;

  /**
   * 分类名称
   */
  categoryName?: string;

  /**
   * 分类编码
   */
  categoryCode?: string;

  /**
   * 父分类ID
   */
  parentId?: string | number;

  /**
   * 显示顺序
   */
  orderNum?: number;

  /**
   * 分类状态（0正常 1停用）
   */
  status?: string;

  /**
   * 备注
   */
  remark?: string;

}

export interface CategoryQuery extends PageQuery {

  /**
   * 分类名称
   */
  categoryName?: string;

  /**
   * 分类编码
   */
  categoryCode?: string;

  /**
   * 父分类ID
   */
  parentId?: string | number;

  /**
   * 显示顺序
   */
  orderNum?: number;

  /**
   * 分类状态（0正常 1停用）
   */
  status?: string;

    /**
     * 日期范围参数
     */
    params?: any;
}



