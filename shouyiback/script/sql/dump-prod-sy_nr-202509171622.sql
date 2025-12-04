-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: sy.hshkyl.top    Database: sy_nr
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `flow_category`
--

DROP TABLE IF EXISTS `flow_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_category` (
  `category_id` bigint NOT NULL COMMENT '流程分类ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint DEFAULT '0' COMMENT '父流程分类id',
  `ancestors` varchar(500) DEFAULT '' COMMENT '祖级列表',
  `category_name` varchar(30) NOT NULL COMMENT '流程分类名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_category`
--

LOCK TABLES `flow_category` WRITE;
/*!40000 ALTER TABLE `flow_category` DISABLE KEYS */;
INSERT INTO `flow_category` VALUES (100,'000000',0,'0','OA审批',0,'0',103,1,'2025-09-16 17:35:15',NULL,NULL),(101,'000000',100,'0,100','假勤管理',0,'0',103,1,'2025-09-16 17:35:15',NULL,NULL),(102,'000000',100,'0,100','人事管理',1,'0',103,1,'2025-09-16 17:35:15',NULL,NULL),(103,'000000',101,'0,100,101','请假',0,'0',103,1,'2025-09-16 17:35:15',NULL,NULL),(104,'000000',101,'0,100,101','出差',1,'0',103,1,'2025-09-16 17:35:15',NULL,NULL),(105,'000000',101,'0,100,101','加班',2,'0',103,1,'2025-09-16 17:35:15',NULL,NULL),(106,'000000',101,'0,100,101','换班',3,'0',103,1,'2025-09-16 17:35:15',NULL,NULL),(107,'000000',101,'0,100,101','外出',4,'0',103,1,'2025-09-16 17:35:15',NULL,NULL),(108,'000000',102,'0,100,102','转正',1,'0',103,1,'2025-09-16 17:35:15',NULL,NULL),(109,'000000',102,'0,100,102','离职',2,'0',103,1,'2025-09-16 17:35:15',NULL,NULL);
/*!40000 ALTER TABLE `flow_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_definition`
--

DROP TABLE IF EXISTS `flow_definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_definition` (
  `id` bigint NOT NULL COMMENT '主键id',
  `flow_code` varchar(40) NOT NULL COMMENT '流程编码',
  `flow_name` varchar(100) NOT NULL COMMENT '流程名称',
  `category` varchar(100) DEFAULT NULL COMMENT '流程类别',
  `version` varchar(20) NOT NULL COMMENT '流程版本',
  `is_publish` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否发布（0未发布 1已发布 9失效）',
  `form_custom` char(1) DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) DEFAULT NULL COMMENT '审批表单路径',
  `activity_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '流程激活状态（0挂起 1激活）',
  `listener_type` varchar(100) DEFAULT NULL COMMENT '监听器类型',
  `listener_path` varchar(400) DEFAULT NULL COMMENT '监听器路径',
  `ext` varchar(500) DEFAULT NULL COMMENT '业务详情 存业务表对象json字符串',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程定义表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_definition`
--

LOCK TABLES `flow_definition` WRITE;
/*!40000 ALTER TABLE `flow_definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_definition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_his_task`
--

DROP TABLE IF EXISTS `flow_his_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_his_task` (
  `id` bigint NOT NULL COMMENT '主键id',
  `definition_id` bigint NOT NULL COMMENT '对应flow_definition表的id',
  `instance_id` bigint NOT NULL COMMENT '对应flow_instance表的id',
  `task_id` bigint NOT NULL COMMENT '对应flow_task表的id',
  `node_code` varchar(100) DEFAULT NULL COMMENT '开始节点编码',
  `node_name` varchar(100) DEFAULT NULL COMMENT '开始节点名称',
  `node_type` tinyint(1) DEFAULT NULL COMMENT '开始节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `target_node_code` varchar(200) DEFAULT NULL COMMENT '目标节点编码',
  `target_node_name` varchar(200) DEFAULT NULL COMMENT '结束节点名称',
  `approver` varchar(40) DEFAULT NULL COMMENT '审批者',
  `cooperate_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '协作方式(1审批 2转办 3委派 4会签 5票签 6加签 7减签)',
  `collaborator` varchar(40) DEFAULT NULL COMMENT '协作人',
  `skip_type` varchar(10) NOT NULL COMMENT '流转类型（PASS通过 REJECT退回 NONE无动作）',
  `flow_status` varchar(20) NOT NULL COMMENT '流程状态（0待提交 1审批中 2审批通过 4终止 5作废 6撤销 8已完成 9已退回 10失效 11拿回）',
  `form_custom` char(1) DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) DEFAULT NULL COMMENT '审批表单路径',
  `message` varchar(500) DEFAULT NULL COMMENT '审批意见',
  `variable` text COMMENT '任务变量',
  `ext` text COMMENT '业务详情 存业务表对象json字符串',
  `create_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `update_time` datetime DEFAULT NULL COMMENT '审批完成时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='历史任务记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_his_task`
--

LOCK TABLES `flow_his_task` WRITE;
/*!40000 ALTER TABLE `flow_his_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_his_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_instance`
--

DROP TABLE IF EXISTS `flow_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_instance` (
  `id` bigint NOT NULL COMMENT '主键id',
  `definition_id` bigint NOT NULL COMMENT '对应flow_definition表的id',
  `business_id` varchar(40) NOT NULL COMMENT '业务id',
  `node_type` tinyint(1) NOT NULL COMMENT '节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `node_code` varchar(40) NOT NULL COMMENT '流程节点编码',
  `node_name` varchar(100) DEFAULT NULL COMMENT '流程节点名称',
  `variable` text COMMENT '任务变量',
  `flow_status` varchar(20) NOT NULL COMMENT '流程状态（0待提交 1审批中 2审批通过 4终止 5作废 6撤销 8已完成 9已退回 10失效 11拿回）',
  `activity_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '流程激活状态（0挂起 1激活）',
  `def_json` text COMMENT '流程定义json',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `ext` varchar(500) DEFAULT NULL COMMENT '扩展字段，预留给业务系统使用',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程实例表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_instance`
--

LOCK TABLES `flow_instance` WRITE;
/*!40000 ALTER TABLE `flow_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_node`
--

DROP TABLE IF EXISTS `flow_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_node` (
  `id` bigint NOT NULL COMMENT '主键id',
  `node_type` tinyint(1) NOT NULL COMMENT '节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `definition_id` bigint NOT NULL COMMENT '流程定义id',
  `node_code` varchar(100) NOT NULL COMMENT '流程节点编码',
  `node_name` varchar(100) DEFAULT NULL COMMENT '流程节点名称',
  `permission_flag` varchar(200) DEFAULT NULL COMMENT '权限标识（权限类型:权限标识，可以多个，用@@隔开)',
  `node_ratio` decimal(6,3) DEFAULT NULL COMMENT '流程签署比例值',
  `coordinate` varchar(100) DEFAULT NULL COMMENT '坐标',
  `any_node_skip` varchar(100) DEFAULT NULL COMMENT '任意结点跳转',
  `listener_type` varchar(100) DEFAULT NULL COMMENT '监听器类型',
  `listener_path` varchar(400) DEFAULT NULL COMMENT '监听器路径',
  `handler_type` varchar(100) DEFAULT NULL COMMENT '处理器类型',
  `handler_path` varchar(400) DEFAULT NULL COMMENT '处理器路径',
  `form_custom` char(1) DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) DEFAULT NULL COMMENT '审批表单路径',
  `version` varchar(20) NOT NULL COMMENT '版本',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `ext` text COMMENT '节点扩展属性',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程节点表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_node`
--

LOCK TABLES `flow_node` WRITE;
/*!40000 ALTER TABLE `flow_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_skip`
--

DROP TABLE IF EXISTS `flow_skip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_skip` (
  `id` bigint NOT NULL COMMENT '主键id',
  `definition_id` bigint NOT NULL COMMENT '流程定义id',
  `now_node_code` varchar(100) NOT NULL COMMENT '当前流程节点的编码',
  `now_node_type` tinyint(1) DEFAULT NULL COMMENT '当前节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `next_node_code` varchar(100) NOT NULL COMMENT '下一个流程节点的编码',
  `next_node_type` tinyint(1) DEFAULT NULL COMMENT '下一个节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `skip_name` varchar(100) DEFAULT NULL COMMENT '跳转名称',
  `skip_type` varchar(40) DEFAULT NULL COMMENT '跳转类型（PASS审批通过 REJECT退回）',
  `skip_condition` varchar(200) DEFAULT NULL COMMENT '跳转条件',
  `coordinate` varchar(100) DEFAULT NULL COMMENT '坐标',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='节点跳转关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_skip`
--

LOCK TABLES `flow_skip` WRITE;
/*!40000 ALTER TABLE `flow_skip` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_skip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_task`
--

DROP TABLE IF EXISTS `flow_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_task` (
  `id` bigint NOT NULL COMMENT '主键id',
  `definition_id` bigint NOT NULL COMMENT '对应flow_definition表的id',
  `instance_id` bigint NOT NULL COMMENT '对应flow_instance表的id',
  `node_code` varchar(100) NOT NULL COMMENT '节点编码',
  `node_name` varchar(100) DEFAULT NULL COMMENT '节点名称',
  `node_type` tinyint(1) NOT NULL COMMENT '节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `flow_status` varchar(20) NOT NULL COMMENT '流程状态（0待提交 1审批中 2审批通过 4终止 5作废 6撤销 8已完成 9已退回 10失效 11拿回）',
  `form_custom` char(1) DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) DEFAULT NULL COMMENT '审批表单路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='待办任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_task`
--

LOCK TABLES `flow_task` WRITE;
/*!40000 ALTER TABLE `flow_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_user`
--

DROP TABLE IF EXISTS `flow_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_user` (
  `id` bigint NOT NULL COMMENT '主键id',
  `type` char(1) NOT NULL COMMENT '人员类型（1待办任务的审批人权限 2待办任务的转办人权限 3待办任务的委托人权限）',
  `processed_by` varchar(80) DEFAULT NULL COMMENT '权限人',
  `associated` bigint NOT NULL COMMENT '任务表id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(80) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_processed_type` (`processed_by`,`type`),
  KEY `user_associated` (`associated`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_user`
--

LOCK TABLES `flow_user` WRITE;
/*!40000 ALTER TABLE `flow_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL COMMENT '编号',
  `data_name` varchar(200) DEFAULT '' COMMENT '数据源名称',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
INSERT INTO `gen_table` VALUES (1967889159863349249,'master','nursing_category','护理数据填报分类表',NULL,NULL,'NursingCategory','crud','org.dromara.system','system','category','护理数据填报分类','Lion Li','0','/',NULL,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52',NULL),(1967889161171972097,'master','nursing_report_data','护理数据填报表',NULL,NULL,'NursingReportData','crud','org.dromara.system','system','reportData','护理数据填报','Lion Li','0','/',NULL,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52',NULL);
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
INSERT INTO `gen_table_column` VALUES (1967889160723181570,1967889159863349249,'category_id','分类ID','bigint','Long','categoryId','1','1','0',NULL,'1','1',NULL,'EQ','input','',1,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160790290433,1967889159863349249,'category_name','分类名称','varchar(100)','String','categoryName','0','0','0','1','1','1','1','LIKE','input','',2,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160790290434,1967889159863349249,'category_code','分类编码','varchar(50)','String','categoryCode','0','0','0','1','1','1','1','EQ','input','',3,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160790290435,1967889159863349249,'parent_id','父分类ID','bigint','Long','parentId','0','0','1','1','1','1','1','EQ','input','',4,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160790290436,1967889159863349249,'order_num','显示顺序','int','Long','orderNum','0','0','1','1','1','1','1','EQ','input','',5,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160790290437,1967889159863349249,'status','分类状态（0正常 1停用）','char(1)','String','status','0','0','1','1','1','1','1','EQ','radio','',6,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160790290438,1967889159863349249,'remark','备注','varchar(500)','String','remark','0','0','1','1','1','1',NULL,'EQ','textarea','',7,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160790290439,1967889159863349249,'version','版本','int','Long','version','0','0','1',NULL,NULL,NULL,NULL,'EQ','input','',8,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160790290440,1967889159863349249,'tenant_id','租户编号','varchar(20)','String','tenantId','0','0','1',NULL,NULL,NULL,NULL,'EQ','input','',9,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160857399298,1967889159863349249,'create_dept','创建部门','bigint','Long','createDept','0','0','1',NULL,NULL,NULL,NULL,'EQ','input','',10,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160857399299,1967889159863349249,'create_time','创建时间','datetime','Date','createTime','0','0','1',NULL,NULL,NULL,NULL,'EQ','datetime','',11,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160857399300,1967889159863349249,'create_by','创建人','bigint','Long','createBy','0','0','1',NULL,NULL,NULL,NULL,'EQ','input','',12,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160857399301,1967889159863349249,'update_time','更新时间','datetime','Date','updateTime','0','0','1',NULL,NULL,NULL,NULL,'EQ','datetime','',13,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160857399302,1967889159863349249,'update_by','更新人','bigint','Long','updateBy','0','0','1',NULL,NULL,NULL,NULL,'EQ','input','',14,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889160857399303,1967889159863349249,'del_flag','删除标志','int','Long','delFlag','0','0','1',NULL,NULL,NULL,NULL,'EQ','input','',15,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591746,1967889161171972097,'report_id','填报数据ID','bigint','Long','reportId','1','1','0',NULL,'1','1',NULL,'EQ','input','',1,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591747,1967889161171972097,'category_id','分类ID','bigint','Long','categoryId','0','0','0','1','1','1','1','EQ','input','',2,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591748,1967889161171972097,'indicator_name','指标名称','varchar(200)','String','indicatorName','0','0','0','1','1','1','1','LIKE','input','',3,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591749,1967889161171972097,'indicator_code','指标编码','varchar(100)','String','indicatorCode','0','0','0','1','1','1','1','EQ','input','',4,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591750,1967889161171972097,'data_value','数据值','decimal(18,4)','Long','dataValue','0','0','0','1','1','1','1','EQ','input','',5,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591751,1967889161171972097,'data_unit','数据单位','varchar(50)','String','dataUnit','0','0','1','1','1','1','1','EQ','input','',6,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591752,1967889161171972097,'statistics_cycle','统计周期（年/月/周/日）','varchar(20)','String','statisticsCycle','0','0','1','1','1','1','1','EQ','input','',7,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591753,1967889161171972097,'statistics_start_time','统计开始时间','date','Date','statisticsStartTime','0','0','1','1','1','1','1','EQ','datetime','',8,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591754,1967889161171972097,'statistics_end_time','统计结束时间','date','Date','statisticsEndTime','0','0','1','1','1','1','1','EQ','datetime','',9,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591755,1967889161171972097,'report_year','填报年份','int','Long','reportYear','0','0','0','1','1','1','1','EQ','input','',10,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591756,1967889161171972097,'report_month','填报月份','int','Long','reportMonth','0','0','1','1','1','1','1','EQ','input','',11,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591757,1967889161171972097,'dept_id','填报科室ID','bigint','Long','deptId','0','0','1','1','1','1','1','EQ','input','',12,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591758,1967889161171972097,'reporter_id','填报人ID','bigint','Long','reporterId','0','0','1','1','1','1','1','EQ','input','',13,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591759,1967889161171972097,'audit_status','审核状态（0待审核 1已审核 2已退回）','char(1)','String','auditStatus','0','0','1','1','1','1','1','EQ','radio','',14,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591760,1967889161171972097,'auditor_id','审核人ID','bigint','Long','auditorId','0','0','1','1','1','1','1','EQ','input','',15,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591761,1967889161171972097,'audit_time','审核时间','datetime','Date','auditTime','0','0','1','1','1','1','1','EQ','datetime','',16,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591762,1967889161171972097,'audit_comment','审核意见','varchar(500)','String','auditComment','0','0','1','1','1','1','1','EQ','textarea','',17,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591763,1967889161171972097,'data_source','数据来源（0手工录入 1Excel导入 2系统自动获取）','char(1)','String','dataSource','0','0','1','1','1','1','1','EQ','input','',18,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591764,1967889161171972097,'order_num','排序号','int','Long','orderNum','0','0','1','1','1','1','1','EQ','input','',19,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591765,1967889161171972097,'status','状态（0正常 1停用）','char(1)','String','status','0','0','1','1','1','1','1','EQ','radio','',20,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591766,1967889161171972097,'remark','备注','varchar(500)','String','remark','0','0','1','1','1','1',NULL,'EQ','textarea','',21,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591767,1967889161171972097,'version','版本','int','Long','version','0','0','1',NULL,NULL,NULL,NULL,'EQ','input','',22,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591768,1967889161171972097,'tenant_id','租户编号','varchar(20)','String','tenantId','0','0','1',NULL,NULL,NULL,NULL,'EQ','input','',23,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591769,1967889161171972097,'create_dept','创建部门','bigint','Long','createDept','0','0','1',NULL,NULL,NULL,NULL,'EQ','input','',24,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591770,1967889161171972097,'create_time','创建时间','datetime','Date','createTime','0','0','1',NULL,NULL,NULL,NULL,'EQ','datetime','',25,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591771,1967889161171972097,'create_by','创建人','bigint','Long','createBy','0','0','1',NULL,NULL,NULL,NULL,'EQ','input','',26,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591772,1967889161171972097,'update_time','更新时间','datetime','Date','updateTime','0','0','1',NULL,NULL,NULL,NULL,'EQ','datetime','',27,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161746591773,1967889161171972097,'update_by','更新人','bigint','Long','updateBy','0','0','1',NULL,NULL,NULL,NULL,'EQ','input','',28,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52'),(1967889161813700610,1967889161171972097,'del_flag','删除标志','int','Long','delFlag','0','0','1',NULL,NULL,NULL,NULL,'EQ','input','',29,103,1,'2025-09-16 17:51:52',1,'2025-09-16 17:51:52');
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nursing_category`
--

DROP TABLE IF EXISTS `nursing_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nursing_category` (
  `category_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` varchar(100) NOT NULL COMMENT '分类名称',
  `category_code` varchar(50) NOT NULL COMMENT '分类编码',
  `parent_id` bigint DEFAULT NULL COMMENT '父分类ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `status` char(1) DEFAULT '0' COMMENT '分类状态（0正常 1停用）',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `version` int DEFAULT '0' COMMENT '版本',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `del_flag` int DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uk_nursing_category_code` (`category_code`),
  KEY `idx_nursing_category_parent` (`parent_id`),
  KEY `idx_nursing_category_status` (`status`),
  KEY `idx_nursing_category_order` (`order_num`)
) ENGINE=InnoDB AUTO_INCREMENT=1967904699554123778 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='护理数据填报分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nursing_category`
--

LOCK TABLES `nursing_category` WRITE;
/*!40000 ALTER TABLE `nursing_category` DISABLE KEYS */;
INSERT INTO `nursing_category` VALUES (1,'护理人力资源','NURSING_HR',NULL,1,'0','护理人力资源相关数据',0,'000000',NULL,'2025-09-16 17:36:18',1,NULL,NULL,0),(2,'护理质量管理','NURSING_QUALITY',NULL,2,'0','护理质量管理相关数据',0,'000000',NULL,'2025-09-16 17:36:18',1,NULL,NULL,0),(3,'护理教育培训','NURSING_EDUCATION',NULL,3,'0','护理教育培训相关数据',0,'000000',NULL,'2025-09-16 17:36:18',1,NULL,NULL,0),(4,'护理科研','NURSING_RESEARCH',NULL,4,'0','护理科研相关数据',0,'000000',NULL,'2025-09-16 17:36:18',1,NULL,NULL,0),(5,'护理安全','NURSING_SAFETY',NULL,5,'0','护理安全相关数据',0,'000000',NULL,'2025-09-16 17:36:18',1,NULL,NULL,0),(6,'护理满意度','NURSING_SATISFACTION',NULL,6,'0','护理满意度相关数据',0,'000000',NULL,'2025-09-16 17:36:18',1,NULL,NULL,0),(1967904688908980226,'护士数量配置相关数据','IMPORT_1758020014388',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:34',1,'2025-09-16 18:53:34',1,0),(1967904689500377089,'人力资源结构--职称相关数据','IMPORT_1758020014523',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:35',1,'2025-09-16 18:53:35',1,0),(1967904690414735362,'人力资源结构--学历相关数据','IMPORT_1758020014736',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:35',1,'2025-09-16 18:53:35',1,0),(1967904691207458818,'人力资源结构--工作年限相关数据','IMPORT_1758020014934',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:35',1,'2025-09-16 18:53:35',1,0),(1967904692050513922,'离职相关数据','IMPORT_1758020015129',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:35',1,'2025-09-16 18:53:35',1,0),(1967904692797100034,'身体约束相关数据','IMPORT_1758020015311',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:35',1,'2025-09-16 18:53:35',1,0),(1967904693220724738,'跌倒相关数据','IMPORT_1758020015421',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:35',1,'2025-09-16 18:53:35',1,0),(1967904693745012737,'院内压力性损伤相关数据','IMPORT_1758020015534',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:36',1,'2025-09-16 18:53:36',1,0),(1967904694202191874,'导管非计划拔管相关数据','IMPORT_1758020015657',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:36',1,'2025-09-16 18:53:36',1,0),(1967904694906834946,'导管相关感染相关数据','IMPORT_1758020015815',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:36',1,'2025-09-16 18:53:36',1,0),(1967904695552757762,'呼吸机相关性肺炎相关数据','IMPORT_1758020015977',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:36',1,'2025-09-16 18:53:36',1,0),(1967904696261595137,'外周静脉短导管静脉炎相关数据','IMPORT_1758020016146',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:36',1,'2025-09-16 18:53:36',1,0),(1967904697029152769,'用药错误相关数据','IMPORT_1758020016315',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:36',1,'2025-09-16 18:53:36',1,0),(1967904697670881282,'药物渗出/药物外渗相关数据','IMPORT_1758020016483',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:36',1,'2025-09-16 18:53:36',1,0),(1967904698383912962,'输血错误相关数据','IMPORT_1758020016644',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:37',1,'2025-09-16 18:53:37',1,0),(1967904699096944641,'成人失禁相关性皮炎相关数据','IMPORT_1758020016812',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:37',1,'2025-09-16 18:53:37',1,0),(1967904699554123777,'烧伤/冻伤相关数据','IMPORT_1758020016919',0,0,'0','数据导入时自动创建',0,'000000',103,'2025-09-16 18:53:37',1,'2025-09-16 18:53:37',1,0);
/*!40000 ALTER TABLE `nursing_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nursing_report_data`
--

DROP TABLE IF EXISTS `nursing_report_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nursing_report_data` (
  `report_id` bigint NOT NULL AUTO_INCREMENT COMMENT '填报数据ID',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `indicator_name` varchar(200) NOT NULL COMMENT '指标名称',
  `indicator_code` varchar(100) NOT NULL COMMENT '指标编码',
  `data_value` decimal(18,0) NOT NULL COMMENT '数据值',
  `data_unit` varchar(50) DEFAULT NULL COMMENT '数据单位',
  `statistics_cycle` varchar(20) DEFAULT NULL COMMENT '统计周期（年/月/周/日）',
  `statistics_start_time` date DEFAULT NULL COMMENT '统计开始时间',
  `statistics_end_time` date DEFAULT NULL COMMENT '统计结束时间',
  `report_year` int NOT NULL COMMENT '填报年份',
  `report_season` int DEFAULT NULL COMMENT '填报季度',
  `dept_id` bigint DEFAULT NULL COMMENT '填报科室ID',
  `reporter_id` bigint DEFAULT NULL COMMENT '填报人ID',
  `audit_status` char(1) DEFAULT '0' COMMENT '审核状态（0待审核 1已审核 2已退回）',
  `auditor_id` bigint DEFAULT NULL COMMENT '审核人ID',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_comment` varchar(500) DEFAULT NULL COMMENT '审核意见',
  `data_source` char(1) DEFAULT '0' COMMENT '数据来源（0手工录入 1Excel导入 2系统自动获取）',
  `order_num` int DEFAULT '0' COMMENT '排序号',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `version` int DEFAULT '0' COMMENT '版本',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `del_flag` int DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `uk_nursing_report_indicator` (`category_id`,`indicator_code`,`report_year`,`report_season`),
  KEY `idx_nursing_report_category` (`category_id`),
  KEY `idx_nursing_report_year_month` (`report_year`,`report_season`),
  KEY `idx_nursing_report_dept` (`dept_id`),
  KEY `idx_nursing_report_reporter` (`reporter_id`),
  KEY `idx_nursing_report_audit_status` (`audit_status`),
  KEY `idx_nursing_report_data_source` (`data_source`),
  KEY `idx_nursing_report_status` (`status`),
  KEY `idx_nursing_report_order` (`order_num`),
  CONSTRAINT `nursing_report_data_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `nursing_category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1967911266844405763 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='护理数据填报表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nursing_report_data`
--

LOCK TABLES `nursing_report_data` WRITE;
/*!40000 ALTER TABLE `nursing_report_data` DISABLE KEYS */;
INSERT INTO `nursing_report_data` VALUES (1967911236947406849,1967904688908980226,'本季度实际开放床位数','1',43,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911237215842306,1967904688908980226,'季度初全院执业护士总人数','2',44,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911237467500545,1967904688908980226,'季度末全院执业护士总人数','3',62,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911237731741698,1967904688908980226,'季度初住院病区执业护士总人数','4',45,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911237987594241,1967904688908980226,'季度末住院病区执业护士总人数','5',63,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911238180532226,1967904688908980226,'季度初重症医学科执业护士总人数','6',46,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911238440579073,1967904688908980226,'季度末重症医学科执业护士总人数','7',64,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911238700625921,1967904688908980226,'本季度重症医学科实际开放床位数','8',47,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911238897758209,1967904688908980226,'季度初儿科病区执业护士总人数','9',48,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911239161999361,1967904688908980226,'季度末儿科病区执业护士总人数','10',66,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911239426240513,1967904688908980226,'本季度儿科病区实际开放床位数','11',49,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911239677898753,1967904688908980226,'本季度白班责任护士数','12',50,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911239875031042,1967904688908980226,'本季度白班护理患者数','13',532,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911240135077890,1967904688908980226,'本季度夜班责任护士数','14',51,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911240386736129,1967904688908980226,'本季度夜班护理患者数','15',533,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911240646782978,1967904688908980226,'本季度住院病区执业护士实际上班小时数','16',52,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:36',1,'2025-09-16 19:19:36',1,0),(1967911240835526657,1967904688908980226,'本季度住院患者实际占用床日数','17',534,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911241095573506,1967904688908980226,'季度初在院患者数','18',53,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911241292705794,1967904688908980226,'本季度新入院患者总数','19',535,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911241485643777,1967904688908980226,'季度初在院成人患者(≥18岁)数','20',54,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911241745690625,1967904688908980226,'本季度新入院成人患者(≥18岁)总数','21',536,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911241930240001,1967904688908980226,'本季度特级护理患者占用床日数','22',55,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911242190286849,1967904688908980226,'本季度一级护理患者占用床日数','23',537,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911242450333698,1967904688908980226,'本季度二级护理患者占用床日数','24',56,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911242643271682,1967904688908980226,'本季度三级护理患者占用床日数','25',538,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911242840403970,1967904689500377089,'季度初护士(初级)人数','26',57,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911243100450817,1967904689500377089,'季度末护士(初级)人数','27',539,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911243293388801,1967904689500377089,'季度初护师人数','28',58,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911243553435649,1967904689500377089,'季度末护师人数','29',540,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911243750567938,1967904689500377089,'季度初主管护师人数','30',59,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911244014809090,1967904689500377089,'季度末主管护师人数','31',541,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911244274855938,1967904689500377089,'季度初副主任护师人数','32',60,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911244543291394,1967904689500377089,'季度末副主任护师人数','33',542,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911244744617985,1967904689500377089,'季度初主任护师人数','34',61,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911244929167361,1967904689500377089,'季度末主任护师人数','35',543,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:37',1,'2025-09-16 19:19:37',1,0),(1967911245126299650,1967904689500377089,'季度初各职称护士总人数（26+28+30+32+34）','36',62,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911245386346498,1967904689500377089,'季度末各职称护士总人数（27+29+31+33+35）','37',544,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911245570895873,1967904690414735362,'季度初中专护士人数','38',63,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911245830942722,1967904690414735362,'季度末中专护士人数','39',545,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911246023880705,1967904690414735362,'季度初大专护士人数','40',64,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911246288121857,1967904690414735362,'季度末大专护士人数','41',546,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911246489448449,1967904690414735362,'季度初本科护士人数','42',65,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911246749495298,1967904690414735362,'季度末本科护士人数','43',547,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911246942433281,1967904690414735362,'季度初硕士护士人数','44',66,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911247202480129,1967904690414735362,'季度末硕士护士人数','45',548,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911247458332673,1967904690414735362,'季度初博士护士人数','46',67,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911247655464961,1967904690414735362,'季度末博士护士人数','47',549,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911247856791554,1967904690414735362,'季度初各学历护士总人数（38+40+42+44+46）','48',68,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911248112644098,1967904690414735362,'季度末各学历护士总人数（39+41+43+45+47）','49',550,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911248305582081,1967904691207458818,'季度初<1年资护士人数','50',69,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911248494325762,1967904691207458818,'季度末<1年资护士人数','51',551,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911248687263745,1967904691207458818,'季度初1≤y<2年资护士人数','52',70,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911248955699202,1967904691207458818,'季度末1≤y<2年资护士人数','53',552,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911249144442881,1967904691207458818,'季度初2≤y<5年资护士人数','54',71,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:38',1,'2025-09-16 19:19:38',1,0),(1967911249337380866,1967904691207458818,'季度末2≤y<5年资护士人数','55',553,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911249530318849,1967904691207458818,'季度初5≤y<10年资护士人数','56',72,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911249731645441,1967904691207458818,'季度末5≤y<10年资护士人数','57',554,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911249924583426,1967904691207458818,'季度初10≤y<20年资护士人数','58',73,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911250180435970,1967904691207458818,'季度末10≤y<20年资护士人数','59',555,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911250377568258,1967904691207458818,'季度初≥20年资护士人数','60',74,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911250570506241,1967904691207458818,'季度末≥20年资护士人数','61',556,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911250834747393,1967904691207458818,'季度初各工作年限护士总人数（50+52+54+56+58+60）','62',75,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911251036073986,1967904691207458818,'季度末各工作年限护士总人数（51+53+55+57+59+61）','63',557,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911251229011970,1967904691207458818,'季度初病区<1年资护士人数','64',76,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911251493253121,1967904691207458818,'季度末病区<1年资护士人数','65',558,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911251694579714,1967904691207458818,'季度初病区 1≤y<2年资护士人数','66',77,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911251887517697,1967904691207458818,'季度末病区 1≤y<2年资护士人数','67',559,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911252080455681,1967904691207458818,'季度初病区 2≤y<5年资护士人数','68',78,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911252344696834,1967904691207458818,'季度末病区 2≤y<5 年资护士人数','69',560,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911252604743681,1967904691207458818,'季度初病区 5≤y<10 年资护士人数','70',79,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911252797681665,1967904691207458818,'季度末病区5≤y<10年资护士人数','71',561,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911252990619650,1967904691207458818,'季度初病区10≤y<20年资护士人数','72',80,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911253187751937,1967904691207458818,'季度末病区10≤y<20年资护士人数','73',562,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911253376495617,1967904691207458818,'季度初病区≥20年资护士人数','74',81,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:39',1,'2025-09-16 19:19:39',1,0),(1967911253573627905,1967904691207458818,'季度末病区≥20年资护士人数','75',563,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911253833674754,1967904691207458818,'季度初病区各工作年限护士总人数（64+66+68+70+72+74）','76',82,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911254026612738,1967904691207458818,'季度末病区各工作年限护士总人数（65+67+69+71+73+75）','77',564,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911254227939329,1967904692050513922,'执业护士离职总人数','78',83,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911254420877314,1967904692050513922,'护士（初级）离职人数','79',565,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911254676729858,1967904692050513922,'护师离职人数','80',84,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911254878056449,1967904692050513922,'主管护师离职人数','81',566,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911255070994434,1967904692050513922,'副主任护师离职人数','82',85,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911255268126721,1967904692050513922,'主任护师离职人数','83',567,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911255465259009,1967904692050513922,'本季度各职称护士离职总人数（79+80+81+82+83）','84',86,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911255683362818,1967904692050513922,'中专护士离职人数','85',568,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911255930826754,1967904692050513922,'大专护士离职人数','86',87,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911256119570434,1967904692050513922,'本科护士离职人数','87',569,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911256379617282,1967904692050513922,'硕士护士离职人数','88',88,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911256580943874,1967904692050513922,'博士护士离职人数','89',570,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911256773881858,1967904692050513922,'本季度各学历护士离职总人数（85+86+87+88+89）','90',89,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911257038123009,1967904692050513922,'<1年资护士离职人数','91',571,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911257369473026,1967904692050513922,'1≤y<2年资护士离职人数','92',90,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911257503690754,1967904692050513922,'2≤y<5年资护士离职人数','93',572,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:40',1,'2025-09-16 19:19:40',1,0),(1967911257767931905,1967904692050513922,'5≤y<10年资护士离职人数','94',91,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911257969258497,1967904692050513922,'10≤y<20年资护士离职人数','95',573,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911258170585089,1967904692050513922,'≥20年资护士离职人数','96',92,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911258355134465,1967904692050513922,'本季度各工作年限护士离职总人数（91+92+93+94+95+96）','97',574,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911258548072449,1967904692797100034,'住院患者身体约束日数','98',93,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911258741010433,1967904693220724738,'住院患者跌倒例次数（100+101+102+103+104）','99',94,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911258929754114,1967904693220724738,'跌倒无伤害(0级)例次数(包含坠床)','100',95,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911259126886401,1967904693220724738,'跌倒轻度伤害(1级)例次数(包含坠床)','101',577,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911259378544642,1967904693220724738,'跌倒中度伤害(2级)例次数(包含床)','102',96,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911259575676929,1967904693220724738,'跌倒重度伤害(3级)例次数(包含坠床)','103',578,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911259772809217,1967904693220724738,'跌倒死亡例数(包含坠床)','104',97,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911259969941506,1967904693220724738,'跌倒伤害总例次数（101+102+103+104）','105',579,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911260167073794,1967904693745012737,'住院患者2期及以上院内压力性损伤新发例数','106',98,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911260355817474,1967904694202191874,'气管导管(气管插管、气管切开)非计划拔管发生例次数','107',99,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911260611670017,1967904694202191874,'气管导管(气管插管、气管切开)留置总日数','108',581,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911260800413697,1967904694202191874,'胃肠管(经口、经鼻)非计划拔管发生例次数','109',100,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911260997545985,1967904694202191874,'胃肠管(经口、经鼻)留置总日数','110',582,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911261190483970,1967904694202191874,'导尿管非计划拔管发生例次数','111',101,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911261442142210,1967904694202191874,'导尿管留置总日数','112',583,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911261643468802,1967904694202191874,'CVC非计划拔管发生例次数','113',102,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:41',1,'2025-09-16 19:19:41',1,0),(1967911261836406786,1967904694202191874,'CVC 留置总日数','114',584,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911262096453633,1967904694202191874,'PICC 非计划拔管发生例次数','115',103,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911262352306178,1967904694202191874,'PICC留置总日数','116',585,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911262549438465,1967904694202191874,'血液净化用中心静脉导管非计划拔管发生例次数','117',104,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911262746570754,1967904694202191874,'血液净化用中心静脉导管留置总日数','118',586,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911263132446722,1967904694906834946,'导尿管相关尿路感染(CAUTI)发生例次数','119',105,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911263329579009,1967904694906834946,'CVC相关血流感染发生例次数','120',587,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911263518322689,1967904694906834946,'PICC相关血流感染发生例次数','121',106,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911263778369537,1967904694906834946,'血液净化用中心静脉导管相关血流感染发生例次数','122',588,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911263967113218,1967904695552757762,'呼吸机相关性肺炎(VAP)发生例次数','123',107,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911264160051201,1967904695552757762,'有创机械通气总日数','124',589,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911264357183490,1967904696261595137,'外周静脉短导管静脉炎发生例次数','125',108,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911264621424642,1967904696261595137,'本季度外周静脉短导管留置总例数','126',590,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911264814362626,1967904697029152769,'用药错误发生例次数','127',109,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911265149906946,1967904697029152769,'用药住院患者总数','128',591,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911265351233538,1967904697670881282,'静脉治疗药物渗出(2级及以上)发生例次数','129',110,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911265544171522,1967904697670881282,'静脉治疗药物外渗发生例次数','130',592,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911265741303809,1967904697670881282,'本季度静脉治疗通路留置总日数','131',111,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911265934241793,1967904698383912962,'输血错误发生例次数','132',112,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:42',1,'2025-09-16 19:19:42',1,0),(1967911266131374082,1967904698383912962,'本季度输血患者总人次数','133',594,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:43',1,'2025-09-16 19:19:43',1,0),(1967911266399809538,1967904699096944641,'院内成人失禁相关性皮炎新发例数','134',113,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:43',1,'2025-09-16 19:19:43',1,0),(1967911266592747522,1967904699554123777,'烧伤发生例次数(包含烫/灼伤)','135',114,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:43',1,'2025-09-16 19:19:43',1,0),(1967911266844405762,1967904699554123777,'冻伤发生例次数','136',596,NULL,NULL,NULL,NULL,2025,2,103,1,'0',NULL,NULL,NULL,'1',0,'0',NULL,0,'000000',103,'2025-09-16 19:19:43',1,'2025-09-16 19:19:43',1,0);
/*!40000 ALTER TABLE `nursing_report_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_distributed_lock`
--

DROP TABLE IF EXISTS `sj_distributed_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_distributed_lock` (
  `name` varchar(64) NOT NULL COMMENT '锁名称',
  `lock_until` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '锁定时长',
  `locked_at` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '锁定时间',
  `locked_by` varchar(255) NOT NULL COMMENT '锁定者',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='锁定表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_distributed_lock`
--

LOCK TABLES `sj_distributed_lock` WRITE;
/*!40000 ALTER TABLE `sj_distributed_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_distributed_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_group_config`
--

DROP TABLE IF EXISTS `sj_group_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_group_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL DEFAULT '' COMMENT '组名称',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '组描述',
  `token` varchar(64) NOT NULL DEFAULT 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT' COMMENT 'token',
  `group_status` tinyint NOT NULL DEFAULT '0' COMMENT '组状态 0、未启用 1、启用',
  `version` int NOT NULL COMMENT '版本号',
  `group_partition` int NOT NULL COMMENT '分区',
  `id_generator_mode` tinyint NOT NULL DEFAULT '1' COMMENT '唯一id生成模式 默认号段模式',
  `init_scene` tinyint NOT NULL DEFAULT '0' COMMENT '是否初始化场景 0:否 1:是',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='组配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_group_config`
--

LOCK TABLES `sj_group_config` WRITE;
/*!40000 ALTER TABLE `sj_group_config` DISABLE KEYS */;
INSERT INTO `sj_group_config` VALUES (1,'dev','ruoyi_group','','SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT',1,1,0,1,1,'2025-09-16 17:34:55','2025-09-16 17:34:55'),(2,'prod','ruoyi_group','','SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT',1,1,0,1,1,'2025-09-16 17:34:55','2025-09-16 17:34:55');
/*!40000 ALTER TABLE `sj_group_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_job`
--

DROP TABLE IF EXISTS `sj_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_job` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `job_name` varchar(64) NOT NULL COMMENT '名称',
  `args_str` text COMMENT '执行方法参数',
  `args_type` tinyint NOT NULL DEFAULT '1' COMMENT '参数类型 ',
  `next_trigger_at` bigint NOT NULL COMMENT '下次触发时间',
  `job_status` tinyint NOT NULL DEFAULT '1' COMMENT '任务状态 0、关闭、1、开启',
  `task_type` tinyint NOT NULL DEFAULT '1' COMMENT '任务类型 1、集群 2、广播 3、切片',
  `route_key` tinyint NOT NULL DEFAULT '4' COMMENT '路由策略',
  `executor_type` tinyint NOT NULL DEFAULT '1' COMMENT '执行器类型',
  `executor_info` varchar(255) DEFAULT NULL COMMENT '执行器名称',
  `trigger_type` tinyint NOT NULL COMMENT '触发类型 1.CRON 表达式 2. 固定时间',
  `trigger_interval` varchar(255) NOT NULL COMMENT '间隔时长',
  `block_strategy` tinyint NOT NULL DEFAULT '1' COMMENT '阻塞策略 1、丢弃 2、覆盖 3、并行 4、恢复',
  `executor_timeout` int NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `max_retry_times` int NOT NULL DEFAULT '0' COMMENT '最大重试次数',
  `parallel_num` int NOT NULL DEFAULT '1' COMMENT '并行数',
  `retry_interval` int NOT NULL DEFAULT '0' COMMENT '重试间隔(s)',
  `bucket_index` int NOT NULL DEFAULT '0' COMMENT 'bucket',
  `resident` tinyint NOT NULL DEFAULT '0' COMMENT '是否是常驻任务',
  `notify_ids` varchar(128) NOT NULL DEFAULT '' COMMENT '通知告警场景配置id列表',
  `owner_id` bigint DEFAULT NULL COMMENT '负责人id',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`),
  KEY `idx_job_status_bucket_index` (`job_status`,`bucket_index`),
  KEY `idx_create_dt` (`create_dt`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_job`
--

LOCK TABLES `sj_job` WRITE;
/*!40000 ALTER TABLE `sj_job` DISABLE KEYS */;
INSERT INTO `sj_job` VALUES (1,'dev','ruoyi_group','demo-job',NULL,1,1710344035622,1,1,4,1,'testJobExecutor',2,'60',1,60,3,1,1,116,0,'',1,'','',0,'2025-09-16 17:34:56','2025-09-16 17:34:56');
/*!40000 ALTER TABLE `sj_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_job_log_message`
--

DROP TABLE IF EXISTS `sj_job_log_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_job_log_message` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `job_id` bigint NOT NULL COMMENT '任务信息id',
  `task_batch_id` bigint NOT NULL COMMENT '任务批次id',
  `task_id` bigint NOT NULL COMMENT '调度任务id',
  `message` longtext NOT NULL COMMENT '调度信息',
  `log_num` int NOT NULL DEFAULT '1' COMMENT '日志数量',
  `real_time` bigint NOT NULL DEFAULT '0' COMMENT '上报时间',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_task_batch_id_task_id` (`task_batch_id`,`task_id`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='调度日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_job_log_message`
--

LOCK TABLES `sj_job_log_message` WRITE;
/*!40000 ALTER TABLE `sj_job_log_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_job_log_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_job_summary`
--

DROP TABLE IF EXISTS `sj_job_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_job_summary` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL DEFAULT '' COMMENT '组名称',
  `business_id` bigint NOT NULL COMMENT '业务id (job_id或workflow_id)',
  `system_task_type` tinyint NOT NULL DEFAULT '3' COMMENT '任务类型 3、JOB任务 4、WORKFLOW任务',
  `trigger_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `success_num` int NOT NULL DEFAULT '0' COMMENT '执行成功-日志数量',
  `fail_num` int NOT NULL DEFAULT '0' COMMENT '执行失败-日志数量',
  `fail_reason` varchar(512) NOT NULL DEFAULT '' COMMENT '失败原因',
  `stop_num` int NOT NULL DEFAULT '0' COMMENT '执行失败-日志数量',
  `stop_reason` varchar(512) NOT NULL DEFAULT '' COMMENT '失败原因',
  `cancel_num` int NOT NULL DEFAULT '0' COMMENT '执行失败-日志数量',
  `cancel_reason` varchar(512) NOT NULL DEFAULT '' COMMENT '失败原因',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_trigger_at_system_task_type_business_id` (`trigger_at`,`system_task_type`,`business_id`) USING BTREE,
  KEY `idx_namespace_id_group_name_business_id` (`namespace_id`,`group_name`,`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='DashBoard_Job';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_job_summary`
--

LOCK TABLES `sj_job_summary` WRITE;
/*!40000 ALTER TABLE `sj_job_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_job_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_job_task`
--

DROP TABLE IF EXISTS `sj_job_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_job_task` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `job_id` bigint NOT NULL COMMENT '任务信息id',
  `task_batch_id` bigint NOT NULL COMMENT '调度任务id',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父执行器id',
  `task_status` tinyint NOT NULL DEFAULT '0' COMMENT '执行的状态 0、失败 1、成功',
  `retry_count` int NOT NULL DEFAULT '0' COMMENT '重试次数',
  `mr_stage` tinyint DEFAULT NULL COMMENT '动态分片所处阶段 1:map 2:reduce 3:mergeReduce',
  `leaf` tinyint NOT NULL DEFAULT '1' COMMENT '叶子节点',
  `task_name` varchar(255) NOT NULL DEFAULT '' COMMENT '任务名称',
  `client_info` varchar(128) DEFAULT NULL COMMENT '客户端地址 clientId#ip:port',
  `wf_context` text COMMENT '工作流全局上下文',
  `result_message` text NOT NULL COMMENT '执行结果',
  `args_str` text COMMENT '执行方法参数',
  `args_type` tinyint NOT NULL DEFAULT '1' COMMENT '参数类型 ',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_task_batch_id_task_status` (`task_batch_id`,`task_status`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务实例';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_job_task`
--

LOCK TABLES `sj_job_task` WRITE;
/*!40000 ALTER TABLE `sj_job_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_job_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_job_task_batch`
--

DROP TABLE IF EXISTS `sj_job_task_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_job_task_batch` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `job_id` bigint NOT NULL COMMENT '任务id',
  `workflow_node_id` bigint NOT NULL DEFAULT '0' COMMENT '工作流节点id',
  `parent_workflow_node_id` bigint NOT NULL DEFAULT '0' COMMENT '工作流任务父批次id',
  `workflow_task_batch_id` bigint NOT NULL DEFAULT '0' COMMENT '工作流任务批次id',
  `task_batch_status` tinyint NOT NULL DEFAULT '0' COMMENT '任务批次状态 0、失败 1、成功',
  `operation_reason` tinyint NOT NULL DEFAULT '0' COMMENT '操作原因',
  `execution_at` bigint NOT NULL DEFAULT '0' COMMENT '任务执行时间',
  `system_task_type` tinyint NOT NULL DEFAULT '3' COMMENT '任务类型 3、JOB任务 4、WORKFLOW任务',
  `parent_id` varchar(64) NOT NULL DEFAULT '' COMMENT '父节点',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_job_id_task_batch_status` (`job_id`,`task_batch_status`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`),
  KEY `idx_workflow_task_batch_id_workflow_node_id` (`workflow_task_batch_id`,`workflow_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务批次';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_job_task_batch`
--

LOCK TABLES `sj_job_task_batch` WRITE;
/*!40000 ALTER TABLE `sj_job_task_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_job_task_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_namespace`
--

DROP TABLE IF EXISTS `sj_namespace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_namespace` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `unique_id` varchar(64) NOT NULL COMMENT '唯一id',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='命名空间';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_namespace`
--

LOCK TABLES `sj_namespace` WRITE;
/*!40000 ALTER TABLE `sj_namespace` DISABLE KEYS */;
INSERT INTO `sj_namespace` VALUES (1,'Development','dev','',0,'2025-09-16 17:34:55','2025-09-16 17:34:55'),(2,'Production','prod','',0,'2025-09-16 17:34:55','2025-09-16 17:34:55');
/*!40000 ALTER TABLE `sj_namespace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_notify_config`
--

DROP TABLE IF EXISTS `sj_notify_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_notify_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `notify_name` varchar(64) NOT NULL DEFAULT '' COMMENT '通知名称',
  `system_task_type` tinyint NOT NULL DEFAULT '3' COMMENT '任务类型 1. 重试任务 2. 重试回调 3、JOB任务 4、WORKFLOW任务',
  `notify_status` tinyint NOT NULL DEFAULT '0' COMMENT '通知状态 0、未启用 1、启用',
  `recipient_ids` varchar(128) NOT NULL COMMENT '接收人id列表',
  `notify_threshold` int NOT NULL DEFAULT '0' COMMENT '通知阈值',
  `notify_scene` tinyint NOT NULL DEFAULT '0' COMMENT '通知场景',
  `rate_limiter_status` tinyint NOT NULL DEFAULT '0' COMMENT '限流状态 0、未启用 1、启用',
  `rate_limiter_threshold` int NOT NULL DEFAULT '0' COMMENT '每秒限流阈值',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_namespace_id_group_name_scene_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_notify_config`
--

LOCK TABLES `sj_notify_config` WRITE;
/*!40000 ALTER TABLE `sj_notify_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_notify_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_notify_recipient`
--

DROP TABLE IF EXISTS `sj_notify_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_notify_recipient` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `recipient_name` varchar(64) NOT NULL COMMENT '接收人名称',
  `notify_type` tinyint NOT NULL DEFAULT '0' COMMENT '通知类型 1、钉钉 2、邮件 3、企业微信 4 飞书 5 webhook',
  `notify_attribute` varchar(512) NOT NULL COMMENT '配置属性',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_namespace_id` (`namespace_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='告警通知接收人';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_notify_recipient`
--

LOCK TABLES `sj_notify_recipient` WRITE;
/*!40000 ALTER TABLE `sj_notify_recipient` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_notify_recipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_retry`
--

DROP TABLE IF EXISTS `sj_retry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_retry` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `group_id` bigint NOT NULL COMMENT '组Id',
  `scene_name` varchar(64) NOT NULL COMMENT '场景名称',
  `scene_id` bigint NOT NULL COMMENT '场景ID',
  `idempotent_id` varchar(64) NOT NULL COMMENT '幂等id',
  `biz_no` varchar(64) NOT NULL DEFAULT '' COMMENT '业务编号',
  `executor_name` varchar(512) NOT NULL DEFAULT '' COMMENT '执行器名称',
  `args_str` text NOT NULL COMMENT '执行方法参数',
  `ext_attrs` text NOT NULL COMMENT '扩展字段',
  `next_trigger_at` bigint NOT NULL COMMENT '下次触发时间',
  `retry_count` int NOT NULL DEFAULT '0' COMMENT '重试次数',
  `retry_status` tinyint NOT NULL DEFAULT '0' COMMENT '重试状态 0、重试中 1、成功 2、最大重试次数',
  `task_type` tinyint NOT NULL DEFAULT '1' COMMENT '任务类型 1、重试数据 2、回调数据',
  `bucket_index` int NOT NULL DEFAULT '0' COMMENT 'bucket',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父节点id',
  `deleted` bigint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_scene_tasktype_idempotentid_deleted` (`scene_id`,`task_type`,`idempotent_id`,`deleted`),
  KEY `idx_biz_no` (`biz_no`),
  KEY `idx_idempotent_id` (`idempotent_id`),
  KEY `idx_retry_status_bucket_index` (`retry_status`,`bucket_index`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_create_dt` (`create_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='重试信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_retry`
--

LOCK TABLES `sj_retry` WRITE;
/*!40000 ALTER TABLE `sj_retry` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_retry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_retry_dead_letter`
--

DROP TABLE IF EXISTS `sj_retry_dead_letter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_retry_dead_letter` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `group_id` bigint NOT NULL COMMENT '组Id',
  `scene_name` varchar(64) NOT NULL COMMENT '场景名称',
  `scene_id` bigint NOT NULL COMMENT '场景ID',
  `idempotent_id` varchar(64) NOT NULL COMMENT '幂等id',
  `biz_no` varchar(64) NOT NULL DEFAULT '' COMMENT '业务编号',
  `executor_name` varchar(512) NOT NULL DEFAULT '' COMMENT '执行器名称',
  `args_str` text NOT NULL COMMENT '执行方法参数',
  `ext_attrs` text NOT NULL COMMENT '扩展字段',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_namespace_id_group_name_scene_name` (`namespace_id`,`group_name`,`scene_name`),
  KEY `idx_idempotent_id` (`idempotent_id`),
  KEY `idx_biz_no` (`biz_no`),
  KEY `idx_create_dt` (`create_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='死信队列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_retry_dead_letter`
--

LOCK TABLES `sj_retry_dead_letter` WRITE;
/*!40000 ALTER TABLE `sj_retry_dead_letter` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_retry_dead_letter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_retry_scene_config`
--

DROP TABLE IF EXISTS `sj_retry_scene_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_retry_scene_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `scene_name` varchar(64) NOT NULL COMMENT '场景名称',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `scene_status` tinyint NOT NULL DEFAULT '0' COMMENT '组状态 0、未启用 1、启用',
  `max_retry_count` int NOT NULL DEFAULT '5' COMMENT '最大重试次数',
  `back_off` tinyint NOT NULL DEFAULT '1' COMMENT '1、默认等级 2、固定间隔时间 3、CRON 表达式',
  `trigger_interval` varchar(16) NOT NULL DEFAULT '' COMMENT '间隔时长',
  `notify_ids` varchar(128) NOT NULL DEFAULT '' COMMENT '通知告警场景配置id列表',
  `deadline_request` bigint unsigned NOT NULL DEFAULT '60000' COMMENT 'Deadline Request 调用链超时 单位毫秒',
  `executor_timeout` int unsigned NOT NULL DEFAULT '5' COMMENT '任务执行超时时间，单位秒',
  `route_key` tinyint NOT NULL DEFAULT '4' COMMENT '路由策略',
  `block_strategy` tinyint NOT NULL DEFAULT '1' COMMENT '阻塞策略 1、丢弃 2、覆盖 3、并行',
  `cb_status` tinyint NOT NULL DEFAULT '0' COMMENT '回调状态 0、不开启 1、开启',
  `cb_trigger_type` tinyint NOT NULL DEFAULT '1' COMMENT '1、默认等级 2、固定间隔时间 3、CRON 表达式',
  `cb_max_count` int NOT NULL DEFAULT '16' COMMENT '回调的最大执行次数',
  `cb_trigger_interval` varchar(16) NOT NULL DEFAULT '' COMMENT '回调的最大执行次数',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_namespace_id_group_name_scene_name` (`namespace_id`,`group_name`,`scene_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='场景配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_retry_scene_config`
--

LOCK TABLES `sj_retry_scene_config` WRITE;
/*!40000 ALTER TABLE `sj_retry_scene_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_retry_scene_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_retry_summary`
--

DROP TABLE IF EXISTS `sj_retry_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_retry_summary` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL DEFAULT '' COMMENT '组名称',
  `scene_name` varchar(50) NOT NULL DEFAULT '' COMMENT '场景名称',
  `trigger_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `running_num` int NOT NULL DEFAULT '0' COMMENT '重试中-日志数量',
  `finish_num` int NOT NULL DEFAULT '0' COMMENT '重试完成-日志数量',
  `max_count_num` int NOT NULL DEFAULT '0' COMMENT '重试到达最大次数-日志数量',
  `suspend_num` int NOT NULL DEFAULT '0' COMMENT '暂停重试-日志数量',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_scene_name_trigger_at` (`namespace_id`,`group_name`,`scene_name`,`trigger_at`) USING BTREE,
  KEY `idx_trigger_at` (`trigger_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='DashBoard_Retry';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_retry_summary`
--

LOCK TABLES `sj_retry_summary` WRITE;
/*!40000 ALTER TABLE `sj_retry_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_retry_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_retry_task`
--

DROP TABLE IF EXISTS `sj_retry_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_retry_task` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `scene_name` varchar(64) NOT NULL COMMENT '场景名称',
  `retry_id` bigint NOT NULL COMMENT '重试信息Id',
  `ext_attrs` text NOT NULL COMMENT '扩展字段',
  `task_status` tinyint NOT NULL DEFAULT '1' COMMENT '重试状态',
  `task_type` tinyint NOT NULL DEFAULT '1' COMMENT '任务类型 1、重试数据 2、回调数据',
  `operation_reason` tinyint NOT NULL DEFAULT '0' COMMENT '操作原因',
  `client_info` varchar(128) DEFAULT NULL COMMENT '客户端地址 clientId#ip:port',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_group_name_scene_name` (`namespace_id`,`group_name`,`scene_name`),
  KEY `task_status` (`task_status`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_retry_id` (`retry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='重试任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_retry_task`
--

LOCK TABLES `sj_retry_task` WRITE;
/*!40000 ALTER TABLE `sj_retry_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_retry_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_retry_task_log_message`
--

DROP TABLE IF EXISTS `sj_retry_task_log_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_retry_task_log_message` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `retry_id` bigint NOT NULL COMMENT '重试信息Id',
  `retry_task_id` bigint NOT NULL COMMENT '重试任务Id',
  `message` longtext NOT NULL COMMENT '异常信息',
  `log_num` int NOT NULL DEFAULT '1' COMMENT '日志数量',
  `real_time` bigint NOT NULL DEFAULT '0' COMMENT '上报时间',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_namespace_id_group_name_retry_task_id` (`namespace_id`,`group_name`,`retry_task_id`),
  KEY `idx_create_dt` (`create_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务调度日志信息记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_retry_task_log_message`
--

LOCK TABLES `sj_retry_task_log_message` WRITE;
/*!40000 ALTER TABLE `sj_retry_task_log_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_retry_task_log_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_sequence_alloc`
--

DROP TABLE IF EXISTS `sj_sequence_alloc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_sequence_alloc` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL DEFAULT '' COMMENT '组名称',
  `max_id` bigint NOT NULL DEFAULT '1' COMMENT '最大id',
  `step` int NOT NULL DEFAULT '100' COMMENT '步长',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='号段模式序号ID分配表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_sequence_alloc`
--

LOCK TABLES `sj_sequence_alloc` WRITE;
/*!40000 ALTER TABLE `sj_sequence_alloc` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_sequence_alloc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_server_node`
--

DROP TABLE IF EXISTS `sj_server_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_server_node` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `host_id` varchar(64) NOT NULL COMMENT '主机id',
  `host_ip` varchar(64) NOT NULL COMMENT '机器ip',
  `host_port` int NOT NULL COMMENT '机器端口',
  `expire_at` datetime NOT NULL COMMENT '过期时间',
  `node_type` tinyint NOT NULL COMMENT '节点类型 1、客户端 2、是服务端',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_host_id_host_ip` (`host_id`,`host_ip`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`),
  KEY `idx_expire_at_node_type` (`expire_at`,`node_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务器节点';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_server_node`
--

LOCK TABLES `sj_server_node` WRITE;
/*!40000 ALTER TABLE `sj_server_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_server_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_system_user`
--

DROP TABLE IF EXISTS `sj_system_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_system_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(64) NOT NULL COMMENT '账号',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `role` tinyint NOT NULL DEFAULT '0' COMMENT '角色：1-普通用户、2-管理员',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_system_user`
--

LOCK TABLES `sj_system_user` WRITE;
/*!40000 ALTER TABLE `sj_system_user` DISABLE KEYS */;
INSERT INTO `sj_system_user` VALUES (1,'admin','465c194afb65670f38322df087f0a9bb225cc257e43eb4ac5a0c98ef5b3173ac',2,'2025-09-16 17:34:56','2025-09-16 17:34:56');
/*!40000 ALTER TABLE `sj_system_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_system_user_permission`
--

DROP TABLE IF EXISTS `sj_system_user_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_system_user_permission` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `system_user_id` bigint NOT NULL COMMENT '系统用户id',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_namespace_id_group_name_system_user_id` (`namespace_id`,`group_name`,`system_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统用户权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_system_user_permission`
--

LOCK TABLES `sj_system_user_permission` WRITE;
/*!40000 ALTER TABLE `sj_system_user_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_system_user_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_workflow`
--

DROP TABLE IF EXISTS `sj_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_workflow` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `workflow_name` varchar(64) NOT NULL COMMENT '工作流名称',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `workflow_status` tinyint NOT NULL DEFAULT '1' COMMENT '工作流状态 0、关闭、1、开启',
  `trigger_type` tinyint NOT NULL COMMENT '触发类型 1.CRON 表达式 2. 固定时间',
  `trigger_interval` varchar(255) NOT NULL COMMENT '间隔时长',
  `next_trigger_at` bigint NOT NULL COMMENT '下次触发时间',
  `block_strategy` tinyint NOT NULL DEFAULT '1' COMMENT '阻塞策略 1、丢弃 2、覆盖 3、并行',
  `executor_timeout` int NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `flow_info` text COMMENT '流程信息',
  `wf_context` text COMMENT '上下文',
  `notify_ids` varchar(128) NOT NULL DEFAULT '' COMMENT '通知告警场景配置id列表',
  `bucket_index` int NOT NULL DEFAULT '0' COMMENT 'bucket',
  `version` int NOT NULL COMMENT '版本号',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工作流';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_workflow`
--

LOCK TABLES `sj_workflow` WRITE;
/*!40000 ALTER TABLE `sj_workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_workflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_workflow_node`
--

DROP TABLE IF EXISTS `sj_workflow_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_workflow_node` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `node_name` varchar(64) NOT NULL COMMENT '节点名称',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `job_id` bigint NOT NULL COMMENT '任务信息id',
  `workflow_id` bigint NOT NULL COMMENT '工作流ID',
  `node_type` tinyint NOT NULL DEFAULT '1' COMMENT '1、任务节点 2、条件节点',
  `expression_type` tinyint NOT NULL DEFAULT '0' COMMENT '1、SpEl、2、Aviator 3、QL',
  `fail_strategy` tinyint NOT NULL DEFAULT '1' COMMENT '失败策略 1、跳过 2、阻塞',
  `workflow_node_status` tinyint NOT NULL DEFAULT '1' COMMENT '工作流节点状态 0、关闭、1、开启',
  `priority_level` int NOT NULL DEFAULT '1' COMMENT '优先级',
  `node_info` text COMMENT '节点信息 ',
  `version` int NOT NULL COMMENT '版本号',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工作流节点';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_workflow_node`
--

LOCK TABLES `sj_workflow_node` WRITE;
/*!40000 ALTER TABLE `sj_workflow_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_workflow_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sj_workflow_task_batch`
--

DROP TABLE IF EXISTS `sj_workflow_task_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sj_workflow_task_batch` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `workflow_id` bigint NOT NULL COMMENT '工作流任务id',
  `task_batch_status` tinyint NOT NULL DEFAULT '0' COMMENT '任务批次状态 0、失败 1、成功',
  `operation_reason` tinyint NOT NULL DEFAULT '0' COMMENT '操作原因',
  `flow_info` text COMMENT '流程信息',
  `wf_context` text COMMENT '全局上下文',
  `execution_at` bigint NOT NULL DEFAULT '0' COMMENT '任务执行时间',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `version` int NOT NULL DEFAULT '1' COMMENT '版本号',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_job_id_task_batch_status` (`workflow_id`,`task_batch_status`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工作流批次';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sj_workflow_task_batch`
--

LOCK TABLES `sj_workflow_task_batch` WRITE;
/*!40000 ALTER TABLE `sj_workflow_task_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `sj_workflow_task_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_client`
--

DROP TABLE IF EXISTS `sys_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_client` (
  `id` bigint NOT NULL COMMENT 'id',
  `client_id` varchar(64) DEFAULT NULL COMMENT '客户端id',
  `client_key` varchar(32) DEFAULT NULL COMMENT '客户端key',
  `client_secret` varchar(255) DEFAULT NULL COMMENT '客户端秘钥',
  `grant_type` varchar(255) DEFAULT NULL COMMENT '授权类型',
  `device_type` varchar(32) DEFAULT NULL COMMENT '设备类型',
  `active_timeout` int DEFAULT '1800' COMMENT 'token活跃超时时间',
  `timeout` int DEFAULT '604800' COMMENT 'token固定超时',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统授权表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_client`
--

LOCK TABLES `sys_client` WRITE;
/*!40000 ALTER TABLE `sys_client` DISABLE KEYS */;
INSERT INTO `sys_client` VALUES (1,'e5cd7e4891bf95d1d19206ce24a7b32e','pc','pc123','password,social','pc',1800,604800,'0','0',103,1,'2025-09-16 17:34:21',1,'2025-09-16 17:34:21'),(2,'428a8310cd442757ae699df5d894f051','app','app123','password,sms,social','android',1800,604800,'0','0',103,1,'2025-09-16 17:34:21',1,'2025-09-16 17:34:21');
/*!40000 ALTER TABLE `sys_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `config_id` bigint NOT NULL COMMENT '参数主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'000000','主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y',103,1,'2025-09-16 17:34:20',NULL,NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'000000','用户管理-账号初始密码','sys.user.initPassword','HLSB@202509','Y',103,1,'2025-09-16 17:34:20',1,'2025-09-17 16:19:31','初始化密码 123456'),(3,'000000','主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y',103,1,'2025-09-16 17:34:20',NULL,NULL,'深色主题theme-dark，浅色主题theme-light'),(5,'000000','账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y',103,1,'2025-09-16 17:34:20',NULL,NULL,'是否开启注册用户功能（true开启，false关闭）'),(11,'000000','OSS预览列表资源开关','sys.oss.previewListResource','true','Y',103,1,'2025-09-16 17:34:20',NULL,NULL,'true:开启, false:关闭');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(500) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `dept_category` varchar(100) DEFAULT NULL COMMENT '部门类别编码',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` bigint DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,'000000',0,'0','首都医科大学',NULL,0,NULL,'15888888888','xxx@qq.com','0','0',103,1,'2025-09-16 17:34:10',1,'2025-09-17 16:18:27'),(101,'000000',100,'0,100','医院A',NULL,1,NULL,'15888888888','xxx@qq.com','0','0',103,1,'2025-09-16 17:34:10',1,'2025-09-17 16:18:40'),(102,'000000',100,'0,100','医院B',NULL,2,NULL,'15888888888','xxx@qq.com','0','0',103,1,'2025-09-16 17:34:10',1,'2025-09-17 16:18:50'),(103,'000000',101,'0,100,101','研发部门',NULL,1,1,'15888888888','xxx@qq.com','0','0',103,1,'2025-09-16 17:34:10',NULL,NULL),(104,'000000',101,'0,100,101','市场部门',NULL,2,NULL,'15888888888','xxx@qq.com','0','0',103,1,'2025-09-16 17:34:10',NULL,NULL),(105,'000000',101,'0,100,101','测试部门',NULL,3,NULL,'15888888888','xxx@qq.com','0','0',103,1,'2025-09-16 17:34:10',NULL,NULL),(106,'000000',101,'0,100,101','财务部门',NULL,4,NULL,'15888888888','xxx@qq.com','0','0',103,1,'2025-09-16 17:34:10',NULL,NULL),(107,'000000',101,'0,100,101','运维部门',NULL,5,NULL,'15888888888','xxx@qq.com','0','0',103,1,'2025-09-16 17:34:10',NULL,NULL),(108,'000000',102,'0,100,102','市场部门',NULL,1,NULL,'15888888888','xxx@qq.com','0','0',103,1,'2025-09-16 17:34:10',NULL,NULL),(109,'000000',102,'0,100,102','财务部门',NULL,2,NULL,'15888888888','xxx@qq.com','0','1',103,1,'2025-09-16 17:34:10',1,'2025-09-17 16:17:51');
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL COMMENT '字典编码',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,'000000',1,'男','0','sys_user_sex','','','Y',103,1,'2025-09-16 17:34:19',NULL,NULL,'性别男'),(2,'000000',2,'女','1','sys_user_sex','','','N',103,1,'2025-09-16 17:34:19',NULL,NULL,'性别女'),(3,'000000',3,'未知','2','sys_user_sex','','','N',103,1,'2025-09-16 17:34:19',NULL,NULL,'性别未知'),(4,'000000',1,'显示','0','sys_show_hide','','primary','Y',103,1,'2025-09-16 17:34:19',NULL,NULL,'显示菜单'),(5,'000000',2,'隐藏','1','sys_show_hide','','danger','N',103,1,'2025-09-16 17:34:19',NULL,NULL,'隐藏菜单'),(6,'000000',1,'正常','0','sys_normal_disable','','primary','Y',103,1,'2025-09-16 17:34:19',NULL,NULL,'正常状态'),(7,'000000',2,'停用','1','sys_normal_disable','','danger','N',103,1,'2025-09-16 17:34:19',NULL,NULL,'停用状态'),(12,'000000',1,'是','Y','sys_yes_no','','primary','Y',103,1,'2025-09-16 17:34:19',NULL,NULL,'系统默认是'),(13,'000000',2,'否','N','sys_yes_no','','danger','N',103,1,'2025-09-16 17:34:19',NULL,NULL,'系统默认否'),(14,'000000',1,'通知','1','sys_notice_type','','warning','Y',103,1,'2025-09-16 17:34:19',NULL,NULL,'通知'),(15,'000000',2,'公告','2','sys_notice_type','','success','N',103,1,'2025-09-16 17:34:19',NULL,NULL,'公告'),(16,'000000',1,'正常','0','sys_notice_status','','primary','Y',103,1,'2025-09-16 17:34:19',NULL,NULL,'正常状态'),(17,'000000',2,'关闭','1','sys_notice_status','','danger','N',103,1,'2025-09-16 17:34:19',NULL,NULL,'关闭状态'),(18,'000000',1,'新增','1','sys_oper_type','','info','N',103,1,'2025-09-16 17:34:19',NULL,NULL,'新增操作'),(19,'000000',2,'修改','2','sys_oper_type','','info','N',103,1,'2025-09-16 17:34:19',NULL,NULL,'修改操作'),(20,'000000',3,'删除','3','sys_oper_type','','danger','N',103,1,'2025-09-16 17:34:19',NULL,NULL,'删除操作'),(21,'000000',4,'授权','4','sys_oper_type','','primary','N',103,1,'2025-09-16 17:34:19',NULL,NULL,'授权操作'),(22,'000000',5,'导出','5','sys_oper_type','','warning','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'导出操作'),(23,'000000',6,'导入','6','sys_oper_type','','warning','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'导入操作'),(24,'000000',7,'强退','7','sys_oper_type','','danger','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'强退操作'),(25,'000000',8,'生成代码','8','sys_oper_type','','warning','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'生成操作'),(26,'000000',9,'清空数据','9','sys_oper_type','','danger','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'清空操作'),(27,'000000',1,'成功','0','sys_common_status','','primary','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'正常状态'),(28,'000000',2,'失败','1','sys_common_status','','danger','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'停用状态'),(29,'000000',99,'其他','0','sys_oper_type','','info','N',103,1,'2025-09-16 17:34:19',NULL,NULL,'其他操作'),(30,'000000',0,'密码认证','password','sys_grant_type','el-check-tag','default','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'密码认证'),(31,'000000',0,'短信认证','sms','sys_grant_type','el-check-tag','default','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'短信认证'),(32,'000000',0,'邮件认证','email','sys_grant_type','el-check-tag','default','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'邮件认证'),(33,'000000',0,'小程序认证','xcx','sys_grant_type','el-check-tag','default','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'小程序认证'),(34,'000000',0,'三方登录认证','social','sys_grant_type','el-check-tag','default','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'三方登录认证'),(35,'000000',0,'PC','pc','sys_device_type','','default','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'PC'),(36,'000000',0,'安卓','android','sys_device_type','','default','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'安卓'),(37,'000000',0,'iOS','ios','sys_device_type','','default','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'iOS'),(38,'000000',0,'小程序','xcx','sys_device_type','','default','N',103,1,'2025-09-16 17:34:20',NULL,NULL,'小程序'),(39,'000000',1,'已撤销','cancel','wf_business_status','','danger','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'已撤销'),(40,'000000',2,'草稿','draft','wf_business_status','','info','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'草稿'),(41,'000000',3,'待审核','waiting','wf_business_status','','primary','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'待审核'),(42,'000000',4,'已完成','finish','wf_business_status','','success','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'已完成'),(43,'000000',5,'已作废','invalid','wf_business_status','','danger','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'已作废'),(44,'000000',6,'已退回','back','wf_business_status','','danger','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'已退回'),(45,'000000',7,'已终止','termination','wf_business_status','','danger','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'已终止'),(46,'000000',1,'自定义表单','static','wf_form_type','','success','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'自定义表单'),(47,'000000',2,'动态表单','dynamic','wf_form_type','','primary','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'动态表单'),(48,'000000',1,'撤销','cancel','wf_task_status','','danger','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'撤销'),(49,'000000',2,'通过','pass','wf_task_status','','success','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'通过'),(50,'000000',3,'待审核','waiting','wf_task_status','','primary','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'待审核'),(51,'000000',4,'作废','invalid','wf_task_status','','danger','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'作废'),(52,'000000',5,'退回','back','wf_task_status','','danger','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'退回'),(53,'000000',6,'终止','termination','wf_task_status','','danger','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'终止'),(54,'000000',7,'转办','transfer','wf_task_status','','primary','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'转办'),(55,'000000',8,'委托','depute','wf_task_status','','primary','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'委托'),(56,'000000',9,'抄送','copy','wf_task_status','','primary','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'抄送'),(57,'000000',10,'加签','sign','wf_task_status','','primary','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'加签'),(58,'000000',11,'减签','sign_off','wf_task_status','','danger','N',103,1,'2025-09-16 17:35:16',NULL,NULL,'减签'),(59,'000000',11,'超时','timeout','wf_task_status','','danger','N',103,1,'2025-09-16 17:35:17',NULL,NULL,'超时');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL COMMENT '字典主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `tenant_id` (`tenant_id`,`dict_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'000000','用户性别','sys_user_sex',103,1,'2025-09-16 17:34:19',NULL,NULL,'用户性别列表'),(2,'000000','菜单状态','sys_show_hide',103,1,'2025-09-16 17:34:19',NULL,NULL,'菜单状态列表'),(3,'000000','系统开关','sys_normal_disable',103,1,'2025-09-16 17:34:19',NULL,NULL,'系统开关列表'),(6,'000000','系统是否','sys_yes_no',103,1,'2025-09-16 17:34:19',NULL,NULL,'系统是否列表'),(7,'000000','通知类型','sys_notice_type',103,1,'2025-09-16 17:34:19',NULL,NULL,'通知类型列表'),(8,'000000','通知状态','sys_notice_status',103,1,'2025-09-16 17:34:19',NULL,NULL,'通知状态列表'),(9,'000000','操作类型','sys_oper_type',103,1,'2025-09-16 17:34:19',NULL,NULL,'操作类型列表'),(10,'000000','系统状态','sys_common_status',103,1,'2025-09-16 17:34:19',NULL,NULL,'登录状态列表'),(11,'000000','授权类型','sys_grant_type',103,1,'2025-09-16 17:34:19',NULL,NULL,'认证授权类型'),(12,'000000','设备类型','sys_device_type',103,1,'2025-09-16 17:34:19',NULL,NULL,'客户端设备类型'),(13,'000000','业务状态','wf_business_status',103,1,'2025-09-16 17:35:16',NULL,NULL,'业务状态列表'),(14,'000000','表单类型','wf_form_type',103,1,'2025-09-16 17:35:16',NULL,NULL,'表单类型列表'),(15,'000000','任务状态','wf_task_status',103,1,'2025-09-16 17:35:16',NULL,NULL,'任务状态');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL COMMENT '访问ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `client_key` varchar(32) DEFAULT '' COMMENT '客户端',
  `device_type` varchar(32) DEFAULT '' COMMENT '设备类型',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (1967888700347985922,'000000','admin','pc','pc','0:0:0:0:0:0:0:1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','登录成功','2025-09-16 17:50:02'),(1968135406759149570,'000000','admin','pc','pc','0:0:0:0:0:0:0:1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','登录成功','2025-09-17 10:10:22'),(1968154241532919809,'000000','admin','pc','pc','0:0:0:0:0:0:0:1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','退出成功','2025-09-17 11:25:12'),(1968154533972377602,'000000','admin','pc','pc','0:0:0:0:0:0:0:1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','登录成功','2025-09-17 11:26:22'),(1968187380670124033,'000000','admin','pc','pc','0:0:0:0:0:0:0:1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','登录成功','2025-09-17 13:36:53'),(1968202872344530946,'000000','admin','pc','pc','0:0:0:0:0:0:0:1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','登录成功','2025-09-17 14:38:27'),(1968215423090380801,'000000','admin','pc','pc','0:0:0:0:0:0:0:1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','登录成功','2025-09-17 15:28:19');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query_param` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '显示状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,10,'system',NULL,'',1,0,'M','0','0','','system',103,1,'2025-09-16 17:34:11',1,'2025-09-17 10:14:07','系统管理目录'),(2,'系统监控',0,30,'monitor',NULL,'',1,0,'M','0','0','','monitor',103,1,'2025-09-16 17:34:11',1,'2025-09-17 10:14:28','系统监控目录'),(3,'系统工具',0,40,'tool',NULL,'',1,0,'M','0','0','','tool',103,1,'2025-09-16 17:34:11',1,'2025-09-17 10:14:39','系统工具目录'),(5,'测试菜单',0,5,'demo',NULL,'',1,0,'M','1','0','','star',103,1,'2025-09-16 17:34:11',1,'2025-09-17 10:13:28','测试菜单'),(6,'租户管理',0,20,'tenant',NULL,'',1,0,'M','0','0','','chart',103,1,'2025-09-16 17:34:11',1,'2025-09-17 10:14:20','租户管理目录'),(100,'用户管理',1,1,'user','system/user/index','',1,0,'C','0','0','system:user:list','user',103,1,'2025-09-16 17:34:11',NULL,NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','',1,0,'C','0','0','system:role:list','peoples',103,1,'2025-09-16 17:34:11',NULL,NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','',1,0,'C','0','0','system:menu:list','tree-table',103,1,'2025-09-16 17:34:11',NULL,NULL,'菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','',1,0,'C','0','0','system:dept:list','tree',103,1,'2025-09-16 17:34:11',NULL,NULL,'部门管理菜单'),(104,'岗位管理',1,5,'post','system/post/index','',1,0,'C','0','0','system:post:list','post',103,1,'2025-09-16 17:34:11',NULL,NULL,'岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','',1,0,'C','0','0','system:dict:list','dict',103,1,'2025-09-16 17:34:11',NULL,NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','',1,0,'C','0','0','system:config:list','edit',103,1,'2025-09-16 17:34:11',NULL,NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','',1,0,'C','0','0','system:notice:list','message',103,1,'2025-09-16 17:34:11',NULL,NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','',1,0,'M','0','0','','log',103,1,'2025-09-16 17:34:11',NULL,NULL,'日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index','',1,0,'C','0','0','monitor:online:list','online',103,1,'2025-09-16 17:34:11',NULL,NULL,'在线用户菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','',1,0,'C','0','0','monitor:cache:list','redis',103,1,'2025-09-16 17:34:11',NULL,NULL,'缓存监控菜单'),(115,'代码生成',3,2,'gen','tool/gen/index','',1,0,'C','0','0','tool:gen:list','code',103,1,'2025-09-16 17:34:11',NULL,NULL,'代码生成菜单'),(116,'修改生成配置',3,2,'gen-edit/index/:tableId','tool/gen/editTable','',1,1,'C','1','0','tool:gen:edit','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(117,'Admin监控',2,5,'Admin','monitor/admin/index','',1,0,'C','0','0','monitor:admin:list','dashboard',103,1,'2025-09-16 17:34:12',NULL,NULL,'Admin监控菜单'),(118,'文件管理',1,10,'oss','system/oss/index','',1,0,'C','0','0','system:oss:list','upload',103,1,'2025-09-16 17:34:12',NULL,NULL,'文件管理菜单'),(120,'任务调度中心',2,6,'snailjob','monitor/snailjob/index','',1,0,'C','0','0','monitor:snailjob:list','job',103,1,'2025-09-16 17:34:12',NULL,NULL,'SnailJob控制台菜单'),(121,'租户管理',6,1,'tenant','system/tenant/index','',1,0,'C','0','0','system:tenant:list','list',103,1,'2025-09-16 17:34:11',NULL,NULL,'租户管理菜单'),(122,'租户套餐管理',6,2,'tenantPackage','system/tenantPackage/index','',1,0,'C','0','0','system:tenantPackage:list','form',103,1,'2025-09-16 17:34:12',NULL,NULL,'租户套餐管理菜单'),(123,'客户端管理',1,11,'client','system/client/index','',1,0,'C','0','0','system:client:list','international',103,1,'2025-09-16 17:34:12',NULL,NULL,'客户端管理菜单'),(130,'分配用户',1,2,'role-auth/user/:roleId','system/role/authUser','',1,1,'C','1','0','system:role:edit','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(131,'分配角色',1,1,'user-auth/role/:userId','system/user/authRole','',1,1,'C','1','0','system:user:edit','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(132,'字典数据',1,6,'dict-data/index/:dictId','system/dict/data','',1,1,'C','1','0','system:dict:list','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(133,'文件配置管理',1,10,'oss-config/index','system/oss/config','',1,1,'C','1','0','system:ossConfig:list','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(500,'操作日志',108,1,'operlog','monitor/operlog/index','',1,0,'C','0','0','monitor:operlog:list','form',103,1,'2025-09-16 17:34:12',NULL,NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','',1,0,'C','0','0','monitor:logininfor:list','logininfor',103,1,'2025-09-16 17:34:12',NULL,NULL,'登录日志菜单'),(1001,'用户查询',100,1,'','','',1,0,'F','0','0','system:user:query','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1002,'用户新增',100,2,'','','',1,0,'F','0','0','system:user:add','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1003,'用户修改',100,3,'','','',1,0,'F','0','0','system:user:edit','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1004,'用户删除',100,4,'','','',1,0,'F','0','0','system:user:remove','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1005,'用户导出',100,5,'','','',1,0,'F','0','0','system:user:export','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1006,'用户导入',100,6,'','','',1,0,'F','0','0','system:user:import','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1007,'重置密码',100,7,'','','',1,0,'F','0','0','system:user:resetPwd','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1008,'角色查询',101,1,'','','',1,0,'F','0','0','system:role:query','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1009,'角色新增',101,2,'','','',1,0,'F','0','0','system:role:add','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1010,'角色修改',101,3,'','','',1,0,'F','0','0','system:role:edit','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1011,'角色删除',101,4,'','','',1,0,'F','0','0','system:role:remove','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1012,'角色导出',101,5,'','','',1,0,'F','0','0','system:role:export','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1013,'菜单查询',102,1,'','','',1,0,'F','0','0','system:menu:query','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1014,'菜单新增',102,2,'','','',1,0,'F','0','0','system:menu:add','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1015,'菜单修改',102,3,'','','',1,0,'F','0','0','system:menu:edit','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1016,'菜单删除',102,4,'','','',1,0,'F','0','0','system:menu:remove','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1017,'部门查询',103,1,'','','',1,0,'F','0','0','system:dept:query','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1018,'部门新增',103,2,'','','',1,0,'F','0','0','system:dept:add','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1019,'部门修改',103,3,'','','',1,0,'F','0','0','system:dept:edit','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1020,'部门删除',103,4,'','','',1,0,'F','0','0','system:dept:remove','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1021,'岗位查询',104,1,'','','',1,0,'F','0','0','system:post:query','#',103,1,'2025-09-16 17:34:12',NULL,NULL,''),(1022,'岗位新增',104,2,'','','',1,0,'F','0','0','system:post:add','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1023,'岗位修改',104,3,'','','',1,0,'F','0','0','system:post:edit','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1024,'岗位删除',104,4,'','','',1,0,'F','0','0','system:post:remove','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1025,'岗位导出',104,5,'','','',1,0,'F','0','0','system:post:export','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1026,'字典查询',105,1,'#','','',1,0,'F','0','0','system:dict:query','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1027,'字典新增',105,2,'#','','',1,0,'F','0','0','system:dict:add','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1028,'字典修改',105,3,'#','','',1,0,'F','0','0','system:dict:edit','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1029,'字典删除',105,4,'#','','',1,0,'F','0','0','system:dict:remove','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1030,'字典导出',105,5,'#','','',1,0,'F','0','0','system:dict:export','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1031,'参数查询',106,1,'#','','',1,0,'F','0','0','system:config:query','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1032,'参数新增',106,2,'#','','',1,0,'F','0','0','system:config:add','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1033,'参数修改',106,3,'#','','',1,0,'F','0','0','system:config:edit','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1034,'参数删除',106,4,'#','','',1,0,'F','0','0','system:config:remove','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1035,'参数导出',106,5,'#','','',1,0,'F','0','0','system:config:export','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1036,'公告查询',107,1,'#','','',1,0,'F','0','0','system:notice:query','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1037,'公告新增',107,2,'#','','',1,0,'F','0','0','system:notice:add','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1038,'公告修改',107,3,'#','','',1,0,'F','0','0','system:notice:edit','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1039,'公告删除',107,4,'#','','',1,0,'F','0','0','system:notice:remove','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1040,'操作查询',500,1,'#','','',1,0,'F','0','0','monitor:operlog:query','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1041,'操作删除',500,2,'#','','',1,0,'F','0','0','monitor:operlog:remove','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1042,'日志导出',500,4,'#','','',1,0,'F','0','0','monitor:operlog:export','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1043,'登录查询',501,1,'#','','',1,0,'F','0','0','monitor:logininfor:query','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1044,'登录删除',501,2,'#','','',1,0,'F','0','0','monitor:logininfor:remove','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1045,'日志导出',501,3,'#','','',1,0,'F','0','0','monitor:logininfor:export','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1046,'在线查询',109,1,'#','','',1,0,'F','0','0','monitor:online:query','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1047,'批量强退',109,2,'#','','',1,0,'F','0','0','monitor:online:batchLogout','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1048,'单条强退',109,3,'#','','',1,0,'F','0','0','monitor:online:forceLogout','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1050,'账户解锁',501,4,'#','','',1,0,'F','0','0','monitor:logininfor:unlock','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1055,'生成查询',115,1,'#','','',1,0,'F','0','0','tool:gen:query','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1056,'生成修改',115,2,'#','','',1,0,'F','0','0','tool:gen:edit','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1057,'生成删除',115,3,'#','','',1,0,'F','0','0','tool:gen:remove','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1058,'导入代码',115,2,'#','','',1,0,'F','0','0','tool:gen:import','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1059,'预览代码',115,4,'#','','',1,0,'F','0','0','tool:gen:preview','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1060,'生成代码',115,5,'#','','',1,0,'F','0','0','tool:gen:code','#',103,1,'2025-09-16 17:34:13',NULL,NULL,''),(1061,'客户端管理查询',123,1,'#','','',1,0,'F','0','0','system:client:query','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1062,'客户端管理新增',123,2,'#','','',1,0,'F','0','0','system:client:add','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1063,'客户端管理修改',123,3,'#','','',1,0,'F','0','0','system:client:edit','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1064,'客户端管理删除',123,4,'#','','',1,0,'F','0','0','system:client:remove','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1065,'客户端管理导出',123,5,'#','','',1,0,'F','0','0','system:client:export','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1500,'测试单表',5,1,'demo','demo/demo/index','',1,0,'C','0','0','demo:demo:list','#',103,1,'2025-09-16 17:34:14',NULL,NULL,'测试单表菜单'),(1501,'测试单表查询',1500,1,'#','','',1,0,'F','0','0','demo:demo:query','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1502,'测试单表新增',1500,2,'#','','',1,0,'F','0','0','demo:demo:add','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1503,'测试单表修改',1500,3,'#','','',1,0,'F','0','0','demo:demo:edit','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1504,'测试单表删除',1500,4,'#','','',1,0,'F','0','0','demo:demo:remove','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1505,'测试单表导出',1500,5,'#','','',1,0,'F','0','0','demo:demo:export','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1506,'测试树表',5,1,'tree','demo/tree/index','',1,0,'C','0','0','demo:tree:list','#',103,1,'2025-09-16 17:34:14',NULL,NULL,'测试树表菜单'),(1507,'测试树表查询',1506,1,'#','','',1,0,'F','0','0','demo:tree:query','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1508,'测试树表新增',1506,2,'#','','',1,0,'F','0','0','demo:tree:add','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1509,'测试树表修改',1506,3,'#','','',1,0,'F','0','0','demo:tree:edit','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1510,'测试树表删除',1506,4,'#','','',1,0,'F','0','0','demo:tree:remove','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1511,'测试树表导出',1506,5,'#','','',1,0,'F','0','0','demo:tree:export','#',103,1,'2025-09-16 17:34:15',NULL,NULL,''),(1600,'文件查询',118,1,'#','','',1,0,'F','0','0','system:oss:query','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1601,'文件上传',118,2,'#','','',1,0,'F','0','0','system:oss:upload','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1602,'文件下载',118,3,'#','','',1,0,'F','0','0','system:oss:download','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1603,'文件删除',118,4,'#','','',1,0,'F','0','0','system:oss:remove','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1606,'租户查询',121,1,'#','','',1,0,'F','0','0','system:tenant:query','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1607,'租户新增',121,2,'#','','',1,0,'F','0','0','system:tenant:add','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1608,'租户修改',121,3,'#','','',1,0,'F','0','0','system:tenant:edit','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1609,'租户删除',121,4,'#','','',1,0,'F','0','0','system:tenant:remove','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1610,'租户导出',121,5,'#','','',1,0,'F','0','0','system:tenant:export','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1611,'租户套餐查询',122,1,'#','','',1,0,'F','0','0','system:tenantPackage:query','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1612,'租户套餐新增',122,2,'#','','',1,0,'F','0','0','system:tenantPackage:add','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1613,'租户套餐修改',122,3,'#','','',1,0,'F','0','0','system:tenantPackage:edit','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1614,'租户套餐删除',122,4,'#','','',1,0,'F','0','0','system:tenantPackage:remove','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1615,'租户套餐导出',122,5,'#','','',1,0,'F','0','0','system:tenantPackage:export','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1620,'配置列表',118,5,'#','','',1,0,'F','0','0','system:ossConfig:list','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1621,'配置添加',118,6,'#','','',1,0,'F','0','0','system:ossConfig:add','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1622,'配置编辑',118,6,'#','','',1,0,'F','0','0','system:ossConfig:edit','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(1623,'配置删除',118,6,'#','','',1,0,'F','0','0','system:ossConfig:remove','#',103,1,'2025-09-16 17:34:14',NULL,NULL,''),(11616,'工作流',0,6,'workflow','','',1,0,'M','1','0','','workflow',103,1,'2025-09-16 17:35:15',1,'2025-09-17 10:13:36',''),(11618,'我的任务',0,7,'task','','',1,0,'M','1','0','','my-task',103,1,'2025-09-16 17:35:15',1,'2025-09-17 10:13:42',''),(11619,'我的待办',11618,2,'taskWaiting','workflow/task/taskWaiting','',1,1,'C','0','0','','waiting',103,1,'2025-09-16 17:35:15',NULL,NULL,''),(11620,'流程定义',11616,3,'processDefinition','workflow/processDefinition/index','',1,1,'C','0','0','','process-definition',103,1,'2025-09-16 17:35:15',NULL,NULL,''),(11621,'流程实例',11630,1,'processInstance','workflow/processInstance/index','',1,1,'C','0','0','','tree-table',103,1,'2025-09-16 17:35:15',NULL,NULL,''),(11622,'流程分类',11616,1,'category','workflow/category/index','',1,0,'C','0','0','workflow:category:list','category',103,1,'2025-09-16 17:35:15',NULL,NULL,''),(11623,'流程分类查询',11622,1,'#','','',1,0,'F','0','0','workflow:category:query','#',103,1,'2025-09-16 17:35:16',NULL,NULL,''),(11624,'流程分类新增',11622,2,'#','','',1,0,'F','0','0','workflow:category:add','#',103,1,'2025-09-16 17:35:16',NULL,NULL,''),(11625,'流程分类修改',11622,3,'#','','',1,0,'F','0','0','workflow:category:edit','#',103,1,'2025-09-16 17:35:16',NULL,NULL,''),(11626,'流程分类删除',11622,4,'#','','',1,0,'F','0','0','workflow:category:remove','#',103,1,'2025-09-16 17:35:16',NULL,NULL,''),(11627,'流程分类导出',11622,5,'#','','',1,0,'F','0','0','workflow:category:export','#',103,1,'2025-09-16 17:35:16',NULL,NULL,''),(11629,'我发起的',11618,1,'myDocument','workflow/task/myDocument','',1,1,'C','0','0','','guide',103,1,'2025-09-16 17:35:15',NULL,NULL,''),(11630,'流程监控',11616,4,'monitor','','',1,0,'M','0','0','','monitor',103,1,'2025-09-16 17:35:15',NULL,NULL,''),(11631,'待办任务',11630,2,'allTaskWaiting','workflow/task/allTaskWaiting','',1,1,'C','0','0','','waiting',103,1,'2025-09-16 17:35:16',NULL,NULL,''),(11632,'我的已办',11618,3,'taskFinish','workflow/task/taskFinish','',1,1,'C','0','0','','finish',103,1,'2025-09-16 17:35:15',NULL,NULL,''),(11633,'我的抄送',11618,4,'taskCopyList','workflow/task/taskCopyList','',1,1,'C','0','0','','my-copy',103,1,'2025-09-16 17:35:15',NULL,NULL,''),(11638,'请假申请',5,1,'leave','workflow/leave/index','',1,0,'C','0','0','workflow:leave:list','#',103,1,'2025-09-16 17:35:16',NULL,NULL,'请假申请菜单'),(11639,'请假申请查询',11638,1,'#','','',1,0,'F','0','0','workflow:leave:query','#',103,1,'2025-09-16 17:35:16',NULL,NULL,''),(11640,'请假申请新增',11638,2,'#','','',1,0,'F','0','0','workflow:leave:add','#',103,1,'2025-09-16 17:35:16',NULL,NULL,''),(11641,'请假申请修改',11638,3,'#','','',1,0,'F','0','0','workflow:leave:edit','#',103,1,'2025-09-16 17:35:16',NULL,NULL,''),(11642,'请假申请删除',11638,4,'#','','',1,0,'F','0','0','workflow:leave:remove','#',103,1,'2025-09-16 17:35:16',NULL,NULL,''),(11643,'请假申请导出',11638,5,'#','','',1,0,'F','0','0','workflow:leave:export','#',103,1,'2025-09-16 17:35:16',NULL,NULL,''),(11700,'流程设计',11616,5,'design/index','workflow/processDefinition/design','',1,1,'C','1','0','workflow:leave:edit','#',103,1,'2025-09-16 17:35:16',NULL,NULL,''),(11701,'请假申请',11616,6,'leaveEdit/index','workflow/leave/leaveEdit','',1,1,'C','1','0','workflow:leave:edit','#',103,1,'2025-09-16 17:35:16',NULL,NULL,''),(1967889217736355841,'护理分类',1968135796330299394,1,'category','reporting/category/index',NULL,1,0,'C','0','0','reporting:category:list','#',103,1,'2025-09-16 18:05:57',1,'2025-09-17 10:12:41','护理数据填报分类菜单'),(1967889217736355842,'护理数据填报分类查询',1967889217736355841,1,'#','',NULL,1,0,'F','0','0','reporting:category:query','#',103,1,'2025-09-16 18:05:57',NULL,NULL,''),(1967889217736355843,'护理数据填报分类新增',1967889217736355841,2,'#','',NULL,1,0,'F','0','0','reporting:category:add','#',103,1,'2025-09-16 18:05:57',NULL,NULL,''),(1967889217736355844,'护理数据填报分类修改',1967889217736355841,3,'#','',NULL,1,0,'F','0','0','reporting:category:edit','#',103,1,'2025-09-16 18:05:58',NULL,NULL,''),(1967889217736355845,'护理数据填报分类删除',1967889217736355841,4,'#','',NULL,1,0,'F','0','0','reporting:category:remove','#',103,1,'2025-09-16 18:05:58',NULL,NULL,''),(1967889217736355846,'护理数据填报分类导出',1967889217736355841,5,'#','',NULL,1,0,'F','0','0','reporting:category:export','#',103,1,'2025-09-16 18:05:58',NULL,NULL,''),(1967889227014156290,'护理数据',1968135796330299394,1,'reportData','reporting/reportData/index',NULL,1,0,'C','0','0','reporting:data:list','#',103,1,'2025-09-16 18:05:58',1,'2025-09-17 10:12:23','护理数据填报菜单'),(1967889227014156291,'护理数据填报查询',1967889227014156290,1,'#','',NULL,1,0,'F','0','0','reporting:reportData:query','#',103,1,'2025-09-16 18:05:58',NULL,NULL,''),(1967889227014156292,'护理数据填报新增',1967889227014156290,2,'#','',NULL,1,0,'F','0','0','reporting:reportData:add','#',103,1,'2025-09-16 18:05:58',NULL,NULL,''),(1967889227014156293,'护理数据填报修改',1967889227014156290,3,'#','',NULL,1,0,'F','0','0','reporting:reportData:edit','#',103,1,'2025-09-16 18:05:58',NULL,NULL,''),(1967889227014156294,'护理数据填报删除',1967889227014156290,4,'#','',NULL,1,0,'F','0','0','reporting:reportData:remove','#',103,1,'2025-09-16 18:05:58',NULL,NULL,''),(1967889227014156295,'护理数据填报导出',1967889227014156290,5,'#','',NULL,1,0,'F','0','0','reporting:reportData:export','#',103,1,'2025-09-16 18:05:58',NULL,NULL,''),(1968135796330299394,'护理信息',0,1,'nursing',NULL,NULL,1,0,'M','0','0',NULL,'peoples',103,1,'2025-09-17 10:11:55',1,'2025-09-17 10:11:55','');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice` (
  `notice_id` bigint NOT NULL COMMENT '公告ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'000000','温馨提醒：2018-07-01 新版本发布啦','2',_binary '新版本内容','0',103,1,'2025-09-16 17:34:20',NULL,NULL,'管理员'),(2,'000000','维护通知：2018-07-01 系统凌晨维护','1',_binary '维护内容','0',103,1,'2025-09-16 17:34:21',NULL,NULL,'管理员');
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL COMMENT '日志主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(4000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(4000) DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(4000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (1967889162270879745,'000000','代码生成',6,'org.dromara.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','0:0:0:0:0:0:0:1','内网IP','{\"tables\":\"nursing_category,nursing_report_data\",\"dataName\":\"master\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-16 17:51:53',876),(1967889219405688833,'000000','代码生成',8,'org.dromara.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','0:0:0:0:0:0:0:1','内网IP','{\"tableIdStr\":\"1967889159863349249\"}','',0,'','2025-09-16 17:52:06',418),(1967889227592970242,'000000','代码生成',8,'org.dromara.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','0:0:0:0:0:0:0:1','内网IP','{\"tableIdStr\":\"1967889161171972097\"}','',0,'','2025-09-16 17:52:08',166),(1967891583432904705,'000000','护理数据填报',6,'org.dromara.reporting.controller.NursingReportDataController.importData()','POST',1,'admin','研发部门','/reporting/data/importData','0:0:0:0:0:0:0:1','内网IP','','',1,'分类【null】不存在!','2025-09-16 18:01:30',2001),(1967893012130189313,'000000','护理数据填报',6,'org.dromara.reporting.controller.NursingReportDataController.importData()','POST',1,'admin','研发部门','/reporting/data/importData','0:0:0:0:0:0:0:1','内网IP','','',1,'\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_name\' doesn\'t have a default value\r\n### The error may exist in org/dromara/reporting/mapper/NursingCategoryMapper.java (best guess)\r\n### The error may involve org.dromara.reporting.mapper.NursingCategoryMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO nursing_category (category_id, category_code, parent_id, order_num, status, remark, create_dept, create_by, create_time, update_by, update_time, tenant_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, \'000000\')\r\n### Cause: java.sql.SQLException: Field \'category_name\' doesn\'t have a default value\n; Field \'category_name\' doesn\'t have a default value','2025-09-16 18:07:10',1291),(1967893446144184322,'000000','护理数据填报',6,'org.dromara.reporting.controller.NursingReportDataController.importData()','POST',1,'admin','研发部门','/reporting/data/importData','0:0:0:0:0:0:0:1','内网IP','','',1,'\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_name\' doesn\'t have a default value\r\n### The error may exist in org/dromara/reporting/mapper/NursingCategoryMapper.java (best guess)\r\n### The error may involve org.dromara.reporting.mapper.NursingCategoryMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO nursing_category (category_id, category_code, parent_id, order_num, status, remark, create_dept, create_by, create_time, update_by, update_time, tenant_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, \'000000\')\r\n### Cause: java.sql.SQLException: Field \'category_name\' doesn\'t have a default value\n; Field \'category_name\' doesn\'t have a default value','2025-09-16 18:08:54',56264),(1967902004604719105,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-09-16 18:05:57\",\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1967889217736355841\",\"parentId\":3,\"menuName\":\"护理数据填报分类\",\"orderNum\":1,\"path\":\"category\",\"component\":\"reporting/category/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"reporting:category:list\",\"icon\":\"#\",\"remark\":\"护理数据填报分类菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-16 18:42:54',95),(1967902158711836674,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-09-16 18:05:58\",\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1967889227014156290\",\"parentId\":3,\"menuName\":\"护理数据填报\",\"orderNum\":1,\"path\":\"reportData\",\"component\":\"reporting/reportData/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"reporting:data:list\",\"icon\":\"#\",\"remark\":\"护理数据填报菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-16 18:43:31',71),(1967903437878087682,'000000','护理数据填报',6,'org.dromara.reporting.controller.NursingReportDataController.importData()','POST',1,'admin','研发部门','/reporting/data/importData','0:0:0:0:0:0:0:1','内网IP','','',1,'\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_name\' doesn\'t have a default value\r\n### The error may exist in org/dromara/reporting/mapper/NursingCategoryMapper.java (best guess)\r\n### The error may involve org.dromara.reporting.mapper.NursingCategoryMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO nursing_category (category_id, category_code, parent_id, order_num, status, remark, create_dept, create_by, create_time, update_by, update_time, tenant_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, \'000000\')\r\n### Cause: java.sql.SQLException: Field \'category_name\' doesn\'t have a default value\n; Field \'category_name\' doesn\'t have a default value','2025-09-16 18:48:36',12625),(1967903859955093505,'000000','护理数据填报',6,'org.dromara.reporting.controller.NursingReportDataController.importData()','POST',1,'admin','研发部门','/reporting/data/importData','0:0:0:0:0:0:0:1','内网IP','','',1,'\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_name\' doesn\'t have a default value\r\n### The error may exist in org/dromara/reporting/mapper/NursingCategoryMapper.java (best guess)\r\n### The error may involve org.dromara.reporting.mapper.NursingCategoryMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO nursing_category (category_id, category_code, parent_id, order_num, status, remark, create_dept, create_by, create_time, update_by, update_time, tenant_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, \'000000\')\r\n### Cause: java.sql.SQLException: Field \'category_name\' doesn\'t have a default value\n; Field \'category_name\' doesn\'t have a default value','2025-09-16 18:50:17',131),(1967903994797772802,'000000','护理数据填报',6,'org.dromara.reporting.controller.NursingReportDataController.importData()','POST',1,'admin','研发部门','/reporting/data/importData','0:0:0:0:0:0:0:1','内网IP','','',1,'\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'category_name\' doesn\'t have a default value\r\n### The error may exist in org/dromara/reporting/mapper/NursingCategoryMapper.java (best guess)\r\n### The error may involve org.dromara.reporting.mapper.NursingCategoryMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO nursing_category (category_id, category_code, parent_id, order_num, status, remark, create_dept, create_by, create_time, update_by, update_time, tenant_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, \'000000\')\r\n### Cause: java.sql.SQLException: Field \'category_name\' doesn\'t have a default value\n; Field \'category_name\' doesn\'t have a default value','2025-09-16 18:50:49',132),(1967904437233963010,'000000','护理数据填报',6,'org.dromara.reporting.controller.NursingReportDataController.importData()','POST',1,'admin','研发部门','/reporting/data/importData','0:0:0:0:0:0:0:1','内网IP','','{\"code\":500,\"msg\":\"导入失败：\\r\\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'report_season\' in \'where clause\'\\r\\n### The error may exist in org/dromara/reporting/mapper/NursingReportDataMapper.java (best guess)\\r\\n### The error may involve defaultParameterMap\\r\\n### The error occurred while setting parameters\\r\\n### SQL: SELECT COUNT(*) AS total FROM nursing_report_data WHERE del_flag = 0 AND (indicator_code = ? AND category_id = ? AND report_year = ? AND report_season = ?) AND tenant_id = \'000000\'\\r\\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'report_season\' in \'where clause\'\\n; bad SQL grammar []\",\"data\":null}',0,'','2025-09-16 18:52:34',21713),(1967904700384595970,'000000','护理数据填报',6,'org.dromara.reporting.controller.NursingReportDataController.importData()','POST',1,'admin','研发部门','/reporting/data/importData','0:0:0:0:0:0:0:1','内网IP','','{\"code\":200,\"msg\":\"导入成功，共处理29条数据\",\"data\":null}',0,'','2025-09-16 18:53:37',2852),(1967906935512420353,'000000','护理数据填报',6,'org.dromara.reporting.controller.NursingReportDataController.importData()','POST',1,'admin','研发部门','/reporting/data/importData','0:0:0:0:0:0:0:1','内网IP','','{\"code\":500,\"msg\":\"导入失败：指标编码在同一分类同一时间段内已存在!\",\"data\":null}',0,'','2025-09-16 19:02:30',108601),(1967907464833585154,'000000','护理数据填报',6,'org.dromara.reporting.controller.NursingReportDataController.importData()','POST',1,'admin','研发部门','/reporting/data/importData','0:0:0:0:0:0:0:1','内网IP','','{\"code\":500,\"msg\":\"导入失败：指标编码在同一分类同一时间段内已存在!\",\"data\":null}',0,'','2025-09-16 19:04:36',92689),(1967908636843778049,'000000','护理数据填报',6,'org.dromara.reporting.controller.NursingReportDataController.importData()','POST',1,'admin','研发部门','/reporting/data/importData','0:0:0:0:0:0:0:1','内网IP','','',1,'指标编码在同一分类同一时间段内已存在!','2025-09-16 19:09:16',1443),(1967909734019170306,'000000','护理数据填报',6,'org.dromara.reporting.controller.NursingReportDataController.importData()','POST',1,'admin','研发部门','/reporting/data/importData','0:0:0:0:0:0:0:1','内网IP','','',1,'指标编码在同一分类同一时间段内已存在!','2025-09-16 19:13:37',1457),(1967911267108646913,'000000','护理数据填报',6,'org.dromara.reporting.controller.NursingReportDataController.importData()','POST',1,'admin','研发部门','/reporting/data/importData','0:0:0:0:0:0:0:1','内网IP','','{\"code\":200,\"msg\":\"导入成功，共导入136条数据\",\"data\":null}',0,'','2025-09-16 19:19:43',8129),(1968135796523237378,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":0,\"menuName\":\"护理信息\",\"orderNum\":1,\"path\":\"nursing\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"peoples\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 10:11:55',79),(1968135855193161730,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-09-16 18:05:57\",\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1967889217736355841\",\"parentId\":\"1968135796330299394\",\"menuName\":\"护理数据填报分类\",\"orderNum\":1,\"path\":\"category\",\"component\":\"reporting/category/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"reporting:category:list\",\"icon\":\"#\",\"remark\":\"护理数据填报分类菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 10:12:09',95),(1968135916241256450,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-09-16 18:05:58\",\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1967889227014156290\",\"parentId\":\"1968135796330299394\",\"menuName\":\"护理数据\",\"orderNum\":1,\"path\":\"reportData\",\"component\":\"reporting/reportData/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"reporting:data:list\",\"icon\":\"#\",\"remark\":\"护理数据填报菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 10:12:23',62),(1968135990849536001,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-09-16 18:05:57\",\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1967889217736355841\",\"parentId\":\"1968135796330299394\",\"menuName\":\"护理分类\",\"orderNum\":1,\"path\":\"category\",\"component\":\"reporting/category/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"reporting:category:list\",\"icon\":\"#\",\"remark\":\"护理数据填报分类菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 10:12:41',66),(1968136157451485186,'000000','菜单管理',3,'org.dromara.system.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','0:0:0:0:0:0:0:1','内网IP','4','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 10:13:21',74),(1968136187474313218,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-09-16 17:34:11\",\"updateBy\":null,\"updateTime\":null,\"menuId\":5,\"parentId\":0,\"menuName\":\"测试菜单\",\"orderNum\":5,\"path\":\"demo\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"star\",\"remark\":\"测试菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 10:13:28',65),(1968136221783719938,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-09-16 17:35:15\",\"updateBy\":null,\"updateTime\":null,\"menuId\":11616,\"parentId\":0,\"menuName\":\"工作流\",\"orderNum\":6,\"path\":\"workflow\",\"component\":\"\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"workflow\",\"remark\":\"\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 10:13:36',61),(1968136244810448898,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-09-16 17:35:15\",\"updateBy\":null,\"updateTime\":null,\"menuId\":11618,\"parentId\":0,\"menuName\":\"我的任务\",\"orderNum\":7,\"path\":\"task\",\"component\":\"\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"my-task\",\"remark\":\"\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 10:13:42',82),(1968136350288805889,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-09-16 17:34:11\",\"updateBy\":null,\"updateTime\":null,\"menuId\":1,\"parentId\":0,\"menuName\":\"系统管理\",\"orderNum\":10,\"path\":\"system\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"system\",\"remark\":\"系统管理目录\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 10:14:07',69),(1968136405414543362,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-09-16 17:34:11\",\"updateBy\":null,\"updateTime\":null,\"menuId\":6,\"parentId\":0,\"menuName\":\"租户管理\",\"orderNum\":20,\"path\":\"tenant\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"chart\",\"remark\":\"租户管理目录\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 10:14:20',69),(1968136441254871041,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-09-16 17:34:11\",\"updateBy\":null,\"updateTime\":null,\"menuId\":2,\"parentId\":0,\"menuName\":\"系统监控\",\"orderNum\":30,\"path\":\"monitor\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"monitor\",\"remark\":\"系统监控目录\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 10:14:28',72),(1968136484804329473,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-09-16 17:34:11\",\"updateBy\":null,\"updateTime\":null,\"menuId\":3,\"parentId\":0,\"menuName\":\"系统工具\",\"orderNum\":40,\"path\":\"tool\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"tool\",\"remark\":\"系统工具目录\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 10:14:39',66),(1968144366543273986,'000000','个人信息',2,'org.dromara.system.controller.system.SysProfileController.updateProfile()','PUT',1,'admin','研发部门','/system/user/profile','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-09-16 17:34:10\",\"updateBy\":null,\"updateTime\":null,\"nickName\":\"管理员\",\"email\":\"abc@163.com\",\"phonenumber\":\"15888888888\",\"sex\":\"1\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 10:45:58',511),(1968227876989698050,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/102','0:0:0:0:0:0:0:1','内网IP','102','{\"code\":601,\"msg\":\"存在下级部门,不允许删除\",\"data\":null}',0,'','2025-09-17 16:17:48',38),(1968227889098653698,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/109','0:0:0:0:0:0:0:1','内网IP','109','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 16:17:51',122),(1968227900637184001,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/108','0:0:0:0:0:0:0:1','内网IP','108','{\"code\":601,\"msg\":\"部门存在用户,不允许删除\",\"data\":null}',0,'','2025-09-17 16:17:54',45),(1968228040022294529,'000000','部门管理',2,'org.dromara.system.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-09-16 17:34:10\",\"updateBy\":null,\"updateTime\":null,\"deptId\":100,\"parentId\":0,\"deptName\":\"首都医科大学\",\"deptCategory\":null,\"orderNum\":0,\"leader\":null,\"phone\":\"15888888888\",\"email\":\"xxx@qq.com\",\"status\":\"0\",\"belongDeptId\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 16:18:27',196),(1968228094300782593,'000000','部门管理',2,'org.dromara.system.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-09-16 17:34:10\",\"updateBy\":null,\"updateTime\":null,\"deptId\":101,\"parentId\":100,\"deptName\":\"医院A\",\"deptCategory\":null,\"orderNum\":1,\"leader\":null,\"phone\":\"15888888888\",\"email\":\"xxx@qq.com\",\"status\":\"0\",\"belongDeptId\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 16:18:40',140),(1968228134478020609,'000000','部门管理',2,'org.dromara.system.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-09-16 17:34:10\",\"updateBy\":null,\"updateTime\":null,\"deptId\":102,\"parentId\":100,\"deptName\":\"医院B\",\"deptCategory\":null,\"orderNum\":2,\"leader\":null,\"phone\":\"15888888888\",\"email\":\"xxx@qq.com\",\"status\":\"0\",\"belongDeptId\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 16:18:50',146),(1968228307627278337,'000000','参数管理',2,'org.dromara.system.controller.system.SysConfigController.edit()','PUT',1,'admin','研发部门','/system/config','0:0:0:0:0:0:0:1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-09-16 17:34:20\",\"updateBy\":null,\"updateTime\":null,\"configId\":2,\"configName\":\"用户管理-账号初始密码\",\"configKey\":\"sys.user.initPassword\",\"configValue\":\"HLSB@202509\",\"configType\":\"Y\",\"remark\":\"初始化密码 123456\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2025-09-17 16:19:31',89);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oss`
--

DROP TABLE IF EXISTS `sys_oss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oss` (
  `oss_id` bigint NOT NULL COMMENT '对象存储主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `file_name` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `original_name` varchar(255) NOT NULL DEFAULT '' COMMENT '原名',
  `file_suffix` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀名',
  `url` varchar(500) NOT NULL COMMENT 'URL地址',
  `ext1` text COMMENT '扩展字段',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '上传人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `service` varchar(20) NOT NULL DEFAULT 'minio' COMMENT '服务商',
  PRIMARY KEY (`oss_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='OSS对象存储表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oss`
--

LOCK TABLES `sys_oss` WRITE;
/*!40000 ALTER TABLE `sys_oss` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_oss` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oss_config`
--

DROP TABLE IF EXISTS `sys_oss_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oss_config` (
  `oss_config_id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `config_key` varchar(20) NOT NULL DEFAULT '' COMMENT '配置key',
  `access_key` varchar(255) DEFAULT '' COMMENT 'accessKey',
  `secret_key` varchar(255) DEFAULT '' COMMENT '秘钥',
  `bucket_name` varchar(255) DEFAULT '' COMMENT '桶名称',
  `prefix` varchar(255) DEFAULT '' COMMENT '前缀',
  `endpoint` varchar(255) DEFAULT '' COMMENT '访问站点',
  `domain` varchar(255) DEFAULT '' COMMENT '自定义域名',
  `is_https` char(1) DEFAULT 'N' COMMENT '是否https（Y=是,N=否）',
  `region` varchar(255) DEFAULT '' COMMENT '域',
  `access_policy` char(1) NOT NULL DEFAULT '1' COMMENT '桶权限类型(0=private 1=public 2=custom)',
  `status` char(1) DEFAULT '1' COMMENT '是否默认（0=是,1=否）',
  `ext1` varchar(255) DEFAULT '' COMMENT '扩展字段',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`oss_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='对象存储配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oss_config`
--

LOCK TABLES `sys_oss_config` WRITE;
/*!40000 ALTER TABLE `sys_oss_config` DISABLE KEYS */;
INSERT INTO `sys_oss_config` VALUES (1,'000000','minio','ruoyi','ruoyi123','ruoyi','','127.0.0.1:9000','','N','','1','0','',103,1,'2025-09-16 17:34:21',1,'2025-09-16 17:34:21',NULL),(2,'000000','qiniu','XXXXXXXXXXXXXXX','XXXXXXXXXXXXXXX','ruoyi','','s3-cn-north-1.qiniucs.com','','N','','1','1','',103,1,'2025-09-16 17:34:21',1,'2025-09-16 17:34:21',NULL),(3,'000000','aliyun','XXXXXXXXXXXXXXX','XXXXXXXXXXXXXXX','ruoyi','','oss-cn-beijing.aliyuncs.com','','N','','1','1','',103,1,'2025-09-16 17:34:21',1,'2025-09-16 17:34:21',NULL),(4,'000000','qcloud','XXXXXXXXXXXXXXX','XXXXXXXXXXXXXXX','ruoyi-1240000000','','cos.ap-beijing.myqcloud.com','','N','ap-beijing','1','1','',103,1,'2025-09-16 17:34:21',1,'2025-09-16 17:34:21',NULL),(5,'000000','image','ruoyi','ruoyi123','ruoyi','image','127.0.0.1:9000','','N','','1','1','',103,1,'2025-09-16 17:34:21',1,'2025-09-16 17:34:21',NULL);
/*!40000 ALTER TABLE `sys_oss_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_category` varchar(100) DEFAULT NULL COMMENT '岗位类别编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'000000',103,'ceo',NULL,'董事长',1,'0',103,1,'2025-09-16 17:34:11',NULL,NULL,''),(2,'000000',100,'se',NULL,'项目经理',2,'0',103,1,'2025-09-16 17:34:11',NULL,NULL,''),(3,'000000',100,'hr',NULL,'人力资源',3,'0',103,1,'2025-09-16 17:34:11',NULL,NULL,''),(4,'000000',100,'user',NULL,'普通员工',4,'0',103,1,'2025-09-16 17:34:11',NULL,NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限 5：仅本人数据权限 6：部门及以下或本人数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'000000','超级管理员','superadmin',1,'1',1,1,'0','0',103,1,'2025-09-16 17:34:11',NULL,NULL,'超级管理员'),(3,'000000','本部门及以下','test1',3,'4',1,1,'0','0',103,1,'2025-09-16 17:34:11',NULL,NULL,''),(4,'000000','仅本人','test2',4,'5',1,1,'0','0',103,1,'2025-09-16 17:34:11',NULL,NULL,'');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (3,1),(3,5),(3,100),(3,101),(3,102),(3,103),(3,104),(3,105),(3,106),(3,107),(3,108),(3,118),(3,123),(3,130),(3,131),(3,132),(3,133),(3,500),(3,501),(3,1001),(3,1002),(3,1003),(3,1004),(3,1005),(3,1006),(3,1007),(3,1008),(3,1009),(3,1010),(3,1011),(3,1012),(3,1013),(3,1014),(3,1015),(3,1016),(3,1017),(3,1018),(3,1019),(3,1020),(3,1021),(3,1022),(3,1023),(3,1024),(3,1025),(3,1026),(3,1027),(3,1028),(3,1029),(3,1030),(3,1031),(3,1032),(3,1033),(3,1034),(3,1035),(3,1036),(3,1037),(3,1038),(3,1039),(3,1040),(3,1041),(3,1042),(3,1043),(3,1044),(3,1045),(3,1050),(3,1061),(3,1062),(3,1063),(3,1064),(3,1065),(3,1500),(3,1501),(3,1502),(3,1503),(3,1504),(3,1505),(3,1506),(3,1507),(3,1508),(3,1509),(3,1510),(3,1511),(3,1600),(3,1601),(3,1602),(3,1603),(3,1620),(3,1621),(3,1622),(3,1623),(3,11616),(3,11618),(3,11619),(3,11622),(3,11623),(3,11629),(3,11632),(3,11633),(3,11638),(3,11639),(3,11640),(3,11641),(3,11642),(3,11643),(3,11701),(4,5),(4,1500),(4,1501),(4,1502),(4,1503),(4,1504),(4,1505),(4,1506),(4,1507),(4,1508),(4,1509),(4,1510),(4,1511);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_social`
--

DROP TABLE IF EXISTS `sys_social`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_social` (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户id',
  `auth_id` varchar(255) NOT NULL COMMENT '平台+平台唯一id',
  `source` varchar(255) NOT NULL COMMENT '用户来源',
  `open_id` varchar(255) DEFAULT NULL COMMENT '平台编号唯一id',
  `user_name` varchar(30) NOT NULL COMMENT '登录账号',
  `nick_name` varchar(30) DEFAULT '' COMMENT '用户昵称',
  `email` varchar(255) DEFAULT '' COMMENT '用户邮箱',
  `avatar` varchar(500) DEFAULT '' COMMENT '头像地址',
  `access_token` varchar(2000) NOT NULL COMMENT '用户的授权令牌',
  `expire_in` int DEFAULT NULL COMMENT '用户的授权令牌的有效期，部分平台可能没有',
  `refresh_token` varchar(255) DEFAULT NULL COMMENT '刷新令牌，部分平台可能没有',
  `access_code` varchar(2000) DEFAULT NULL COMMENT '平台的授权信息，部分平台可能没有',
  `union_id` varchar(255) DEFAULT NULL COMMENT '用户的 unionid',
  `scope` varchar(255) DEFAULT NULL COMMENT '授予的权限，部分平台可能没有',
  `token_type` varchar(255) DEFAULT NULL COMMENT '个别平台的授权信息，部分平台可能没有',
  `id_token` varchar(2000) DEFAULT NULL COMMENT 'id token，部分平台可能没有',
  `mac_algorithm` varchar(255) DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
  `mac_key` varchar(255) DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
  `code` varchar(255) DEFAULT NULL COMMENT '用户的授权code，部分平台可能没有',
  `oauth_token` varchar(255) DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
  `oauth_token_secret` varchar(255) DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='社会化关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_social`
--

LOCK TABLES `sys_social` WRITE;
/*!40000 ALTER TABLE `sys_social` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_social` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_tenant`
--

DROP TABLE IF EXISTS `sys_tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_tenant` (
  `id` bigint NOT NULL COMMENT 'id',
  `tenant_id` varchar(20) NOT NULL COMMENT '租户编号',
  `contact_user_name` varchar(20) DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `company_name` varchar(30) DEFAULT NULL COMMENT '企业名称',
  `license_number` varchar(30) DEFAULT NULL COMMENT '统一社会信用代码',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `intro` varchar(200) DEFAULT NULL COMMENT '企业简介',
  `domain` varchar(200) DEFAULT NULL COMMENT '域名',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `package_id` bigint DEFAULT NULL COMMENT '租户套餐编号',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `account_count` int DEFAULT '-1' COMMENT '用户数量（-1不限制）',
  `status` char(1) DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_tenant`
--

LOCK TABLES `sys_tenant` WRITE;
/*!40000 ALTER TABLE `sys_tenant` DISABLE KEYS */;
INSERT INTO `sys_tenant` VALUES (1,'000000','管理组','15888888888','XXX有限公司',NULL,NULL,'多租户通用后台管理管理系统',NULL,NULL,NULL,NULL,-1,'0','0',103,1,'2025-09-16 17:34:10',NULL,NULL);
/*!40000 ALTER TABLE `sys_tenant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_tenant_package`
--

DROP TABLE IF EXISTS `sys_tenant_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_tenant_package` (
  `package_id` bigint NOT NULL COMMENT '租户套餐id',
  `package_name` varchar(20) DEFAULT NULL COMMENT '套餐名称',
  `menu_ids` varchar(3000) DEFAULT NULL COMMENT '关联菜单id',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租户套餐表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_tenant_package`
--

LOCK TABLES `sys_tenant_package` WRITE;
/*!40000 ALTER TABLE `sys_tenant_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_tenant_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(10) DEFAULT 'sys_user' COMMENT '用户类型（sys_user系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` bigint DEFAULT NULL COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'000000',103,'admin','管理员','sys_user','abc@163.com','15888888888','1',NULL,'$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','0:0:0:0:0:0:0:1','2025-09-17 15:28:19',103,1,'2025-09-16 17:34:10',-1,'2025-09-17 15:28:19','管理员'),(3,'000000',108,'test','本部门及以下 密码666666','sys_user','','','0',NULL,'$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne','0','0','127.0.0.1','2025-09-16 17:34:10',103,1,'2025-09-16 17:34:10',3,'2025-09-16 17:34:10',NULL),(4,'000000',102,'test1','仅本人 密码666666','sys_user','','','0',NULL,'$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne','0','0','127.0.0.1','2025-09-16 17:34:11',103,1,'2025-09-16 17:34:11',4,'2025-09-16 17:34:11',NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(3,3),(4,4);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_demo`
--

DROP TABLE IF EXISTS `test_demo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_demo` (
  `id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint DEFAULT NULL COMMENT '部门id',
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `order_num` int DEFAULT '0' COMMENT '排序号',
  `test_key` varchar(255) DEFAULT NULL COMMENT 'key键',
  `value` varchar(255) DEFAULT NULL COMMENT '值',
  `version` int DEFAULT '0' COMMENT '版本',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `del_flag` int DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='测试单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_demo`
--

LOCK TABLES `test_demo` WRITE;
/*!40000 ALTER TABLE `test_demo` DISABLE KEYS */;
INSERT INTO `test_demo` VALUES (1,'000000',102,4,1,'测试数据权限','测试',0,103,'2025-09-16 17:34:21',1,NULL,NULL,0),(2,'000000',102,3,2,'子节点1','111',0,103,'2025-09-16 17:34:21',1,NULL,NULL,0),(3,'000000',102,3,3,'子节点2','222',0,103,'2025-09-16 17:34:21',1,NULL,NULL,0),(4,'000000',108,4,4,'测试数据','demo',0,103,'2025-09-16 17:34:21',1,NULL,NULL,0),(5,'000000',108,3,13,'子节点11','1111',0,103,'2025-09-16 17:34:21',1,NULL,NULL,0),(6,'000000',108,3,12,'子节点22','2222',0,103,'2025-09-16 17:34:21',1,NULL,NULL,0),(7,'000000',108,3,11,'子节点33','3333',0,103,'2025-09-16 17:34:21',1,NULL,NULL,0),(8,'000000',108,3,10,'子节点44','4444',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(9,'000000',108,3,9,'子节点55','5555',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(10,'000000',108,3,8,'子节点66','6666',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(11,'000000',108,3,7,'子节点77','7777',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(12,'000000',108,3,6,'子节点88','8888',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(13,'000000',108,3,5,'子节点99','9999',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0);
/*!40000 ALTER TABLE `test_demo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_leave`
--

DROP TABLE IF EXISTS `test_leave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_leave` (
  `id` bigint NOT NULL COMMENT 'id',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `leave_type` varchar(255) NOT NULL COMMENT '请假类型',
  `start_date` datetime NOT NULL COMMENT '开始时间',
  `end_date` datetime NOT NULL COMMENT '结束时间',
  `leave_days` int NOT NULL COMMENT '请假天数',
  `remark` varchar(255) DEFAULT NULL COMMENT '请假原因',
  `status` varchar(255) DEFAULT NULL COMMENT '状态',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='请假申请表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_leave`
--

LOCK TABLES `test_leave` WRITE;
/*!40000 ALTER TABLE `test_leave` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_leave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_tree`
--

DROP TABLE IF EXISTS `test_tree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_tree` (
  `id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint DEFAULT '0' COMMENT '父id',
  `dept_id` bigint DEFAULT NULL COMMENT '部门id',
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `tree_name` varchar(255) DEFAULT NULL COMMENT '值',
  `version` int DEFAULT '0' COMMENT '版本',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `del_flag` int DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='测试树表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_tree`
--

LOCK TABLES `test_tree` WRITE;
/*!40000 ALTER TABLE `test_tree` DISABLE KEYS */;
INSERT INTO `test_tree` VALUES (1,'000000',0,102,4,'测试数据权限',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(2,'000000',1,102,3,'子节点1',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(3,'000000',2,102,3,'子节点2',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(4,'000000',0,108,4,'测试树1',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(5,'000000',4,108,3,'子节点11',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(6,'000000',4,108,3,'子节点22',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(7,'000000',4,108,3,'子节点33',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(8,'000000',5,108,3,'子节点44',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(9,'000000',6,108,3,'子节点55',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(10,'000000',7,108,3,'子节点66',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(11,'000000',7,108,3,'子节点77',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(12,'000000',10,108,3,'子节点88',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0),(13,'000000',10,108,3,'子节点99',0,103,'2025-09-16 17:34:22',1,NULL,NULL,0);
/*!40000 ALTER TABLE `test_tree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'sy_nr'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-17 16:22:50
