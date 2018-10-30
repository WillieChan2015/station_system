/*
Navicat MySQL Data Transfer

Source Server         : 车站课设
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : station_system

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-01-08 15:44:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `account_info`
-- ----------------------------
DROP TABLE IF EXISTS `account_info`;
CREATE TABLE `account_info` (
  `account` varchar(20) NOT NULL,
  `passwd` varchar(40) NOT NULL,
  `id_type` tinyint(4) DEFAULT NULL COMMENT '账号类型：3——管理员；2——售票员',
  PRIMARY KEY (`account`,`passwd`),
  KEY `id_type` (`id_type`),
  CONSTRAINT `account_info_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `type_account_list` (`id_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_info
-- ----------------------------
INSERT INTO `account_info` VALUES ('mc', 'e10adc3949ba59abbe56e057f20f883e', '1');
INSERT INTO `account_info` VALUES ('root', '25f9e794323b453885f5181f1b624d0b', '2');

-- ----------------------------
-- Table structure for `alter_ticket_info`
-- ----------------------------
DROP TABLE IF EXISTS `alter_ticket_info`;
CREATE TABLE `alter_ticket_info` (
  `p_id` varchar(18) NOT NULL,
  `otk_no` varchar(20) NOT NULL COMMENT '原车票编号',
  `atk_no` varchar(20) NOT NULL COMMENT '改签车票编号',
  `car_no` varchar(25) NOT NULL,
  `seat_no` tinyint(3) unsigned DEFAULT NULL,
  `alter_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '标志信息：1——已改签；-2——已退票；-1——已出行；0——已过期（未乘车）',
  PRIMARY KEY (`p_id`,`car_no`),
  KEY `fk_ati2tbi_pid_tkno` (`p_id`,`otk_no`),
  KEY `status` (`status`),
  CONSTRAINT `alter_ticket_info_ibfk_1` FOREIGN KEY (`status`) REFERENCES `status_info` (`status`),
  CONSTRAINT `fk_ati2tbi_pid_tkno` FOREIGN KEY (`p_id`, `otk_no`) REFERENCES `ticket_buy_info` (`p_id`, `tk_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alter_ticket_info
-- ----------------------------

-- ----------------------------
-- Table structure for `car_info`
-- ----------------------------
DROP TABLE IF EXISTS `car_info`;
CREATE TABLE `car_info` (
  `car_no` varchar(25) NOT NULL COMMENT '车次号',
  `licence_plate` varchar(25) DEFAULT NULL COMMENT '车牌号',
  `start_station` varchar(30) DEFAULT NULL COMMENT '起点站',
  `end_station` varchar(30) DEFAULT NULL COMMENT '终点站',
  `start_time` datetime DEFAULT NULL COMMENT '出发时间',
  `cost_time` time DEFAULT NULL COMMENT '花费时间',
  `limited_num` tinyint(3) unsigned DEFAULT NULL COMMENT '限载人数',
  PRIMARY KEY (`car_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of car_info
-- ----------------------------
INSERT INTO `car_info` VALUES ('广深180108001', '粤A-5672', '广州', '深圳', '2018-01-08 06:00:00', '01:21:00', '40');
INSERT INTO `car_info` VALUES ('广深180108002', '粤A-7503', '广州', '深圳', '2018-01-08 06:30:00', '01:36:00', '44');
INSERT INTO `car_info` VALUES ('广深180108003', '粤A-1470', '广州', '深圳', '2018-01-08 07:00:00', '02:18:00', '44');
INSERT INTO `car_info` VALUES ('广深180108004', '粤A-6383', '广州', '深圳', '2018-01-08 07:30:00', '02:53:00', '32');
INSERT INTO `car_info` VALUES ('广深180108005', '粤A-4144', '广州', '深圳', '2018-01-08 08:00:00', '02:19:00', '40');
INSERT INTO `car_info` VALUES ('广深180108006', '粤A-3109', '广州', '深圳', '2018-01-08 08:30:00', '02:45:00', '34');
INSERT INTO `car_info` VALUES ('广深180108007', '粤A-8187', '广州', '深圳', '2018-01-08 09:00:00', '01:38:00', '40');
INSERT INTO `car_info` VALUES ('广深180108008', '粤A-0300', '广州', '深圳', '2018-01-08 09:30:00', '02:19:00', '40');
INSERT INTO `car_info` VALUES ('广深180108009', '粤A-7823', '广州', '深圳', '2018-01-08 10:00:00', '02:36:00', '34');
INSERT INTO `car_info` VALUES ('广深180108010', '粤A-2081', '广州', '深圳', '2018-01-08 10:30:00', '02:25:00', '36');
INSERT INTO `car_info` VALUES ('广深180108011', '粤A-9025', '广州', '深圳', '2018-01-08 11:00:00', '01:19:00', '38');
INSERT INTO `car_info` VALUES ('广深180108012', '粤A-8174', '广州', '深圳', '2018-01-08 11:30:00', '01:02:00', '34');
INSERT INTO `car_info` VALUES ('广深180108013', '粤A-9070', '广州', '深圳', '2018-01-08 12:00:00', '02:40:00', '38');
INSERT INTO `car_info` VALUES ('广深180108014', '粤A-0293', '广州', '深圳', '2018-01-08 12:30:00', '01:11:00', '40');
INSERT INTO `car_info` VALUES ('广深180108015', '粤A-7994', '广州', '深圳', '2018-01-08 13:00:00', '02:02:00', '36');
INSERT INTO `car_info` VALUES ('广深180108016', '粤A-0870', '广州', '深圳', '2018-01-08 13:30:00', '02:47:00', '30');
INSERT INTO `car_info` VALUES ('广深180108017', '粤A-7122', '广州', '深圳', '2018-01-08 14:00:00', '02:46:00', '44');
INSERT INTO `car_info` VALUES ('广深180108018', '粤A-0037', '广州', '深圳', '2018-01-08 14:30:00', '02:56:00', '30');
INSERT INTO `car_info` VALUES ('广深180108019', '粤A-8482', '广州', '深圳', '2018-01-08 15:00:00', '01:46:00', '32');
INSERT INTO `car_info` VALUES ('广深180108020', '粤A-5063', '广州', '深圳', '2018-01-08 15:30:00', '02:09:00', '38');
INSERT INTO `car_info` VALUES ('广深180108021', '粤A-6333', '广州', '深圳', '2018-01-08 16:00:00', '01:44:00', '36');
INSERT INTO `car_info` VALUES ('广深180108022', '粤A-1716', '广州', '深圳', '2018-01-08 16:30:00', '02:25:00', '42');
INSERT INTO `car_info` VALUES ('广深180108023', '粤A-4626', '广州', '深圳', '2018-01-08 17:00:00', '01:32:00', '40');
INSERT INTO `car_info` VALUES ('广深180108024', '粤A-9556', '广州', '深圳', '2018-01-08 17:30:00', '02:31:00', '44');
INSERT INTO `car_info` VALUES ('广深180108025', '粤A-9346', '广州', '深圳', '2018-01-08 18:00:00', '01:13:00', '38');
INSERT INTO `car_info` VALUES ('广深180108026', '粤A-0241', '广州', '深圳', '2018-01-08 18:30:00', '02:40:00', '38');
INSERT INTO `car_info` VALUES ('广深180108027', '粤A-3408', '广州', '深圳', '2018-01-08 19:00:00', '01:00:00', '34');
INSERT INTO `car_info` VALUES ('广深180108028', '粤A-4299', '广州', '深圳', '2018-01-08 19:30:00', '02:24:00', '36');
INSERT INTO `car_info` VALUES ('广深180108029', '粤A-3644', '广州', '深圳', '2018-01-08 20:00:00', '01:22:00', '34');
INSERT INTO `car_info` VALUES ('广深180108030', '粤A-2689', '广州', '深圳', '2018-01-08 20:30:00', '01:12:00', '40');
INSERT INTO `car_info` VALUES ('广深180109001', '粤A-6701', '广州', '深圳', '2018-01-09 06:00:00', '01:55:00', '38');
INSERT INTO `car_info` VALUES ('广深180109002', '粤A-5086', '广州', '深圳', '2018-01-09 06:30:00', '01:45:00', '46');
INSERT INTO `car_info` VALUES ('广深180109003', '粤A-4937', '广州', '深圳', '2018-01-09 07:00:00', '01:05:00', '34');
INSERT INTO `car_info` VALUES ('广深180109004', '粤A-3559', '广州', '深圳', '2018-01-09 07:30:00', '02:29:00', '30');
INSERT INTO `car_info` VALUES ('广深180109005', '粤A-4398', '广州', '深圳', '2018-01-09 08:00:00', '02:24:00', '32');
INSERT INTO `car_info` VALUES ('广深180109006', '粤A-7480', '广州', '深圳', '2018-01-09 08:30:00', '02:19:00', '34');
INSERT INTO `car_info` VALUES ('广深180109007', '粤A-0369', '广州', '深圳', '2018-01-09 09:00:00', '02:14:00', '44');
INSERT INTO `car_info` VALUES ('广深180109008', '粤A-0839', '广州', '深圳', '2018-01-09 09:30:00', '02:05:00', '42');
INSERT INTO `car_info` VALUES ('广深180109009', '粤A-6328', '广州', '深圳', '2018-01-09 10:00:00', '02:13:00', '38');
INSERT INTO `car_info` VALUES ('广深180109010', '粤A-9724', '广州', '深圳', '2018-01-09 10:30:00', '01:30:00', '38');
INSERT INTO `car_info` VALUES ('广深180109011', '粤A-1782', '广州', '深圳', '2018-01-09 11:00:00', '01:06:00', '32');
INSERT INTO `car_info` VALUES ('广深180109012', '粤A-0618', '广州', '深圳', '2018-01-09 11:30:00', '02:10:00', '38');
INSERT INTO `car_info` VALUES ('广深180109013', '粤A-3914', '广州', '深圳', '2018-01-09 12:00:00', '02:59:00', '46');
INSERT INTO `car_info` VALUES ('广深180109014', '粤A-8503', '广州', '深圳', '2018-01-09 12:30:00', '01:58:00', '32');
INSERT INTO `car_info` VALUES ('广深180109015', '粤A-4324', '广州', '深圳', '2018-01-09 13:00:00', '02:27:00', '38');
INSERT INTO `car_info` VALUES ('广深180109016', '粤A-3427', '广州', '深圳', '2018-01-09 13:30:00', '02:49:00', '42');
INSERT INTO `car_info` VALUES ('广深180109017', '粤A-4597', '广州', '深圳', '2018-01-09 14:00:00', '01:53:00', '34');
INSERT INTO `car_info` VALUES ('广深180109018', '粤A-8776', '广州', '深圳', '2018-01-09 14:30:00', '01:43:00', '30');
INSERT INTO `car_info` VALUES ('广深180109019', '粤A-9389', '广州', '深圳', '2018-01-09 15:00:00', '02:09:00', '36');
INSERT INTO `car_info` VALUES ('广深180109020', '粤A-8459', '广州', '深圳', '2018-01-09 15:30:00', '01:08:00', '42');
INSERT INTO `car_info` VALUES ('广深180109021', '粤A-5950', '广州', '深圳', '2018-01-09 16:00:00', '02:59:00', '46');
INSERT INTO `car_info` VALUES ('广深180109022', '粤A-8414', '广州', '深圳', '2018-01-09 16:30:00', '02:58:00', '30');
INSERT INTO `car_info` VALUES ('广深180109023', '粤A-1748', '广州', '深圳', '2018-01-09 17:00:00', '01:47:00', '40');
INSERT INTO `car_info` VALUES ('广深180109024', '粤A-5503', '广州', '深圳', '2018-01-09 17:30:00', '02:54:00', '42');
INSERT INTO `car_info` VALUES ('广深180109025', '粤A-5476', '广州', '深圳', '2018-01-09 18:00:00', '02:40:00', '38');
INSERT INTO `car_info` VALUES ('广深180109026', '粤A-9247', '广州', '深圳', '2018-01-09 18:30:00', '01:40:00', '36');
INSERT INTO `car_info` VALUES ('广深180109027', '粤A-3846', '广州', '深圳', '2018-01-09 19:00:00', '02:36:00', '40');
INSERT INTO `car_info` VALUES ('广深180109028', '粤A-6006', '广州', '深圳', '2018-01-09 19:30:00', '02:15:00', '34');
INSERT INTO `car_info` VALUES ('广深180109029', '粤A-3931', '广州', '深圳', '2018-01-09 20:00:00', '02:46:00', '44');
INSERT INTO `car_info` VALUES ('广深180109030', '粤A-8553', '广州', '深圳', '2018-01-09 20:30:00', '01:35:00', '36');
INSERT INTO `car_info` VALUES ('广深180110001', '粤A-3736', '广州', '深圳', '2018-01-10 06:00:00', '02:17:00', '36');
INSERT INTO `car_info` VALUES ('广深180110002', '粤A-9763', '广州', '深圳', '2018-01-10 06:30:00', '01:23:00', '30');
INSERT INTO `car_info` VALUES ('广深180110003', '粤A-1595', '广州', '深圳', '2018-01-10 07:00:00', '01:44:00', '38');
INSERT INTO `car_info` VALUES ('广深180110004', '粤A-5648', '广州', '深圳', '2018-01-10 07:30:00', '01:26:00', '44');
INSERT INTO `car_info` VALUES ('广深180110005', '粤A-6350', '广州', '深圳', '2018-01-10 08:00:00', '01:14:00', '44');
INSERT INTO `car_info` VALUES ('广深180110006', '粤A-5418', '广州', '深圳', '2018-01-10 08:30:00', '01:36:00', '38');
INSERT INTO `car_info` VALUES ('广深180110007', '粤A-4036', '广州', '深圳', '2018-01-10 09:00:00', '01:51:00', '42');
INSERT INTO `car_info` VALUES ('广深180110008', '粤A-0341', '广州', '深圳', '2018-01-10 09:30:00', '02:59:00', '34');
INSERT INTO `car_info` VALUES ('广深180110009', '粤A-6307', '广州', '深圳', '2018-01-10 10:00:00', '01:08:00', '32');
INSERT INTO `car_info` VALUES ('广深180110010', '粤A-4388', '广州', '深圳', '2018-01-10 10:30:00', '01:13:00', '44');
INSERT INTO `car_info` VALUES ('广深180110011', '粤A-1421', '广州', '深圳', '2018-01-10 11:00:00', '02:18:00', '38');
INSERT INTO `car_info` VALUES ('广深180110012', '粤A-6760', '广州', '深圳', '2018-01-10 11:30:00', '01:23:00', '38');
INSERT INTO `car_info` VALUES ('广深180110013', '粤A-7874', '广州', '深圳', '2018-01-10 12:00:00', '02:27:00', '40');
INSERT INTO `car_info` VALUES ('广深180110014', '粤A-0882', '广州', '深圳', '2018-01-10 12:30:00', '02:23:00', '32');
INSERT INTO `car_info` VALUES ('广深180110015', '粤A-2938', '广州', '深圳', '2018-01-10 13:00:00', '02:14:00', '40');
INSERT INTO `car_info` VALUES ('广深180110016', '粤A-9209', '广州', '深圳', '2018-01-10 13:30:00', '01:09:00', '32');
INSERT INTO `car_info` VALUES ('广深180110017', '粤A-1692', '广州', '深圳', '2018-01-10 14:00:00', '02:37:00', '36');
INSERT INTO `car_info` VALUES ('广深180110018', '粤A-4124', '广州', '深圳', '2018-01-10 14:30:00', '02:00:00', '38');
INSERT INTO `car_info` VALUES ('广深180110019', '粤A-1583', '广州', '深圳', '2018-01-10 15:00:00', '02:24:00', '42');
INSERT INTO `car_info` VALUES ('广深180110020', '粤A-9348', '广州', '深圳', '2018-01-10 15:30:00', '02:26:00', '44');
INSERT INTO `car_info` VALUES ('广深180110021', '粤A-6081', '广州', '深圳', '2018-01-10 16:00:00', '01:17:00', '44');
INSERT INTO `car_info` VALUES ('广深180110022', '粤A-1592', '广州', '深圳', '2018-01-10 16:30:00', '02:41:00', '40');
INSERT INTO `car_info` VALUES ('广深180110023', '粤A-1981', '广州', '深圳', '2018-01-10 17:00:00', '02:11:00', '46');
INSERT INTO `car_info` VALUES ('广深180110024', '粤A-4882', '广州', '深圳', '2018-01-10 17:30:00', '02:20:00', '40');
INSERT INTO `car_info` VALUES ('广深180110025', '粤A-5627', '广州', '深圳', '2018-01-10 18:00:00', '01:04:00', '46');
INSERT INTO `car_info` VALUES ('广深180110026', '粤A-5267', '广州', '深圳', '2018-01-10 18:30:00', '01:18:00', '36');
INSERT INTO `car_info` VALUES ('广深180110027', '粤A-3789', '广州', '深圳', '2018-01-10 19:00:00', '02:18:00', '46');
INSERT INTO `car_info` VALUES ('广深180110028', '粤A-7636', '广州', '深圳', '2018-01-10 19:30:00', '02:24:00', '42');
INSERT INTO `car_info` VALUES ('广深180110029', '粤A-0656', '广州', '深圳', '2018-01-10 20:00:00', '01:15:00', '46');
INSERT INTO `car_info` VALUES ('广深180110030', '粤A-5468', '广州', '深圳', '2018-01-10 20:30:00', '02:23:00', '42');
INSERT INTO `car_info` VALUES ('广深180111001', '粤A-0141', '广州', '深圳', '2018-01-11 06:00:00', '02:37:00', '30');
INSERT INTO `car_info` VALUES ('广深180111002', '粤A-8787', '广州', '深圳', '2018-01-11 06:30:00', '01:24:00', '34');
INSERT INTO `car_info` VALUES ('广深180111003', '粤A-2901', '广州', '深圳', '2018-01-11 07:00:00', '01:41:00', '32');
INSERT INTO `car_info` VALUES ('广深180111004', '粤A-2371', '广州', '深圳', '2018-01-11 07:30:00', '01:20:00', '30');
INSERT INTO `car_info` VALUES ('广深180111005', '粤A-1298', '广州', '深圳', '2018-01-11 08:00:00', '01:05:00', '44');
INSERT INTO `car_info` VALUES ('广深180111006', '粤A-3695', '广州', '深圳', '2018-01-11 08:30:00', '01:57:00', '42');
INSERT INTO `car_info` VALUES ('广深180111007', '粤A-3648', '广州', '深圳', '2018-01-11 09:00:00', '01:40:00', '32');
INSERT INTO `car_info` VALUES ('广深180111008', '粤A-6816', '广州', '深圳', '2018-01-11 09:30:00', '02:10:00', '38');
INSERT INTO `car_info` VALUES ('广深180111009', '粤A-8907', '广州', '深圳', '2018-01-11 10:00:00', '01:42:00', '34');
INSERT INTO `car_info` VALUES ('广深180111010', '粤A-0835', '广州', '深圳', '2018-01-11 10:30:00', '01:27:00', '44');
INSERT INTO `car_info` VALUES ('广深180111011', '粤A-5462', '广州', '深圳', '2018-01-11 11:00:00', '01:41:00', '42');
INSERT INTO `car_info` VALUES ('广深180111012', '粤A-9707', '广州', '深圳', '2018-01-11 11:30:00', '02:58:00', '42');
INSERT INTO `car_info` VALUES ('广深180111013', '粤A-4940', '广州', '深圳', '2018-01-11 12:00:00', '01:19:00', '34');
INSERT INTO `car_info` VALUES ('广深180111014', '粤A-6060', '广州', '深圳', '2018-01-11 12:30:00', '02:18:00', '44');
INSERT INTO `car_info` VALUES ('广深180111015', '粤A-7824', '广州', '深圳', '2018-01-11 13:00:00', '01:14:00', '46');
INSERT INTO `car_info` VALUES ('广深180111016', '粤A-6188', '广州', '深圳', '2018-01-11 13:30:00', '02:56:00', '42');
INSERT INTO `car_info` VALUES ('广深180111017', '粤A-6820', '广州', '深圳', '2018-01-11 14:00:00', '02:34:00', '34');
INSERT INTO `car_info` VALUES ('广深180111018', '粤A-9797', '广州', '深圳', '2018-01-11 14:30:00', '01:56:00', '32');
INSERT INTO `car_info` VALUES ('广深180111019', '粤A-4453', '广州', '深圳', '2018-01-11 15:00:00', '02:06:00', '40');
INSERT INTO `car_info` VALUES ('广深180111020', '粤A-0254', '广州', '深圳', '2018-01-11 15:30:00', '02:25:00', '36');
INSERT INTO `car_info` VALUES ('广深180111021', '粤A-4602', '广州', '深圳', '2018-01-11 16:00:00', '01:25:00', '44');
INSERT INTO `car_info` VALUES ('广深180111022', '粤A-0718', '广州', '深圳', '2018-01-11 16:30:00', '02:19:00', '30');
INSERT INTO `car_info` VALUES ('广深180111023', '粤A-9641', '广州', '深圳', '2018-01-11 17:00:00', '02:40:00', '32');
INSERT INTO `car_info` VALUES ('广深180111024', '粤A-6990', '广州', '深圳', '2018-01-11 17:30:00', '02:56:00', '38');
INSERT INTO `car_info` VALUES ('广深180111025', '粤A-2411', '广州', '深圳', '2018-01-11 18:00:00', '01:36:00', '34');
INSERT INTO `car_info` VALUES ('广深180111026', '粤A-5327', '广州', '深圳', '2018-01-11 18:30:00', '01:53:00', '38');
INSERT INTO `car_info` VALUES ('广深180111027', '粤A-0613', '广州', '深圳', '2018-01-11 19:00:00', '02:31:00', '36');
INSERT INTO `car_info` VALUES ('广深180111028', '粤A-1392', '广州', '深圳', '2018-01-11 19:30:00', '02:52:00', '38');
INSERT INTO `car_info` VALUES ('广深180111029', '粤A-0637', '广州', '深圳', '2018-01-11 20:00:00', '02:30:00', '30');
INSERT INTO `car_info` VALUES ('广深180111030', '粤A-2996', '广州', '深圳', '2018-01-11 20:30:00', '02:50:00', '32');
INSERT INTO `car_info` VALUES ('深广180108001', '粤A-5976', '深圳', '广州', '2018-01-08 06:00:00', '02:23:00', '34');
INSERT INTO `car_info` VALUES ('深广180108002', '粤A-1269', '深圳', '广州', '2018-01-08 06:30:00', '02:19:00', '46');
INSERT INTO `car_info` VALUES ('深广180108003', '粤A-7979', '深圳', '广州', '2018-01-08 07:00:00', '02:54:00', '42');
INSERT INTO `car_info` VALUES ('深广180108004', '粤A-4416', '深圳', '广州', '2018-01-08 07:30:00', '01:12:00', '30');
INSERT INTO `car_info` VALUES ('深广180108005', '粤A-3100', '深圳', '广州', '2018-01-08 08:00:00', '02:11:00', '40');
INSERT INTO `car_info` VALUES ('深广180108006', '粤A-0328', '深圳', '广州', '2018-01-08 08:30:00', '02:42:00', '32');
INSERT INTO `car_info` VALUES ('深广180108007', '粤A-7651', '深圳', '广州', '2018-01-08 09:00:00', '01:09:00', '46');
INSERT INTO `car_info` VALUES ('深广180108008', '粤A-7126', '深圳', '广州', '2018-01-08 09:30:00', '01:47:00', '42');
INSERT INTO `car_info` VALUES ('深广180108009', '粤A-5221', '深圳', '广州', '2018-01-08 10:00:00', '02:12:00', '34');
INSERT INTO `car_info` VALUES ('深广180108010', '粤A-9123', '深圳', '广州', '2018-01-08 10:30:00', '01:28:00', '36');
INSERT INTO `car_info` VALUES ('深广180108011', '粤A-7543', '深圳', '广州', '2018-01-08 11:00:00', '02:47:00', '38');
INSERT INTO `car_info` VALUES ('深广180108012', '粤A-9400', '深圳', '广州', '2018-01-08 11:30:00', '02:25:00', '32');
INSERT INTO `car_info` VALUES ('深广180108013', '粤A-6168', '深圳', '广州', '2018-01-08 12:00:00', '01:35:00', '38');
INSERT INTO `car_info` VALUES ('深广180108014', '粤A-6947', '深圳', '广州', '2018-01-08 12:30:00', '01:59:00', '42');
INSERT INTO `car_info` VALUES ('深广180108015', '粤A-3287', '深圳', '广州', '2018-01-08 13:00:00', '01:01:00', '38');
INSERT INTO `car_info` VALUES ('深广180108016', '粤A-6226', '深圳', '广州', '2018-01-08 13:30:00', '02:20:00', '32');
INSERT INTO `car_info` VALUES ('深广180108017', '粤A-0156', '深圳', '广州', '2018-01-08 14:00:00', '01:38:00', '42');
INSERT INTO `car_info` VALUES ('深广180108018', '粤A-3989', '深圳', '广州', '2018-01-08 14:30:00', '01:03:00', '46');
INSERT INTO `car_info` VALUES ('深广180108019', '粤A-6275', '深圳', '广州', '2018-01-08 15:00:00', '01:29:00', '36');
INSERT INTO `car_info` VALUES ('深广180108020', '粤A-4378', '深圳', '广州', '2018-01-08 15:30:00', '02:49:00', '36');
INSERT INTO `car_info` VALUES ('深广180108021', '粤A-7754', '深圳', '广州', '2018-01-08 16:00:00', '01:43:00', '40');
INSERT INTO `car_info` VALUES ('深广180108022', '粤A-1162', '深圳', '广州', '2018-01-08 16:30:00', '01:20:00', '42');
INSERT INTO `car_info` VALUES ('深广180108023', '粤A-6240', '深圳', '广州', '2018-01-08 17:00:00', '02:24:00', '34');
INSERT INTO `car_info` VALUES ('深广180108024', '粤A-4940', '深圳', '广州', '2018-01-08 17:30:00', '01:06:00', '46');
INSERT INTO `car_info` VALUES ('深广180108025', '粤A-6050', '深圳', '广州', '2018-01-08 18:00:00', '01:16:00', '38');
INSERT INTO `car_info` VALUES ('深广180108026', '粤A-9887', '深圳', '广州', '2018-01-08 18:30:00', '02:32:00', '44');
INSERT INTO `car_info` VALUES ('深广180108027', '粤A-3068', '深圳', '广州', '2018-01-08 19:00:00', '01:27:00', '44');
INSERT INTO `car_info` VALUES ('深广180108028', '粤A-5034', '深圳', '广州', '2018-01-08 19:30:00', '01:34:00', '46');
INSERT INTO `car_info` VALUES ('深广180108029', '粤A-5265', '深圳', '广州', '2018-01-08 20:00:00', '01:08:00', '44');
INSERT INTO `car_info` VALUES ('深广180108030', '粤A-5842', '深圳', '广州', '2018-01-08 20:30:00', '02:50:00', '36');
INSERT INTO `car_info` VALUES ('深广180109001', '粤A-1266', '深圳', '广州', '2018-01-09 06:00:00', '02:41:00', '42');
INSERT INTO `car_info` VALUES ('深广180109002', '粤A-0680', '深圳', '广州', '2018-01-09 06:30:00', '01:03:00', '46');
INSERT INTO `car_info` VALUES ('深广180109003', '粤A-3245', '深圳', '广州', '2018-01-09 07:00:00', '02:25:00', '30');
INSERT INTO `car_info` VALUES ('深广180109004', '粤A-4089', '深圳', '广州', '2018-01-09 07:30:00', '02:04:00', '40');
INSERT INTO `car_info` VALUES ('深广180109005', '粤A-7273', '深圳', '广州', '2018-01-09 08:00:00', '01:29:00', '38');
INSERT INTO `car_info` VALUES ('深广180109006', '粤A-9186', '深圳', '广州', '2018-01-09 08:30:00', '02:05:00', '40');
INSERT INTO `car_info` VALUES ('深广180109007', '粤A-5424', '深圳', '广州', '2018-01-09 09:00:00', '01:43:00', '30');
INSERT INTO `car_info` VALUES ('深广180109008', '粤A-2619', '深圳', '广州', '2018-01-09 09:30:00', '02:23:00', '44');
INSERT INTO `car_info` VALUES ('深广180109009', '粤A-6859', '深圳', '广州', '2018-01-09 10:00:00', '01:13:00', '40');
INSERT INTO `car_info` VALUES ('深广180109010', '粤A-1364', '深圳', '广州', '2018-01-09 10:30:00', '02:11:00', '40');
INSERT INTO `car_info` VALUES ('深广180109011', '粤A-7151', '深圳', '广州', '2018-01-09 11:00:00', '01:21:00', '38');
INSERT INTO `car_info` VALUES ('深广180109012', '粤A-4041', '深圳', '广州', '2018-01-09 11:30:00', '01:59:00', '46');
INSERT INTO `car_info` VALUES ('深广180109013', '粤A-9580', '深圳', '广州', '2018-01-09 12:00:00', '01:44:00', '32');
INSERT INTO `car_info` VALUES ('深广180109014', '粤A-7780', '深圳', '广州', '2018-01-09 12:30:00', '01:22:00', '42');
INSERT INTO `car_info` VALUES ('深广180109015', '粤A-3256', '深圳', '广州', '2018-01-09 13:00:00', '02:35:00', '34');
INSERT INTO `car_info` VALUES ('深广180109016', '粤A-1271', '深圳', '广州', '2018-01-09 13:30:00', '02:38:00', '36');
INSERT INTO `car_info` VALUES ('深广180109017', '粤A-4837', '深圳', '广州', '2018-01-09 14:00:00', '02:54:00', '42');
INSERT INTO `car_info` VALUES ('深广180109018', '粤A-5418', '深圳', '广州', '2018-01-09 14:30:00', '02:32:00', '40');
INSERT INTO `car_info` VALUES ('深广180109019', '粤A-2061', '深圳', '广州', '2018-01-09 15:00:00', '02:13:00', '44');
INSERT INTO `car_info` VALUES ('深广180109020', '粤A-5057', '深圳', '广州', '2018-01-09 15:30:00', '01:55:00', '38');
INSERT INTO `car_info` VALUES ('深广180109021', '粤A-2362', '深圳', '广州', '2018-01-09 16:00:00', '01:43:00', '44');
INSERT INTO `car_info` VALUES ('深广180109022', '粤A-3813', '深圳', '广州', '2018-01-09 16:30:00', '02:19:00', '32');
INSERT INTO `car_info` VALUES ('深广180109023', '粤A-8750', '深圳', '广州', '2018-01-09 17:00:00', '02:01:00', '42');
INSERT INTO `car_info` VALUES ('深广180109024', '粤A-3512', '深圳', '广州', '2018-01-09 17:30:00', '02:21:00', '32');
INSERT INTO `car_info` VALUES ('深广180109025', '粤A-0952', '深圳', '广州', '2018-01-09 18:00:00', '01:04:00', '36');
INSERT INTO `car_info` VALUES ('深广180109026', '粤A-6172', '深圳', '广州', '2018-01-09 18:30:00', '01:23:00', '34');
INSERT INTO `car_info` VALUES ('深广180109027', '粤A-8627', '深圳', '广州', '2018-01-09 19:00:00', '01:31:00', '40');
INSERT INTO `car_info` VALUES ('深广180109028', '粤A-3234', '深圳', '广州', '2018-01-09 19:30:00', '01:36:00', '46');
INSERT INTO `car_info` VALUES ('深广180109029', '粤A-7142', '深圳', '广州', '2018-01-09 20:00:00', '01:09:00', '40');
INSERT INTO `car_info` VALUES ('深广180109030', '粤A-7372', '深圳', '广州', '2018-01-09 20:30:00', '02:42:00', '46');
INSERT INTO `car_info` VALUES ('深广180110001', '粤A-6946', '深圳', '广州', '2018-01-10 06:00:00', '02:09:00', '44');
INSERT INTO `car_info` VALUES ('深广180110002', '粤A-8929', '深圳', '广州', '2018-01-10 06:30:00', '01:44:00', '40');
INSERT INTO `car_info` VALUES ('深广180110003', '粤A-2237', '深圳', '广州', '2018-01-10 07:00:00', '02:58:00', '38');
INSERT INTO `car_info` VALUES ('深广180110004', '粤A-4106', '深圳', '广州', '2018-01-10 07:30:00', '01:32:00', '32');
INSERT INTO `car_info` VALUES ('深广180110005', '粤A-2714', '深圳', '广州', '2018-01-10 08:00:00', '01:22:00', '32');
INSERT INTO `car_info` VALUES ('深广180110006', '粤A-1812', '深圳', '广州', '2018-01-10 08:30:00', '01:45:00', '42');
INSERT INTO `car_info` VALUES ('深广180110007', '粤A-5588', '深圳', '广州', '2018-01-10 09:00:00', '02:07:00', '34');
INSERT INTO `car_info` VALUES ('深广180110008', '粤A-9322', '深圳', '广州', '2018-01-10 09:30:00', '01:01:00', '38');
INSERT INTO `car_info` VALUES ('深广180110009', '粤A-3563', '深圳', '广州', '2018-01-10 10:00:00', '02:40:00', '38');
INSERT INTO `car_info` VALUES ('深广180110010', '粤A-5903', '深圳', '广州', '2018-01-10 10:30:00', '02:32:00', '42');
INSERT INTO `car_info` VALUES ('深广180110011', '粤A-0511', '深圳', '广州', '2018-01-10 11:00:00', '01:48:00', '46');
INSERT INTO `car_info` VALUES ('深广180110012', '粤A-8861', '深圳', '广州', '2018-01-10 11:30:00', '01:28:00', '32');
INSERT INTO `car_info` VALUES ('深广180110013', '粤A-7768', '深圳', '广州', '2018-01-10 12:00:00', '02:44:00', '34');
INSERT INTO `car_info` VALUES ('深广180110014', '粤A-7821', '深圳', '广州', '2018-01-10 12:30:00', '02:04:00', '36');
INSERT INTO `car_info` VALUES ('深广180110015', '粤A-6093', '深圳', '广州', '2018-01-10 13:00:00', '02:13:00', '40');
INSERT INTO `car_info` VALUES ('深广180110016', '粤A-6611', '深圳', '广州', '2018-01-10 13:30:00', '01:17:00', '36');
INSERT INTO `car_info` VALUES ('深广180110017', '粤A-4336', '深圳', '广州', '2018-01-10 14:00:00', '02:58:00', '44');
INSERT INTO `car_info` VALUES ('深广180110018', '粤A-8942', '深圳', '广州', '2018-01-10 14:30:00', '02:31:00', '38');
INSERT INTO `car_info` VALUES ('深广180110019', '粤A-1588', '深圳', '广州', '2018-01-10 15:00:00', '01:27:00', '36');
INSERT INTO `car_info` VALUES ('深广180110020', '粤A-2374', '深圳', '广州', '2018-01-10 15:30:00', '01:05:00', '32');
INSERT INTO `car_info` VALUES ('深广180110021', '粤A-9285', '深圳', '广州', '2018-01-10 16:00:00', '02:34:00', '30');
INSERT INTO `car_info` VALUES ('深广180110022', '粤A-1416', '深圳', '广州', '2018-01-10 16:30:00', '02:54:00', '44');
INSERT INTO `car_info` VALUES ('深广180110023', '粤A-1975', '深圳', '广州', '2018-01-10 17:00:00', '02:06:00', '46');
INSERT INTO `car_info` VALUES ('深广180110024', '粤A-3668', '深圳', '广州', '2018-01-10 17:30:00', '02:55:00', '42');
INSERT INTO `car_info` VALUES ('深广180110025', '粤A-9245', '深圳', '广州', '2018-01-10 18:00:00', '02:27:00', '32');
INSERT INTO `car_info` VALUES ('深广180110026', '粤A-5911', '深圳', '广州', '2018-01-10 18:30:00', '02:54:00', '40');
INSERT INTO `car_info` VALUES ('深广180110027', '粤A-5250', '深圳', '广州', '2018-01-10 19:00:00', '01:32:00', '30');
INSERT INTO `car_info` VALUES ('深广180110028', '粤A-1032', '深圳', '广州', '2018-01-10 19:30:00', '02:56:00', '34');
INSERT INTO `car_info` VALUES ('深广180110029', '粤A-3960', '深圳', '广州', '2018-01-10 20:00:00', '01:39:00', '44');
INSERT INTO `car_info` VALUES ('深广180110030', '粤A-8957', '深圳', '广州', '2018-01-10 20:30:00', '02:49:00', '40');
INSERT INTO `car_info` VALUES ('深广180111001', '粤A-8395', '深圳', '广州', '2018-01-11 06:00:00', '02:20:00', '42');
INSERT INTO `car_info` VALUES ('深广180111002', '粤A-8565', '深圳', '广州', '2018-01-11 06:30:00', '02:59:00', '44');
INSERT INTO `car_info` VALUES ('深广180111003', '粤A-4576', '深圳', '广州', '2018-01-11 07:00:00', '01:32:00', '42');
INSERT INTO `car_info` VALUES ('深广180111004', '粤A-0767', '深圳', '广州', '2018-01-11 07:30:00', '02:02:00', '34');
INSERT INTO `car_info` VALUES ('深广180111005', '粤A-8238', '深圳', '广州', '2018-01-11 08:00:00', '01:31:00', '38');
INSERT INTO `car_info` VALUES ('深广180111006', '粤A-2247', '深圳', '广州', '2018-01-11 08:30:00', '01:20:00', '36');
INSERT INTO `car_info` VALUES ('深广180111007', '粤A-2125', '深圳', '广州', '2018-01-11 09:00:00', '01:40:00', '30');
INSERT INTO `car_info` VALUES ('深广180111008', '粤A-0041', '深圳', '广州', '2018-01-11 09:30:00', '02:40:00', '32');
INSERT INTO `car_info` VALUES ('深广180111009', '粤A-6562', '深圳', '广州', '2018-01-11 10:00:00', '01:00:00', '42');
INSERT INTO `car_info` VALUES ('深广180111010', '粤A-5689', '深圳', '广州', '2018-01-11 10:30:00', '02:44:00', '42');
INSERT INTO `car_info` VALUES ('深广180111011', '粤A-1238', '深圳', '广州', '2018-01-11 11:00:00', '02:27:00', '32');
INSERT INTO `car_info` VALUES ('深广180111012', '粤A-0917', '深圳', '广州', '2018-01-11 11:30:00', '01:00:00', '38');
INSERT INTO `car_info` VALUES ('深广180111013', '粤A-7259', '深圳', '广州', '2018-01-11 12:00:00', '01:41:00', '40');
INSERT INTO `car_info` VALUES ('深广180111014', '粤A-2560', '深圳', '广州', '2018-01-11 12:30:00', '01:44:00', '44');
INSERT INTO `car_info` VALUES ('深广180111015', '粤A-9977', '深圳', '广州', '2018-01-11 13:00:00', '01:22:00', '42');
INSERT INTO `car_info` VALUES ('深广180111016', '粤A-9162', '深圳', '广州', '2018-01-11 13:30:00', '01:43:00', '32');
INSERT INTO `car_info` VALUES ('深广180111017', '粤A-1414', '深圳', '广州', '2018-01-11 14:00:00', '02:57:00', '42');
INSERT INTO `car_info` VALUES ('深广180111018', '粤A-7586', '深圳', '广州', '2018-01-11 14:30:00', '02:01:00', '34');
INSERT INTO `car_info` VALUES ('深广180111019', '粤A-5393', '深圳', '广州', '2018-01-11 15:00:00', '01:18:00', '34');
INSERT INTO `car_info` VALUES ('深广180111020', '粤A-9595', '深圳', '广州', '2018-01-11 15:30:00', '02:16:00', '38');
INSERT INTO `car_info` VALUES ('深广180111021', '粤A-3902', '深圳', '广州', '2018-01-11 16:00:00', '02:28:00', '46');
INSERT INTO `car_info` VALUES ('深广180111022', '粤A-3005', '深圳', '广州', '2018-01-11 16:30:00', '01:05:00', '36');
INSERT INTO `car_info` VALUES ('深广180111023', '粤A-1344', '深圳', '广州', '2018-01-11 17:00:00', '01:56:00', '42');
INSERT INTO `car_info` VALUES ('深广180111024', '粤A-9940', '深圳', '广州', '2018-01-11 17:30:00', '01:23:00', '44');
INSERT INTO `car_info` VALUES ('深广180111025', '粤A-6022', '深圳', '广州', '2018-01-11 18:00:00', '01:44:00', '40');
INSERT INTO `car_info` VALUES ('深广180111026', '粤A-8777', '深圳', '广州', '2018-01-11 18:30:00', '01:16:00', '34');
INSERT INTO `car_info` VALUES ('深广180111027', '粤A-9248', '深圳', '广州', '2018-01-11 19:00:00', '02:27:00', '34');
INSERT INTO `car_info` VALUES ('深广180111028', '粤A-9344', '深圳', '广州', '2018-01-11 19:30:00', '01:43:00', '32');
INSERT INTO `car_info` VALUES ('深广180111029', '粤A-0613', '深圳', '广州', '2018-01-11 20:00:00', '02:36:00', '34');
INSERT INTO `car_info` VALUES ('深广180111030', '粤A-9845', '深圳', '广州', '2018-01-11 20:30:00', '01:56:00', '32');

-- ----------------------------
-- Table structure for `car_ticket_info`
-- ----------------------------
DROP TABLE IF EXISTS `car_ticket_info`;
CREATE TABLE `car_ticket_info` (
  `car_no` varchar(25) NOT NULL COMMENT '车牌号',
  `price` smallint(5) unsigned DEFAULT NULL COMMENT '价格',
  `remain_ticket` tinyint(4) DEFAULT NULL COMMENT '剩余票数',
  `all_ticket` tinyint(4) DEFAULT NULL COMMENT '总票数',
  PRIMARY KEY (`car_no`),
  CONSTRAINT `fk_cti2ci_cno` FOREIGN KEY (`car_no`) REFERENCES `car_info` (`car_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of car_ticket_info
-- ----------------------------
INSERT INTO `car_ticket_info` VALUES ('广深180108001', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180108002', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180108003', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180108004', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('广深180108005', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180108006', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180108007', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180108008', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180108009', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180108010', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('广深180108011', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180108012', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180108013', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180108014', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180108015', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('广深180108016', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('广深180108017', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180108018', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('广深180108019', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('广深180108020', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180108021', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('广深180108022', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('广深180108023', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180108024', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180108025', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180108026', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180108027', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180108028', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('广深180108029', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180108030', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180109001', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180109002', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('广深180109003', '100', '33', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180109004', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('广深180109005', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('广深180109006', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180109007', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180109008', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('广深180109009', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180109010', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180109011', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('广深180109012', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180109013', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('广深180109014', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('广深180109015', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180109016', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('广深180109017', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180109018', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('广深180109019', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('广深180109020', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('广深180109021', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('广深180109022', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('广深180109023', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180109024', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('广深180109025', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180109026', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('广深180109027', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180109028', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180109029', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180109030', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('广深180110001', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('广深180110002', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('广深180110003', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180110004', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180110005', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180110006', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180110007', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('广深180110008', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180110009', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('广深180110010', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180110011', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180110012', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180110013', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180110014', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('广深180110015', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180110016', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('广深180110017', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('广深180110018', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180110019', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('广深180110020', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180110021', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180110022', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180110023', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('广深180110024', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180110025', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('广深180110026', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('广深180110027', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('广深180110028', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('广深180110029', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('广深180110030', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('广深180111001', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('广深180111002', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180111003', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('广深180111004', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('广深180111005', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180111006', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('广深180111007', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('广深180111008', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180111009', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180111010', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180111011', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('广深180111012', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('广深180111013', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180111014', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180111015', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('广深180111016', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('广深180111017', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180111018', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('广深180111019', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('广深180111020', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('广深180111021', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('广深180111022', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('广深180111023', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('广深180111024', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180111025', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('广深180111026', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180111027', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('广深180111028', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('广深180111029', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('广深180111030', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180108001', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180108002', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('深广180108003', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180108004', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('深广180108005', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180108006', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180108007', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('深广180108008', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180108009', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180108010', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('深广180108011', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180108012', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180108013', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180108014', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180108015', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180108016', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180108017', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180108018', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('深广180108019', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('深广180108020', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('深广180108021', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180108022', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180108023', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180108024', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('深广180108025', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180108026', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('深广180108027', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('深广180108028', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('深广180108029', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('深广180108030', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('深广180109001', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180109002', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('深广180109003', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('深广180109004', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180109005', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180109006', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180109007', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('深广180109008', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('深广180109009', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180109010', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180109011', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180109012', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('深广180109013', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180109014', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180109015', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180109016', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('深广180109017', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180109018', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180109019', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('深广180109020', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180109021', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('深广180109022', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180109023', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180109024', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180109025', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('深广180109026', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180109027', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180109028', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('深广180109029', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180109030', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('深广180110001', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('深广180110002', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180110003', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180110004', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180110005', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180110006', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180110007', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180110008', '100', '37', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180110009', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180110010', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180110011', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('深广180110012', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180110013', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180110014', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('深广180110015', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180110016', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('深广180110017', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('深广180110018', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180110019', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('深广180110020', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180110021', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('深广180110022', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('深广180110023', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('深广180110024', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180110025', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180110026', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180110027', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('深广180110028', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180110029', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('深广180110030', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180111001', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180111002', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('深广180111003', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180111004', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180111005', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180111006', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('深广180111007', '100', '30', '30');
INSERT INTO `car_ticket_info` VALUES ('深广180111008', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180111009', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180111010', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180111011', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180111012', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180111013', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180111014', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('深广180111015', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180111016', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180111017', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180111018', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180111019', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180111020', '100', '38', '38');
INSERT INTO `car_ticket_info` VALUES ('深广180111021', '100', '46', '46');
INSERT INTO `car_ticket_info` VALUES ('深广180111022', '100', '36', '36');
INSERT INTO `car_ticket_info` VALUES ('深广180111023', '100', '42', '42');
INSERT INTO `car_ticket_info` VALUES ('深广180111024', '100', '44', '44');
INSERT INTO `car_ticket_info` VALUES ('深广180111025', '100', '40', '40');
INSERT INTO `car_ticket_info` VALUES ('深广180111026', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180111027', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180111028', '100', '32', '32');
INSERT INTO `car_ticket_info` VALUES ('深广180111029', '100', '34', '34');
INSERT INTO `car_ticket_info` VALUES ('深广180111030', '100', '32', '32');

-- ----------------------------
-- Table structure for `passenger_info`
-- ----------------------------
DROP TABLE IF EXISTS `passenger_info`;
CREATE TABLE `passenger_info` (
  `p_id` varchar(18) NOT NULL COMMENT '身份证',
  `p_name` varchar(25) NOT NULL COMMENT '乘客姓名',
  `ticket_num` smallint(5) unsigned DEFAULT '0' COMMENT '购买票数',
  `wait_ticket` smallint(5) unsigned DEFAULT '0' COMMENT '待出发票数',
  `finished_ticket` smallint(5) unsigned DEFAULT '0' COMMENT '已完成出行票数',
  `alter_ticket` smallint(5) unsigned DEFAULT '0' COMMENT '改签票数',
  `return_ticket` smallint(5) unsigned DEFAULT '0' COMMENT '退票数',
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of passenger_info
-- ----------------------------
INSERT INTO `passenger_info` VALUES ('456789199601011234', '小明', '2', '2', '0', '0', '0');

-- ----------------------------
-- Table structure for `return_ticket_info`
-- ----------------------------
DROP TABLE IF EXISTS `return_ticket_info`;
CREATE TABLE `return_ticket_info` (
  `p_id` varchar(18) NOT NULL,
  `return_ticket_no` varchar(20) DEFAULT NULL,
  `otk_no` varchar(20) DEFAULT NULL COMMENT '原车票编号',
  `car_no` varchar(25) DEFAULT NULL,
  `return_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '标志',
  PRIMARY KEY (`p_id`),
  KEY `fk_rti2tbi_pid_otkno` (`p_id`,`otk_no`),
  KEY `status` (`status`),
  CONSTRAINT `fk_rti2tbi_pid_otkno` FOREIGN KEY (`p_id`, `otk_no`) REFERENCES `ticket_buy_info` (`p_id`, `tk_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `return_ticket_info_ibfk_1` FOREIGN KEY (`status`) REFERENCES `status_info` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of return_ticket_info
-- ----------------------------

-- ----------------------------
-- Table structure for `status_info`
-- ----------------------------
DROP TABLE IF EXISTS `status_info`;
CREATE TABLE `status_info` (
  `status` tinyint(4) NOT NULL,
  `meaning` varchar(25) NOT NULL COMMENT '车票状态：0——无效/过期\r\n1——已改签\r\n2——已购买\r\n-1——已完成/已出行\r\n-2——已退票',
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of status_info
-- ----------------------------
INSERT INTO `status_info` VALUES ('-2', '已退票');
INSERT INTO `status_info` VALUES ('-1', '已出行');
INSERT INTO `status_info` VALUES ('0', '无效/过期');
INSERT INTO `status_info` VALUES ('1', '已改签');
INSERT INTO `status_info` VALUES ('2', '已购买');

-- ----------------------------
-- Table structure for `ticket_buy_info`
-- ----------------------------
DROP TABLE IF EXISTS `ticket_buy_info`;
CREATE TABLE `ticket_buy_info` (
  `p_id` varchar(18) NOT NULL COMMENT '购票人身份证',
  `tk_no` varchar(20) NOT NULL COMMENT '车票编号',
  `car_no` varchar(25) DEFAULT NULL COMMENT '车次号',
  `seat_no` tinyint(3) unsigned DEFAULT NULL COMMENT '座位号',
  `validity` tinyint(4) DEFAULT NULL COMMENT '车票状态：0——无效/过期\r\n1——已改签\r\n2——已购买\r\n-1——已完成/已出行\r\n-2——已退票',
  `buy_time` datetime DEFAULT NULL COMMENT '购买时间',
  PRIMARY KEY (`p_id`,`tk_no`),
  KEY `p_id` (`p_id`,`tk_no`),
  KEY `fk_tbi2ci_car_no` (`car_no`),
  KEY `validity` (`validity`),
  CONSTRAINT `fk_tbi2ci_car_no` FOREIGN KEY (`car_no`) REFERENCES `car_info` (`car_no`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_tbi2pi_pid` FOREIGN KEY (`p_id`) REFERENCES `passenger_info` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ticket_buy_info_ibfk_1` FOREIGN KEY (`validity`) REFERENCES `status_info` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ticket_buy_info
-- ----------------------------
INSERT INTO `ticket_buy_info` VALUES ('456789199601011234', 'GP1090805068', '广深180109003', null, '2', '2018-01-08 09:16:13');
INSERT INTO `ticket_buy_info` VALUES ('456789199601011234', 'GP1100807209', '深广180110008', null, '2', '2018-01-08 09:16:45');

-- ----------------------------
-- Table structure for `type_account_list`
-- ----------------------------
DROP TABLE IF EXISTS `type_account_list`;
CREATE TABLE `type_account_list` (
  `id_type` tinyint(4) NOT NULL,
  `meaning` varchar(20) NOT NULL COMMENT '账号类型：3——管理员；2——售票员',
  PRIMARY KEY (`id_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of type_account_list
-- ----------------------------
INSERT INTO `type_account_list` VALUES ('1', '售票员');
INSERT INTO `type_account_list` VALUES ('2', '管理员');
