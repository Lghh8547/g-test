# 护理数据填报模块使用说明

## 模块概述

护理数据填报模块是基于若依RuoYi-Vue-Plus框架开发的护理数据管理系统，主要用于医院护理部门的数据填报、审核和管理。

## 功能特性

### 1. 分类管理
- **护理数据分类管理**：支持多级分类，可以灵活组织护理数据
- **分类编码管理**：每个分类都有唯一的编码，便于数据统计和查询
- **分类状态控制**：支持启用/停用分类

### 2. 数据填报
- **手工录入**：支持通过界面手工录入护理数据
- **Excel导入**：支持批量导入护理数据，提高录入效率
- **数据校验**：支持数据有效性校验，确保数据质量

### 3. 审核管理
- **数据审核**：支持多级审核流程
- **审核意见**：支持填写审核意见
- **状态跟踪**：实时跟踪数据审核状态

### 4. 权限控制
- **部门权限**：支持按部门控制数据访问权限
- **用户权限**：支持按用户控制操作权限
- **多租户支持**：支持多租户数据隔离

## 数据库设计

### 分类表 (nursing_category)
```sql
-- 护理数据填报分类表
CREATE TABLE nursing_category (
    category_id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '分类ID',
    category_name VARCHAR(100) NOT NULL COMMENT '分类名称',
    category_code VARCHAR(50) NOT NULL COMMENT '分类编码',
    parent_id BIGINT(20) DEFAULT NULL COMMENT '父分类ID',
    order_num INT(4) DEFAULT 0 COMMENT '显示顺序',
    status CHAR(1) DEFAULT '0' COMMENT '分类状态（0正常 1停用）',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    -- 通用字段
    version INT(11) DEFAULT 0 COMMENT '版本',
    tenant_id VARCHAR(20) DEFAULT '000000' COMMENT '租户编号',
    create_dept BIGINT(20) DEFAULT NULL COMMENT '创建部门',
    create_time DATETIME DEFAULT NULL COMMENT '创建时间',
    create_by BIGINT(20) DEFAULT NULL COMMENT '创建人',
    update_time DATETIME DEFAULT NULL COMMENT '更新时间',
    update_by BIGINT(20) DEFAULT NULL COMMENT '更新人',
    del_flag INT(1) DEFAULT 0 COMMENT '删除标志',
    PRIMARY KEY (category_id)
);
```

### 数据填报表 (nursing_report_data)
```sql
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
    -- 通用字段
    version INT(11) DEFAULT 0 COMMENT '版本',
    tenant_id VARCHAR(20) DEFAULT '000000' COMMENT '租户编号',
    create_dept BIGINT(20) DEFAULT NULL COMMENT '创建部门',
    create_time DATETIME DEFAULT NULL COMMENT '创建时间',
    create_by BIGINT(20) DEFAULT NULL COMMENT '创建人',
    update_time DATETIME DEFAULT NULL COMMENT '更新时间',
    update_by BIGINT(20) DEFAULT NULL COMMENT '更新人',
    del_flag INT(1) DEFAULT 0 COMMENT '删除标志',
    PRIMARY KEY (report_id)
);
```

## 部署指南

### 1. 数据库初始化
执行SQL脚本创建表结构：
```bash
mysql -u root -p your_database < script/sql/nursing_reporting.sql
```

### 2. 模块启用
在主项目的`pom.xml`中添加模块依赖：
```xml
<dependency>
    <groupId>org.dromara</groupId>
    <artifactId>ruoyi-nursing-reporting</artifactId>
    <version>5.4.1</version>
</dependency>
```

### 3. 权限配置
在系统管理中配置相应的菜单和权限：

#### 分类管理权限
- `reporting:category:list` - 查看分类列表
- `reporting:category:query` - 查看分类详情
- `reporting:category:add` - 新增分类
- `reporting:category:edit` - 编辑分类
- `reporting:category:remove` - 删除分类
- `reporting:category:export` - 导出分类

#### 数据填报权限
- `reporting:data:list` - 查看数据列表
- `reporting:data:query` - 查看数据详情
- `reporting:data:add` - 新增数据
- `reporting:data:edit` - 编辑数据
- `reporting:data:remove` - 删除数据
- `reporting:data:import` - 导入数据
- `reporting:data:export` - 导出数据
- `reporting:data:audit` - 审核数据

## API接口说明

### 分类管理接口

#### 查询分类列表
```
GET /reporting/category/list
```

#### 新增分类
```
POST /reporting/category
```

#### 修改分类
```
PUT /reporting/category
```

#### 删除分类
```
DELETE /reporting/category/{categoryIds}
```

### 数据填报接口

#### 查询数据列表
```
GET /reporting/data/list
```

#### 新增数据
```
POST /reporting/data
```

#### 修改数据
```
PUT /reporting/data
```

#### 删除数据
```
DELETE /reporting/data/{reportIds}
```

#### 导入数据
```
POST /reporting/data/importData
```

#### 审核数据
```
POST /reporting/data/audit
```

## Excel导入模板

Excel导入文件应包含以下列：

| 列名 | 说明 | 是否必填 | 示例 |
|------|------|----------|------|
| 分类 | 分类名称 | 是 | 护理人力资源 |
| 指标名称 | 指标的名称 | 是 | 护士总数 |
| 指标编码 | 指标的唯一编码 | 是 | NURSE_TOTAL_COUNT |
| 数据值 | 实际数据值 | 是 | 150 |
| 数据单位 | 数据的单位 | 否 | 人 |
| 统计周期 | 统计周期 | 否 | 月 |
| 统计开始时间 | 统计开始时间 | 否 | 2025-09-01 |
| 统计结束时间 | 统计结束时间 | 否 | 2025-09-30 |
| 填报年份 | 填报年份 | 是 | 2025 |
| 填报季度 | 填报季度 | 否 | 9 |
| 排序号 | 显示排序 | 否 | 1 |
| 备注 | 备注信息 | 否 | 全院护士总数统计 |

## 注意事项

1. **数据唯一性**：同一分类下，同一时间段内的指标编码必须唯一
2. **审核流程**：已审核的数据不能删除，需要先退回审核
3. **权限控制**：用户只能查看和操作自己部门的数据
4. **数据源标识**：系统会自动标识数据来源（手工录入/Excel导入/系统获取）
5. **多租户支持**：不同租户的数据完全隔离

## 扩展开发

如需扩展功能，可以参考以下文件：
- 实体类：`org.dromara.reporting.domain.*`
- 业务逻辑：`org.dromara.reporting.service.*`
- 控制器：`org.dromara.reporting.controller.*`
- 数据访问：`org.dromara.reporting.mapper.*`