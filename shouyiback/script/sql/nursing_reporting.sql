-- 护理数据填报分类表
CREATE TABLE nursing_category (
    category_id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '分类ID',
    category_name VARCHAR(100) NOT NULL COMMENT '分类名称',
    category_code VARCHAR(50) NOT NULL COMMENT '分类编码',
    parent_id BIGINT(20) DEFAULT NULL COMMENT '父分类ID',
    order_num INT(4) DEFAULT 0 COMMENT '显示顺序',
    status CHAR(1) DEFAULT '0' COMMENT '分类状态（0正常 1停用）',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    version INT(11) DEFAULT 0 COMMENT '版本',
    tenant_id VARCHAR(20) DEFAULT '000000' COMMENT '租户编号',
    create_dept BIGINT(20) DEFAULT NULL COMMENT '创建部门',
    create_time DATETIME DEFAULT NULL COMMENT '创建时间',
    create_by BIGINT(20) DEFAULT NULL COMMENT '创建人',
    update_time DATETIME DEFAULT NULL COMMENT '更新时间',
    update_by BIGINT(20) DEFAULT NULL COMMENT '更新人',
    del_flag INT(1) DEFAULT 0 COMMENT '删除标志',
    PRIMARY KEY (category_id),
    UNIQUE KEY uk_nursing_category_code (category_code),
    INDEX idx_nursing_category_parent (parent_id),
    INDEX idx_nursing_category_status (status),
    INDEX idx_nursing_category_order (order_num)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='护理数据填报分类表';

-- 护理数据填报主表
CREATE TABLE nursing_report_data (
    report_id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '填报数据ID',
    category_id BIGINT(20) NOT NULL COMMENT '分类ID',
    indicator_name VARCHAR(200) NOT NULL COMMENT '指标名称',
    indicator_code VARCHAR(100) NOT NULL COMMENT '指标编码',
    data_value DECIMAL(18,4) NOT NULL COMMENT '数据值',
    data_unit VARCHAR(50) DEFAULT NULL COMMENT '数据单位',
    statistics_cycle VARCHAR(20) DEFAULT NULL COMMENT '统计周期（年/月/周/日）',
    statistics_start_time DATE DEFAULT NULL COMMENT '统计开始时间',
    statistics_end_time DATE DEFAULT NULL COMMENT '统计结束时间',
    report_year INT(4) NOT NULL COMMENT '填报年份',
    report_season INT(2) DEFAULT NULL COMMENT '填报季度',
    dept_id BIGINT(20) DEFAULT NULL COMMENT '填报科室ID',
    reporter_id BIGINT(20) DEFAULT NULL COMMENT '填报人ID',
    audit_status CHAR(1) DEFAULT '0' COMMENT '审核状态（0待审核 1已审核 2已退回）',
    auditor_id BIGINT(20) DEFAULT NULL COMMENT '审核人ID',
    audit_time DATETIME DEFAULT NULL COMMENT '审核时间',
    audit_comment VARCHAR(500) DEFAULT NULL COMMENT '审核意见',
    data_source CHAR(1) DEFAULT '0' COMMENT '数据来源（0手工录入 1Excel导入 2系统自动获取）',
    order_num INT(4) DEFAULT 0 COMMENT '排序号',
    status CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    version INT(11) DEFAULT 0 COMMENT '版本',
    tenant_id VARCHAR(20) DEFAULT '000000' COMMENT '租户编号',
    create_dept BIGINT(20) DEFAULT NULL COMMENT '创建部门',
    create_time DATETIME DEFAULT NULL COMMENT '创建时间',
    create_by BIGINT(20) DEFAULT NULL COMMENT '创建人',
    update_time DATETIME DEFAULT NULL COMMENT '更新时间',
    update_by BIGINT(20) DEFAULT NULL COMMENT '更新人',
    del_flag INT(1) DEFAULT 0 COMMENT '删除标志',
    PRIMARY KEY (report_id),
    FOREIGN KEY fk_nursing_report_category (category_id) REFERENCES nursing_category(category_id),
    UNIQUE KEY uk_nursing_report_indicator (category_id, indicator_code, report_year, report_season),
    INDEX idx_nursing_report_category (category_id),
    INDEX idx_nursing_report_year_month (report_year, report_season),
    INDEX idx_nursing_report_dept (dept_id),
    INDEX idx_nursing_report_reporter (reporter_id),
    INDEX idx_nursing_report_audit_status (audit_status),
    INDEX idx_nursing_report_data_source (data_source),
    INDEX idx_nursing_report_status (status),
    INDEX idx_nursing_report_order (order_num)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='护理数据填报表';

-- 插入一些初始分类数据
INSERT INTO nursing_category (category_name, category_code, parent_id, order_num, status, remark, tenant_id, create_time, create_by) VALUES
('护理人力资源', 'NURSING_HR', NULL, 1, '0', '护理人力资源相关数据', '000000', NOW(), 1),
('护理质量管理', 'NURSING_QUALITY', NULL, 2, '0', '护理质量管理相关数据', '000000', NOW(), 1),
('护理教育培训', 'NURSING_EDUCATION', NULL, 3, '0', '护理教育培训相关数据', '000000', NOW(), 1),
('护理科研', 'NURSING_RESEARCH', NULL, 4, '0', '护理科研相关数据', '000000', NOW(), 1),
('护理安全', 'NURSING_SAFETY', NULL, 5, '0', '护理安全相关数据', '000000', NOW(), 1),
('护理满意度', 'NURSING_SATISFACTION', NULL, 6, '0', '护理满意度相关数据', '000000', NOW(), 1);

-- 插入一些示例数据
INSERT INTO nursing_report_data (category_id, indicator_name, indicator_code, data_value, data_unit, statistics_cycle, 
    report_year, report_season, audit_status, data_source, order_num, status, remark, tenant_id, create_time, create_by) VALUES
(1, '护士总数', 'NURSE_TOTAL_COUNT', 150.0000, '人', '月', 2025, 9, '0', '0', 1, '0', '全院护士总数统计', '000000', NOW(), 1),
(1, '注册护士数', 'REGISTERED_NURSE_COUNT', 145.0000, '人', '月', 2025, 9, '0', '0', 2, '0', '全院注册护士数统计', '000000', NOW(), 1),
(1, '护士离职率', 'NURSE_TURNOVER_RATE', 5.2000, '%', '月', 2025, 9, '0', '0', 3, '0', '全院护士离职率统计', '000000', NOW(), 1),
(2, '护理不良事件发生率', 'NURSING_ADVERSE_EVENT_RATE', 2.1000, '%', '月', 2025, 9, '0', '0', 1, '0', '全院护理不良事件发生率', '000000', NOW(), 1),
(2, '护理质量评分', 'NURSING_QUALITY_SCORE', 95.8000, '分', '月', 2025, 9, '0', '0', 2, '0', '全院护理质量评分', '000000', NOW(), 1),
(6, '护理满意度', 'NURSING_SATISFACTION_RATE', 98.5000, '%', '月', 2025, 9, '0', '0', 1, '0', '患者护理满意度调查', '000000', NOW(), 1);