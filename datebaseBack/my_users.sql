/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : 47.107.248.108:3306
 Source Schema         : flask

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 11/05/2019 22:50:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for my_users
-- ----------------------------
DROP TABLE IF EXISTS `my_users`;
CREATE TABLE `my_users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `endtime` datetime(6) NULL DEFAULT NULL,
  `role` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of my_users
-- ----------------------------
INSERT INTO `my_users` VALUES (2, '123', '202cb962ac59075b964b07152d234b70', '管理员关', 'VTQHRB8MLJ', '2019-05-11 22:44:22.000000', 'admin');

-- ----------------------------
-- Triggers structure for table my_users
-- ----------------------------
DROP TRIGGER IF EXISTS `tigger`;
delimiter ;;
CREATE TRIGGER `tigger` BEFORE UPDATE ON `my_users` FOR EACH ROW BEGIN
if (OLD.token != new.token) or (OLD.token IS NULL && new.token IS NOT NULL)
THEN
set new.endtime=now() ;
END if;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
