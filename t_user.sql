/*
 Navicat Premium Data Transfer

 Source Server         : Navicat
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : localhost:3306
 Source Schema         : user_manager

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 22/03/2022 02:27:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `age` int(11) NOT NULL,
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `qq` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 114 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (6, 'rick', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (7, '老九', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (8, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (9, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (10, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (11, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (12, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (13, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (14, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (15, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (16, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (17, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (18, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (19, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (20, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (21, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (22, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (23, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (24, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (25, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (26, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (27, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (28, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (29, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (30, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (31, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (32, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (33, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (34, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (35, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (36, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (37, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (38, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (39, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (40, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (41, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (42, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (43, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (44, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (45, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (46, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (47, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (48, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (49, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (50, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (51, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (52, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (53, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (54, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (55, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (56, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (57, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (58, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (59, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (60, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (61, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (62, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (63, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (64, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (65, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (66, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (67, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (68, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (69, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (70, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (71, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (72, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (73, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (74, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (75, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (76, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (77, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (78, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (79, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (80, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (81, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (82, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (83, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (84, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (85, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (86, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (87, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (88, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (89, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (90, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (91, '张三', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (92, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (93, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (94, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (95, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (96, '', '男', 21, '广东', '766335435', 'zs@qq.com');
INSERT INTO `t_user` VALUES (97, '李四', '男', 22, '广东', '243424242', 'ls@qq.com');
INSERT INTO `t_user` VALUES (98, '王五', '女', 23, '广东', '474574574', 'ww@qq.com');
INSERT INTO `t_user` VALUES (99, '赵六', '女', 28, '广东', '77777777', 'zl@qq.com');
INSERT INTO `t_user` VALUES (100, '钱七', '女', 25, '湖南', '412132145', 'qq@qq.com');
INSERT INTO `t_user` VALUES (112, '老八', '女', 22, '湖南', '87878787878', '87@qq.com');
INSERT INTO `t_user` VALUES (113, '张三', '男', 33, '广东', '33', '33@qq.com');

SET FOREIGN_KEY_CHECKS = 1;
