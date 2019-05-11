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

 Date: 11/05/2019 22:51:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for classRoom
-- ----------------------------
DROP TABLE IF EXISTS `classRoom`;
CREATE TABLE `classRoom`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `arrived` varchar(45000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `arriveNum` int(255) NULL DEFAULT NULL,
  `total` int(255) NULL DEFAULT NULL,
  `col` int(255) NULL DEFAULT NULL,
  `row` int(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classRoom
-- ----------------------------
INSERT INTO `classRoom` VALUES (1, '教室1', 'asdasd', 1, 1, 1, 1);
INSERT INTO `classRoom` VALUES (2, '教室2', 'asdasdasd', 12, 344, 12, 123);
INSERT INTO `classRoom` VALUES (5, '教室5', 'asdasdasd', 12, 344, 12, 123);
INSERT INTO `classRoom` VALUES (7, '教室1', NULL, 1, 1, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
