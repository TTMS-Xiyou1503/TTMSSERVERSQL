/*
 Navicat Premium Data Transfer

 Source Server         : Ksgin
 Source Server Type    : SQL Server
 Source Server Version : 13004001
 Source Host           : 47.93.98.212
 Source Database       : TTMS
 Source Schema         : dbo

 Target Server Type    : SQL Server
 Target Server Version : 13004001
 File Encoding         : utf-8

 Date: 05/20/2017 23:55:30 PM
*/

-- ----------------------------
--  Table structure for Goods
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[Goods]') AND type IN ('U'))
	DROP TABLE [dbo].[Goods]
GO
CREATE TABLE [dbo].[Goods] (
	[Id] int IDENTITY(1,1) NOT NULL,
	[proID] int NOT NULL,
	[theaterID] int NOT NULL,
	[performance] nvarchar(10) COLLATE Chinese_PRC_CI_AS NOT NULL DEFAULT (N'早一'),
	[playdate] date NOT NULL DEFAULT ('1-1-2017'),
	[price] money NOT NULL DEFAULT ('0')
)
GO
EXEC sp_addextendedproperty 'MS_Description', N'商品表', 'SCHEMA', 'dbo', 'TABLE', 'Goods'
GO
EXEC sp_addextendedproperty 'MS_Description', N'商品ID', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'COLUMN', 'Id'
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目ID', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'COLUMN', 'proID'
GO
EXEC sp_addextendedproperty 'MS_Description', N'放映厅ID', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'COLUMN', 'theaterID'
GO
EXEC sp_addextendedproperty 'MS_Description', N'场次', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'COLUMN', 'performance'
GO
EXEC sp_addextendedproperty 'MS_Description', N'播放日期', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'COLUMN', 'playdate'
GO
EXEC sp_addextendedproperty 'MS_Description', N'价格', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'COLUMN', 'price'
GO

-- ----------------------------
--  Table structure for Orders
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[Orders]') AND type IN ('U'))
	DROP TABLE [dbo].[Orders]
GO
CREATE TABLE [dbo].[Orders] (
	[Id] int IDENTITY(1,1) NOT NULL,
	[ticketID] int NOT NULL,
	[userID] int NOT NULL,
	[type] int NOT NULL DEFAULT ((1)),
	[time] datetime NOT NULL DEFAULT (getdate()),
	[theaterID] int NOT NULL
)
GO
EXEC sp_addextendedproperty 'MS_Description', N'订单记录表', 'SCHEMA', 'dbo', 'TABLE', 'Orders'
GO
EXEC sp_addextendedproperty 'MS_Description', N'订单ID', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'COLUMN', 'Id'
GO
EXEC sp_addextendedproperty 'MS_Description', N'票ID', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'COLUMN', 'ticketID'
GO
EXEC sp_addextendedproperty 'MS_Description', N'完成此订单用户ID', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'COLUMN', 'userID'
GO
EXEC sp_addextendedproperty 'MS_Description', N'订单类型', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'COLUMN', 'type'
GO
EXEC sp_addextendedproperty 'MS_Description', N'交易时间', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'COLUMN', 'time'
GO
EXEC sp_addextendedproperty 'MS_Description', N'完成此订单的放映厅ID', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'COLUMN', 'theaterID'
GO

-- ----------------------------
--  Table structure for Programmes
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[Programmes]') AND type IN ('U'))
	DROP TABLE [dbo].[Programmes]
GO
CREATE TABLE [dbo].[Programmes] (
	[Id] int IDENTITY(1,1) NOT NULL,
	[proName] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[duration] int NOT NULL,
	[tags] nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL,
	[profile] text COLLATE Chinese_PRC_CI_AS NULL DEFAULT (N'无简介')
)
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目表', 'SCHEMA', 'dbo', 'TABLE', 'Programmes'
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目ID', 'SCHEMA', 'dbo', 'TABLE', 'Programmes', 'COLUMN', 'Id'
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目名称', 'SCHEMA', 'dbo', 'TABLE', 'Programmes', 'COLUMN', 'proName'
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目时长(分钟)', 'SCHEMA', 'dbo', 'TABLE', 'Programmes', 'COLUMN', 'duration'
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目标签', 'SCHEMA', 'dbo', 'TABLE', 'Programmes', 'COLUMN', 'tags'
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目简介', 'SCHEMA', 'dbo', 'TABLE', 'Programmes', 'COLUMN', 'profile'
GO

-- ----------------------------
--  Records of Programmes
-- ----------------------------
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [dbo].[Programmes] ON
GO
INSERT INTO [dbo].[Programmes] ([Id], [proName], [duration], [tags], [profile]) VALUES ('8', N'长江10号', '120', N'喜剧', N'哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈');
GO
SET IDENTITY_INSERT [dbo].[Programmes] OFF
GO
COMMIT
GO

-- ----------------------------
--  Table structure for Seats
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[Seats]') AND type IN ('U'))
	DROP TABLE [dbo].[Seats]
GO
CREATE TABLE [dbo].[Seats] (
	[Id] int IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[theaterID] int NOT NULL,
	[status] bit NOT NULL DEFAULT ((1)),
	[rowNumber] int NOT NULL DEFAULT ((1)),
	[colNumber] int NOT NULL DEFAULT ((1))
)
GO
EXEC sp_addextendedproperty 'MS_Description', N'座位表
', 'SCHEMA', 'dbo', 'TABLE', 'Seats'
GO
EXEC sp_addextendedproperty 'MS_Description', N'座位ID', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'COLUMN', 'Id'
GO
EXEC sp_addextendedproperty 'MS_Description', N'放映厅ID', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'COLUMN', 'theaterID'
GO
EXEC sp_addextendedproperty 'MS_Description', N'座位状态', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'COLUMN', 'status'
GO
EXEC sp_addextendedproperty 'MS_Description', N'第n行', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'COLUMN', 'rowNumber'
GO
EXEC sp_addextendedproperty 'MS_Description', N'第n列', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'COLUMN', 'colNumber'
GO

-- ----------------------------
--  Records of Seats
-- ----------------------------
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [dbo].[Seats] ON
GO
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('23', '2', '1', '10', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('113', '8', '1', '1', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('114', '8', '1', '1', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('115', '8', '1', '1', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('116', '8', '1', '1', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('117', '8', '1', '1', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('118', '8', '1', '1', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('119', '8', '1', '1', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('120', '8', '1', '1', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('121', '8', '1', '1', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('122', '8', '1', '2', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('123', '8', '1', '2', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('124', '8', '1', '2', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('125', '8', '1', '2', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('126', '8', '1', '2', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('127', '8', '1', '2', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('128', '8', '1', '2', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('129', '8', '1', '2', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('130', '8', '1', '2', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('131', '8', '1', '2', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('132', '8', '1', '3', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('133', '8', '1', '3', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('134', '8', '1', '3', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('135', '8', '1', '3', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('136', '8', '1', '3', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('137', '8', '1', '3', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('138', '8', '1', '3', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('139', '8', '1', '3', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('140', '8', '1', '3', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('141', '8', '1', '3', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('142', '8', '1', '4', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('143', '8', '1', '4', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('144', '8', '1', '4', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('145', '8', '1', '4', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('146', '8', '1', '4', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('147', '8', '1', '4', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('148', '8', '1', '4', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('149', '8', '1', '4', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('150', '8', '1', '4', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('151', '8', '1', '4', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('152', '8', '1', '5', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('153', '8', '1', '5', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('154', '8', '1', '5', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('155', '8', '1', '5', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('156', '8', '1', '5', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('157', '8', '1', '5', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('158', '8', '1', '5', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('159', '8', '1', '5', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('160', '8', '1', '5', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('161', '8', '1', '5', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('162', '8', '1', '6', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('163', '8', '1', '6', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('164', '8', '1', '6', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('165', '8', '1', '6', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('166', '8', '1', '6', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('167', '8', '1', '6', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('168', '8', '1', '6', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('169', '8', '1', '6', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('170', '8', '1', '6', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('171', '8', '1', '6', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('172', '8', '1', '7', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('173', '8', '1', '7', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('174', '8', '1', '7', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('175', '8', '1', '7', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('176', '8', '1', '7', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('177', '8', '1', '7', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('178', '8', '1', '7', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('179', '8', '1', '7', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('180', '8', '1', '7', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('181', '8', '1', '7', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('182', '8', '1', '8', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('183', '8', '1', '8', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('184', '8', '1', '8', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('185', '8', '1', '8', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('186', '8', '1', '8', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('187', '8', '1', '8', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('188', '8', '1', '8', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('189', '8', '1', '8', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('190', '8', '1', '8', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('191', '8', '1', '8', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('192', '8', '1', '9', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('193', '8', '1', '9', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('194', '8', '1', '9', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('195', '8', '1', '9', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('196', '8', '1', '9', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('197', '8', '1', '9', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('198', '8', '1', '9', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('199', '8', '1', '9', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('200', '8', '1', '9', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('201', '8', '1', '9', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('202', '8', '1', '10', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('203', '8', '1', '10', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('204', '8', '1', '10', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('205', '8', '1', '10', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('206', '8', '1', '10', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('207', '8', '1', '10', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('208', '8', '1', '10', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('209', '8', '1', '10', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('210', '8', '1', '10', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('211', '8', '1', '10', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('212', '9', '1', '1', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('213', '9', '1', '1', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('214', '9', '1', '1', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('215', '9', '1', '1', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('216', '9', '1', '1', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('217', '9', '1', '1', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('218', '9', '1', '1', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('219', '9', '1', '1', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('220', '9', '1', '1', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('221', '9', '1', '2', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('222', '9', '1', '2', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('223', '9', '1', '2', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('224', '9', '1', '2', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('225', '9', '1', '2', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('226', '9', '1', '2', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('227', '9', '1', '2', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('228', '9', '1', '2', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('229', '9', '1', '2', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('230', '9', '1', '2', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('231', '9', '1', '3', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('232', '9', '1', '3', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('233', '9', '1', '3', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('234', '9', '1', '3', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('235', '9', '1', '3', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('236', '9', '1', '3', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('237', '9', '1', '3', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('238', '9', '1', '3', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('239', '9', '1', '3', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('240', '9', '1', '3', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('241', '9', '1', '4', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('242', '9', '1', '4', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('243', '9', '1', '4', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('244', '9', '1', '4', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('245', '9', '1', '4', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('246', '9', '1', '4', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('247', '9', '1', '4', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('248', '9', '1', '4', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('249', '9', '1', '4', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('250', '9', '1', '4', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('251', '9', '1', '5', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('252', '9', '1', '5', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('253', '9', '1', '5', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('254', '9', '1', '5', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('255', '9', '1', '5', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('256', '9', '1', '5', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('257', '9', '1', '5', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('258', '9', '1', '5', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('259', '9', '1', '5', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('260', '9', '1', '5', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('261', '9', '1', '6', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('262', '9', '1', '6', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('263', '9', '1', '6', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('264', '9', '1', '6', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('265', '9', '1', '6', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('266', '9', '1', '6', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('267', '9', '1', '6', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('268', '9', '1', '6', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('269', '9', '1', '6', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('270', '9', '1', '6', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('271', '9', '1', '7', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('272', '9', '1', '7', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('273', '9', '1', '7', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('274', '9', '1', '7', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('275', '9', '1', '7', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('276', '9', '1', '7', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('277', '9', '1', '7', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('278', '9', '1', '7', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('279', '9', '1', '7', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('280', '9', '1', '7', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('281', '9', '1', '8', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('282', '9', '1', '8', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('283', '9', '1', '8', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('284', '9', '1', '8', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('285', '9', '1', '8', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('286', '9', '1', '8', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('287', '9', '1', '8', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('288', '9', '1', '8', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('289', '9', '1', '8', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('290', '9', '1', '8', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('291', '9', '1', '9', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('292', '9', '1', '9', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('293', '9', '1', '9', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('294', '9', '1', '9', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('295', '9', '1', '9', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('296', '9', '1', '9', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('297', '9', '1', '9', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('298', '9', '1', '9', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('299', '9', '1', '9', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('300', '9', '1', '9', '10');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('301', '9', '1', '10', '1');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('302', '9', '1', '10', '2');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('303', '9', '1', '10', '3');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('304', '9', '1', '10', '4');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('305', '9', '1', '10', '5');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('306', '9', '1', '10', '6');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('307', '9', '1', '10', '7');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('308', '9', '1', '10', '8');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('309', '9', '1', '10', '9');
INSERT INTO [dbo].[Seats] ([Id], [theaterID], [status], [rowNumber], [colNumber]) VALUES ('310', '9', '1', '10', '10');
GO
SET IDENTITY_INSERT [dbo].[Seats] OFF
GO
COMMIT
GO

-- ----------------------------
--  Table structure for Theaters
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[Theaters]') AND type IN ('U'))
	DROP TABLE [dbo].[Theaters]
GO
CREATE TABLE [dbo].[Theaters] (
	[Id] int IDENTITY(1,1) NOT NULL,
	[theaterName] nvarchar(30) COLLATE Chinese_Simplified_Pinyin_100_BIN NOT NULL DEFAULT (N'影厅'),
	[theaterLocation] nvarchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL DEFAULT (N'中国'),
	[theaterMapSite] nvarchar(30) COLLATE Chinese_PRC_CI_AS NULL DEFAULT ('https://gaode.com'),
	[theaterAdminID] int NULL,
	[seatRowCount] int NOT NULL DEFAULT ((0)),
	[seatColCount] int NOT NULL DEFAULT ((0))
)
GO
EXEC sp_addextendedproperty 'MS_Description', N'放映厅表', 'SCHEMA', 'dbo', 'TABLE', 'Theaters'
GO
EXEC sp_addextendedproperty 'MS_Description', N'放映厅ID', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'COLUMN', 'Id'
GO
EXEC sp_addextendedproperty 'MS_Description', N'影厅名称', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'COLUMN', 'theaterName'
GO
EXEC sp_addextendedproperty 'MS_Description', N'影厅位置', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'COLUMN', 'theaterLocation'
GO
EXEC sp_addextendedproperty 'MS_Description', N'影厅在地图上的位置', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'COLUMN', 'theaterMapSite'
GO
EXEC sp_addextendedproperty 'MS_Description', N'影厅管理者的ID', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'COLUMN', 'theaterAdminID'
GO
EXEC sp_addextendedproperty 'MS_Description', N'影厅座位行个数', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'COLUMN', 'seatRowCount'
GO
EXEC sp_addextendedproperty 'MS_Description', N'影厅座位列个数', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'COLUMN', 'seatColCount'
GO

-- ----------------------------
--  Records of Theaters
-- ----------------------------
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [dbo].[Theaters] ON
GO
INSERT INTO [dbo].[Theaters] ([Id], [theaterName], [theaterLocation], [theaterMapSite], [theaterAdminID], [seatRowCount], [seatColCount]) VALUES ('2', N'西邮1号放映厅', N'西安邮电大学', 'gaode.com', '2', '10', '10');
INSERT INTO [dbo].[Theaters] ([Id], [theaterName], [theaterLocation], [theaterMapSite], [theaterAdminID], [seatRowCount], [seatColCount]) VALUES ('8', 'string', 'string', 'string', '2', '10', '10');
INSERT INTO [dbo].[Theaters] ([Id], [theaterName], [theaterLocation], [theaterMapSite], [theaterAdminID], [seatRowCount], [seatColCount]) VALUES ('9', 'string1', 'string', 'string', '2', '10', '10');
GO
SET IDENTITY_INSERT [dbo].[Theaters] OFF
GO
COMMIT
GO

-- ----------------------------
--  Table structure for Tickets
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[Tickets]') AND type IN ('U'))
	DROP TABLE [dbo].[Tickets]
GO
CREATE TABLE [dbo].[Tickets] (
	[Id] int IDENTITY(1,1) NOT NULL,
	[price] money NOT NULL,
	[status] int NOT NULL DEFAULT ((0)),
	[seatID] int NOT NULL,
	[goodID] int NOT NULL
)
GO
EXEC sp_addextendedproperty 'MS_Description', N'影票表', 'SCHEMA', 'dbo', 'TABLE', 'Tickets'
GO
EXEC sp_addextendedproperty 'MS_Description', N'票ID', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'COLUMN', 'Id'
GO
EXEC sp_addextendedproperty 'MS_Description', N'票状态', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'COLUMN', 'status'
GO
EXEC sp_addextendedproperty 'MS_Description', N'座位ID', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'COLUMN', 'seatID'
GO
EXEC sp_addextendedproperty 'MS_Description', N'商品ID', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'COLUMN', 'goodID'
GO

-- ----------------------------
--  Table structure for UserIPs
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[UserIPs]') AND type IN ('U'))
	DROP TABLE [dbo].[UserIPs]
GO
CREATE TABLE [dbo].[UserIPs] (
	[ip] varchar(20) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[limitTimes] int NOT NULL DEFAULT ((500))
)
GO
EXEC sp_addextendedproperty 'MS_Description', N'IP限制 ， 此表用于API的限制IP访问', 'SCHEMA', 'dbo', 'TABLE', 'UserIPs'
GO

-- ----------------------------
--  Records of UserIPs
-- ----------------------------
BEGIN TRANSACTION
GO
INSERT INTO [dbo].[UserIPs] VALUES ('0.0.0.1', '-1');
INSERT INTO [dbo].[UserIPs] VALUES ('111.20.21.63', '500');
INSERT INTO [dbo].[UserIPs] VALUES ('111.20.21.85', '500');
INSERT INTO [dbo].[UserIPs] VALUES ('115.239.212.132', '500');
INSERT INTO [dbo].[UserIPs] VALUES ('117.32.216.111', '500');
INSERT INTO [dbo].[UserIPs] VALUES ('117.32.216.116', '500');
INSERT INTO [dbo].[UserIPs] VALUES ('117.32.216.25', '500');
INSERT INTO [dbo].[UserIPs] VALUES ('117.32.216.41', '500');
INSERT INTO [dbo].[UserIPs] VALUES ('117.32.216.63', '500');
INSERT INTO [dbo].[UserIPs] VALUES ('221.11.61.134', '500');
GO
COMMIT
GO

-- ----------------------------
--  Table structure for Users
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[Users]') AND type IN ('U'))
	DROP TABLE [dbo].[Users]
GO
CREATE TABLE [dbo].[Users] (
	[Id] int IDENTITY(1,1) NOT NULL,
	[userName] nvarchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[userAccount] nvarchar(15) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[userPassword] nvarchar(15) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[signUpTime] datetime NOT NULL,
	[lastSigninTime] datetime NOT NULL,
	[userLevel] nvarchar(15) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[userSex] nvarchar(10) COLLATE Chinese_PRC_CI_AS NULL,
	[userAvatar] varbinary(4096) NULL,
	[userTel] nvarchar(12) COLLATE Chinese_PRC_CI_AS NULL
)
GO
EXEC sp_addextendedproperty 'MS_Description', N'用户表', 'SCHEMA', 'dbo', 'TABLE', 'Users'
GO
EXEC sp_addextendedproperty 'MS_Description', N'用户ID', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'Id'
GO
EXEC sp_addextendedproperty 'MS_Description', N'用户名称', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'userName'
GO
EXEC sp_addextendedproperty 'MS_Description', N'用户账号', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'userAccount'
GO
EXEC sp_addextendedproperty 'MS_Description', N'用户密码', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'userPassword'
GO
EXEC sp_addextendedproperty 'MS_Description', N'注册时间', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'signUpTime'
GO
EXEC sp_addextendedproperty 'MS_Description', N'最后一次登陆时间', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'lastSigninTime'
GO
EXEC sp_addextendedproperty 'MS_Description', N'用户级别', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'userLevel'
GO
EXEC sp_addextendedproperty 'MS_Description', N'用户性别', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'userSex'
GO
EXEC sp_addextendedproperty 'MS_Description', N'用户头像', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'userAvatar'
GO
EXEC sp_addextendedproperty 'MS_Description', N'用户电话', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'userTel'
GO

-- ----------------------------
--  Records of Users
-- ----------------------------
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [dbo].[Users] ON
GO
INSERT INTO [dbo].[Users] ([Id], [userName], [userAccount], [userPassword], [signUpTime], [lastSigninTime], [userLevel], [userSex], [userAvatar], [userTel]) VALUES ('2', N'杨帆', 'yangfan', 'string', '2017-05-04 22:47:29.570', '2017-05-18 21:29:42.300', N'系统管理员', N'男', null, '18829076013');
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
COMMIT
GO

-- ----------------------------
--  Procedure structure for sp_CreateProgramme
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_CreateProgramme]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_CreateProgramme]
GO
CREATE PROCEDURE [dbo].[sp_CreateProgramme] 
@proName nvarchar(50) , @duration INT , @tags nvarchar(20) , @profile TEXT ,
@message nvarchar(30) OUTPUT
AS
IF NOT EXISTS(SELECT 1 FROM dbo.Programmes WHERE proName = @proName)
BEGIN
	BEGIN TRY
		INSERT INTO Programmes
			(proName , duration , tags , profile)
			VALUES
			(@proName , @duration , @tags , @profile)
		SET @message = 'successful'
		RETURN 200
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
		RETURN ERROR_NUMBER() --其他错误
	END CATCH
END
ELSE
BEGIN 
	SET @message = 'the programme is exists'
	RETURN 400 --名称已存在
END
GO

-- ----------------------------
--  Procedure structure for sp_DeleteProgramme
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_DeleteProgramme]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_DeleteProgramme]
GO
CREATE PROCEDURE [dbo].[sp_DeleteProgramme] 
	@programmeId INT , 
	@message VARCHAR(30) OUTPUT
AS
IF EXISTS(SELECT 1 FROM Programmes WHERE Id = @ProgrammeId)
BEGIN
	BEGIN TRY
		DELETE Programmes WHERE Id = @ProgrammeId
		SET @message = 'successful'
		RETURN 204
	END TRY
	BEGIN CATCH
		SET @message = ERROR_MESSAGE()
		RETURN ERROR_NUMBER()
	END CATCH
END
ELSE
BEGIN
	SET @message = 'the programme is not exists'
	RETURN 404
END

GO

-- ----------------------------
--  Procedure structure for sp_GetAllProgramme
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_GetAllProgramme]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_GetAllProgramme]
GO
CREATE PROCEDURE [dbo].[sp_GetAllProgramme] 
	@message VARCHAR(30) OUTPUT
AS
BEGIN TRY
	SELECT * 
	FROM Programmes
	SET @message = 'successful'
	RETURN 200
END TRY
BEGIN CATCH
	SET @message = ERROR_MESSAGE()
	RETURN ERROR_NUMBER()
END CATCH

GO

-- ----------------------------
--  Procedure structure for sp_QueryProgramme
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_QueryProgramme]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_QueryProgramme]
GO
CREATE PROCEDURE [dbo].[sp_QueryProgramme] 
	@programmeName NVARCHAR(50) = NULL , 
	@programmeId INT = NULL , 
	@message VARCHAR(30) OUTPUT
AS
BEGIN TRY
	SELECT *
	FROM Programmes 
	WHERE (@programmeName IS NULL OR @programmeName = proName) 
		AND(@programmeId IS NULL OR @programmeId = Id)		
	SET @message = 'successful'
	RETURN 200
END TRY
BEGIN CATCH
	SET @message = ERROR_MESSAGE()
	RETURN ERROR_NUMBER()
END CATCH

GO

-- ----------------------------
--  Procedure structure for sp_SelectProgramme
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_SelectProgramme]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_SelectProgramme]
GO
CREATE PROCEDURE [dbo].[sp_SelectProgramme] 
	@tags NVARCHAR(20) ,
	@message VARCHAR(30) OUTPUT
AS
BEGIN TRY
	SELECT *
	FROM Programmes 
	WHERE tags = @tags		
	SET @message = 'successful'
	RETURN 200
END TRY
BEGIN CATCH
	SET @message = ERROR_MESSAGE()
	RETURN ERROR_NUMBER()
END CATCH


GO

-- ----------------------------
--  Procedure structure for sp_UpdateUser
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_UpdateUser]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_UpdateUser]
GO
CREATE PROCEDURE [dbo].[sp_UpdateUser] 
	@userId INT , @newLevel nvarchar(15) = NULL , @newTel nvarchar(12) = NULL , @newPassword nvarchar(15) = NULL,
	@message varchar(30) OUTPUT
AS
IF EXISTS(SELECT 1 FROM users WHERE Id = @userId)
BEGIN
	IF(@newLevel IS NOT NULL)
		UPDATE users SET userLevel = @newLevel WHERE Id = @userId 
	IF(@newTel IS NOT NULL)
		UPDATE users SET userTel = @newLevel WHERE Id = @userId
	IF(@newPassword IS NOT NULL)
		UPDATE users SET userPassword = @newPassword WHERE Id = @userId
	set @message = 'update successful'
	return 200
end
else
BEGIN
	set @message = 'the user is not exists'
	return 404
END
GO
IF ((SELECT COUNT(*) FROM ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'PROCEDURE', 'sp_UpdateUser', NULL, NULL)) > 0) EXEC sp_updateextendedproperty 'MS_Description', N'修改用户等级', 'schema', 'dbo', 'PROCEDURE', 'sp_UpdateUser' ELSE EXEC sp_addextendedproperty 'MS_Description', N'修改用户等级', 'schema', 'dbo', 'PROCEDURE', 'sp_UpdateUser'
GO

-- ----------------------------
--  Procedure structure for sp_CreateTheater
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_CreateTheater]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_CreateTheater]
GO
CREATE PROCEDURE [dbo].[sp_CreateTheater] 
	@theaterName nvarchar(30), 
	@location nvarchar(30),
	@mapSite nvarchar(30),
	@adminId int,
	@seatRowsCount int,
	@seatColsCount int,
	@message varchar(30) OUTPUT
AS
IF EXISTS(SELECT 1 FROM dbo.Users WHERE Id = @adminId)
BEGIN
	IF NOT EXISTS(SELECT 1 FROM dbo.Theaters WHERE Theaters.theaterName = @theaterName)
	BEGIN
		INSERT INTO dbo.Theaters (
			Theaters.theaterName , 
			Theaters.theaterLocation , 
			Theaters.theaterMapSite , 
			Theaters.theaterAdminID , 
			Theaters.seatRowCount , 
			Theaters.seatColCount
			)
		VALUES (
			@theaterName , @location , @mapSite , @adminId , @seatRowsCount , @seatColsCount
		)
		SET @message = 'successful'
		RETURN 200
	END
	ELSE
	BEGIN
		SET @message = 'the theater is exists'
		RETURN 400
	END
END
ELSE
BEGIN
	SET @message = 'the user is not exists'
	RETURN 404
END
	
GO
IF ((SELECT COUNT(*) FROM ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'PROCEDURE', 'sp_CreateTheater', NULL, NULL)) > 0) EXEC sp_updateextendedproperty 'MS_Description', N'创建影厅', 'schema', 'dbo', 'PROCEDURE', 'sp_CreateTheater' ELSE EXEC sp_addextendedproperty 'MS_Description', N'创建影厅', 'schema', 'dbo', 'PROCEDURE', 'sp_CreateTheater'
GO

-- ----------------------------
--  Procedure structure for sp_UpdateTheater
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_UpdateTheater]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_UpdateTheater]
GO
CREATE PROCEDURE [dbo].[sp_UpdateTheater] 
	@theaterId INT , 
	@newAdminId int,
	@message varchar(30) OUTPUT
AS
IF EXISTS(SELECT 1 FROM dbo.Users WHERE Id = @newAdminId)
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Theaters WHERE Theaters.Id = @theaterId)
	BEGIN
		UPDATE Theaters SET theaterAdminID = @newAdminId WHERE Theaters.Id = @theaterId
		SET @message = 'successful'
		RETURN 200
	END
	ELSE
	BEGIN
		SET @message = 'the theater is not exists'
		RETURN 404
	END
END
ELSE
BEGIN
	SET @message = 'the user is not exists'
	RETURN 404
END
GO
IF ((SELECT COUNT(*) FROM ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'PROCEDURE', 'sp_UpdateTheater', NULL, NULL)) > 0) EXEC sp_updateextendedproperty 'MS_Description', N'修改影厅管理者', 'schema', 'dbo', 'PROCEDURE', 'sp_UpdateTheater' ELSE EXEC sp_addextendedproperty 'MS_Description', N'修改影厅管理者', 'schema', 'dbo', 'PROCEDURE', 'sp_UpdateTheater'
GO

-- ----------------------------
--  Procedure structure for sp_DeleteUser
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_DeleteUser]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_DeleteUser]
GO
CREATE PROCEDURE [dbo].[sp_DeleteUser]   
@userId INT,
@message varchar(30) OUTPUT
as
if exists(select 1 from Users where Id = @userId)
begin
	begin try
		DELETE Users WHERE Id = @userId
		set @message = 'successful'
		return 204
	end try
	begin catch
		set @message = ERROR_MESSAGE()
		return ERROR_NUMBER()
	end catch
end
else
begin
	set @message = 'the user is not exists'
	return 404
end
GO

-- ----------------------------
--  Procedure structure for sp_Login
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_Login]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_Login]
GO
CREATE PROCEDURE [dbo].[sp_Login]  
@account nvarchar(15) , @password nvarchar(15) , 
@message varchar(30) OUTPUT
as
declare @userPassword nvarchar(15)
set @userPassword = ' '
if exists(select 1 from Users where userAccount = @account)
begin
	select @userPassword = userPassword from Users where userAccount = @account
	if(@password = @userPassword)
	begin
		update Users set lastSigninTime	= getdate() where userAccount = @account
		set @message = 'successful' 
		return	200
	end
	else
		set @message = 'wrong password' 
		return	401
		
end
else
	set @message = 'the user is not exists'
	return 404 
GO

-- ----------------------------
--  Procedure structure for sp_QueryUser
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_QueryUser]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_QueryUser]
GO
CREATE PROCEDURE [dbo].[sp_QueryUser]   
@account nvarchar(15) = NULL,
@userId INT = NULL ,
@message varchar(30) OUTPUT
as
BEGIN TRY
	SELECT *
	from Users 
	where (@account IS NULL OR userAccount = @account)
		AND (@userId IS NULL OR Id = @userId)
	SET @message = 'successful'
	RETURN 200
END TRY
BEGIN CATCH
	SET @message = ERROR_MESSAGE()
	RETURN ERROR_NUMBER()
END CATCH

GO

-- ----------------------------
--  Procedure structure for sp_CreateUser
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_CreateUser]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_CreateUser]
GO
CREATE PROCEDURE [dbo].[sp_CreateUser]  
@name nvarchar(30) , @account nvarchar(15) , @password nvarchar(15) ,
@level nvarchar(10) , @sex nvarchar(10) , @tel nvarchar(12),
@message varchar(30) OUTPUT
as

if not exists(select 1 from Users where userAccount = @account)
begin
	begin try
		insert into Users values
		(@name , @account , @password , getdate() , getdate() , @level , @sex , null , @tel);
		set @message = 'successful'
		return 200
	end try
	begin catch
		set @message = ERROR_MESSAGE()
		return ERROR_NUMBER()
	end catch
end
else
begin
	set @message = 'the user is exists'
	return 400
end
GO

-- ----------------------------
--  Procedure structure for sp_CreateSeat
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_CreateSeat]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_CreateSeat]
GO
CREATE PROCEDURE [dbo].[sp_CreateSeat] 
	@theaterID INT , @rowNumber INT , @colNumber INT ,
	@message VARCHAR(30) OUTPUT
AS

IF EXISTS(SELECT 1 FROM dbo.Theaters WHERE Theaters.Id = @theaterID)
BEGIN
	IF NOT EXISTS(SELECT 1 FROM dbo.Seats WHERE TheaterId = @theaterID 
	AND rowNumber = @rowNumber AND colNumber = @colNumber)
	BEGIN
		IF(@rowNumber <= 0 OR @colNumber <= 0)
		BEGIN
			SET @message = 'rowNumber or colNumber must bigger than zero'
			RETURN 406 --用户请求不对
		END
		ELSE
			BEGIN TRY
				INSERT INTO Seats
					(theaterID , rowNumber , colNumber , status)
					VALUES 
					(@theaterID , @rowNumber , @colNumber , 1)
				SET @message = 'successful'
				RETURN 201 --创建成功
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE()
				RETURN ERROR_NUMBER()
			END CATCH
	END
	ELSE
	BEGIN
		SET @message = 'the seat is exists'
		RETURN 400 --要创建的座位已存在
	END	
END
ELSE
BEGIN
	SET @message = 'theater is not exists'
	RETURN 404 --未找到
END

GO
IF ((SELECT COUNT(*) FROM ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'PROCEDURE', 'sp_CreateSeat', NULL, NULL)) > 0) EXEC sp_updateextendedproperty 'MS_Description', N'创建一个新座位  用于影厅初始化', 'schema', 'dbo', 'PROCEDURE', 'sp_CreateSeat' ELSE EXEC sp_addextendedproperty 'MS_Description', N'创建一个新座位  用于影厅初始化', 'schema', 'dbo', 'PROCEDURE', 'sp_CreateSeat'
GO

-- ----------------------------
--  Procedure structure for sp_UpdateSeatStatus
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_UpdateSeatStatus]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_UpdateSeatStatus]
GO
CREATE PROCEDURE [dbo].[sp_UpdateSeatStatus] 
	@seatID INT, @status BIT ,
	@message VARCHAR(30) OUTPUT
AS
IF EXISTS(SELECT 1 FROM Seats WHERE Id = @seatID)
BEGIN
	BEGIN TRY
		UPDATE Seats SET status = @status WHERE Id = @seatID
		SET @message = 'successful'
		RETURN 200
	END TRY
	BEGIN CATCH
		SET @message = ERROR_MESSAGE()
		RETURN ERROR_NUMBER()
	END CATCH
END
ELSE
BEGIN
	SET @message = 'the seat is not exists'
	RETURN 404
END
GO

-- ----------------------------
--  Procedure structure for sp_CreateGood
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_CreateGood]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_CreateGood]
GO
CREATE PROCEDURE [dbo].[sp_CreateGood] 
	@proId INT , @theaterId INT , @performance nvarchar(10), @playDate DATE , @price MONEY ,
	@message VARCHAR(30) OUTPUT
AS
IF(@performance NOT IN (N'早一',N'早二',N'午一',N'午二',N'晚一',N'晚二',N'午夜'))
BEGIN
	SET @message = 'invail performance'
	RETURN 400
END
ELSE
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Theaters WHERE Theaters.Id = @theaterID)
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.Programme WHERE Programme.Id = @proID)
		BEGIN
			BEGIN TRY
				INSERT INTO Goods (proId , theaterId , performance , playDate , price)
				VALUES
				(@proId , @theaterId , @performance , @playDate , @price)
				SET @message = 'successful'
				RETURN 200
			END TRY
			BEGIN CATCH
				SET @message = ERROR_MESSAGE()
				RETURN ERROR_NUMBER()
			END CATCH
		END
		ELSE
		BEGIN
			SET @message = 'programme is not exists'
		RETURN 404 --未找到
		END
	END
	ELSE
	BEGIN
		SET @message = 'theater is not exists'
		RETURN 404 --未找到
	END
END
GO
IF ((SELECT COUNT(*) FROM ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'PROCEDURE', 'sp_CreateGood', NULL, NULL)) > 0) EXEC sp_updateextendedproperty 'MS_Description', N'上架节目', 'schema', 'dbo', 'PROCEDURE', 'sp_CreateGood' ELSE EXEC sp_addextendedproperty 'MS_Description', N'上架节目', 'schema', 'dbo', 'PROCEDURE', 'sp_CreateGood'
GO

-- ----------------------------
--  Procedure structure for sp_GetAllUser
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_GetAllUser]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_GetAllUser]
GO
CREATE PROCEDURE [dbo].[sp_GetAllUser] 	
@message varchar(30) OUTPUT
as
BEGIN TRY
	SELECT *
	from Users
	SET @message = 'successful'
	RETURN 200
END TRY
BEGIN CATCH
	SET @message = ERROR_MESSAGE()
	RETURN ERROR_NUMBER()
END CATCH
GO

-- ----------------------------
--  Procedure structure for sp_GetAllTheater
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_GetAllTheater]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_GetAllTheater]
GO
CREATE PROCEDURE [dbo].[sp_GetAllTheater] 
@message varchar(30) OUTPUT
as
BEGIN TRY
	select *
	from Theaters
	SET @message = 'successful'
	RETURN 200
END TRY
BEGIN CATCH
	SET @message = ERROR_MESSAGE()
	RETURN ERROR_NUMBER()
END CATCH
GO

-- ----------------------------
--  Procedure structure for sp_QueryTheater
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_QueryTheater]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_QueryTheater]
GO
CREATE PROCEDURE [dbo].[sp_QueryTheater] 
@theaterName nvarchar(30) = NULL,
@theaterId INT = NULL ,
@message varchar(30) OUTPUT
as
IF EXISTS(SELECT 1 FROM Theaters 
	WHERE (@theaterName IS NULL OR theaterName = @theaterName)
	AND (@theaterId = NULL OR Id = @theaterId))
BEGIN
	BEGIN TRY
		select *
		from Theaters 
		WHERE (@theaterName IS NULL OR theaterName = @theaterName)
			AND (@theaterId = NULL OR Id = @theaterId)
		SET @message = 'successful'
		RETURN 200
	END TRY
	BEGIN CATCH
		SET @message = ERROR_MESSAGE()
		RETURN ERROR_NUMBER()
	END CATCH
END
ELSE
BEGIN
	SET @message = 'the theater is not exists'
	RETURN 404
END

GO

-- ----------------------------
--  Procedure structure for sp_DeleteTheater
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_DeleteTheater]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_DeleteTheater]
GO
CREATE PROCEDURE [dbo].[sp_DeleteTheater] 
	@theaterId INT , 
	@message varchar(30) OUTPUT
AS
if exists(select 1 from Theaters where Id = @theaterId)
begin
	begin try
		DELETE Theaters where Id = @theaterId
		set @message = 'successful'
		return 204
	end try
	begin catch
		set @message = ERROR_MESSAGE()
		return ERROR_NUMBER()
	end catch
end
else
begin
	set @message = 'the theater is not exists'
	return 404
end

GO

-- ----------------------------
--  Procedure structure for sp_GetAllSeat
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_GetAllSeat]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_GetAllSeat]
GO
CREATE PROCEDURE [dbo].[sp_GetAllSeat] 
	@message varchar(30) OUTPUT
AS
BEGIN TRY
	select *
	from Seats
	SET @message = 'successful'
	RETURN 200
END TRY
BEGIN CATCH
	SET @message = ERROR_MESSAGE()
	RETURN ERROR_NUMBER()
END CATCH

GO

-- ----------------------------
--  Procedure structure for sp_QuerySeat
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_QuerySeat]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_QuerySeat]
GO
CREATE PROCEDURE [dbo].[sp_QuerySeat] 
	@theaterId INT = NULL, @rowNumber INT = NULL , @colNumber INT = NULL,
	@seatId INT = NULL ,
	@message varchar(30) OUTPUT
AS
BEGIN TRY
	select *
	from Seats 
	WHERE (@theaterId IS NULL OR (theaterID = @theaterID AND rowNumber = @rowNumber AND colNumber = @colNumber)) 
		AND(@seatId IS NULL OR @SeatId = Id)		
	SET @message = 'successful'
	RETURN 200
END TRY
BEGIN CATCH
	SET @message = ERROR_MESSAGE()
	RETURN ERROR_NUMBER()
END CATCH

GO

-- ----------------------------
--  Procedure structure for sp_DeleteSeat
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_DeleteSeat]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_DeleteSeat]
GO
CREATE PROCEDURE [dbo].[sp_DeleteSeat] 
	@seatId INT , 
	@message varchar(30) OUTPUT
AS
if exists(select 1 from Seats where Id = @seatId)
begin
	begin try
		DELETE Seats where Id = @seatId
		set @message = 'successful'
		return 204
	end try
	begin catch
		set @message = ERROR_MESSAGE()
		return ERROR_NUMBER()
	end catch
end
else
begin
	set @message = 'the seat is not exists'
	return 404
end
GO


-- ----------------------------
--  Primary key structure for table Goods
-- ----------------------------
ALTER TABLE [dbo].[Goods] ADD
	CONSTRAINT [PK__Goods__3214EC072B9D4BF1] PRIMARY KEY CLUSTERED ([Id]) 
	WITH (PAD_INDEX = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON)
GO

-- ----------------------------
--  Primary key structure for table Orders
-- ----------------------------
ALTER TABLE [dbo].[Orders] ADD
	CONSTRAINT [PK__Orders__3214EC071500447B] PRIMARY KEY CLUSTERED ([Id]) 
	WITH (PAD_INDEX = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON)
GO

-- ----------------------------
--  Checks structure for table Orders
-- ----------------------------
ALTER TABLE [dbo].[Orders] ADD
	CONSTRAINT [check_status] CHECK ([type]=(-1) OR [type]=(1))
GO

-- ----------------------------
--  Indexes structure for table Orders
-- ----------------------------
CREATE NONCLUSTERED INDEX [index_order]
ON [dbo].[Orders] ([userID] ASC, [theaterID] ASC)
WITH (PAD_INDEX = OFF,
	IGNORE_DUP_KEY = OFF,
	STATISTICS_NORECOMPUTE = OFF,
	SORT_IN_TEMPDB = OFF,
	ONLINE = OFF,
	ALLOW_ROW_LOCKS = ON,
	ALLOW_PAGE_LOCKS = ON)
GO
EXEC sp_addextendedproperty 'MS_Description', N'订单索引', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'INDEX', 'index_order'
GO

-- ----------------------------
--  Primary key structure for table Programmes
-- ----------------------------
ALTER TABLE [dbo].[Programmes] ADD
	CONSTRAINT [PK__Repertoi__3214EC07BD0E06D7] PRIMARY KEY CLUSTERED ([Id]) 
	WITH (PAD_INDEX = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON)
GO

-- ----------------------------
--  Primary key structure for table Seats
-- ----------------------------
ALTER TABLE [dbo].[Seats] ADD
	CONSTRAINT [PK__Seats__3214EC071C6F4FD1] PRIMARY KEY CLUSTERED ([Id]) 
	WITH (PAD_INDEX = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON)
GO

-- ----------------------------
--  Checks structure for table Seats
-- ----------------------------
ALTER TABLE [dbo].[Seats] ADD
	CONSTRAINT [check_row] CHECK ([rowNumber]>=(1)),
	CONSTRAINT [check_col] CHECK ([colNumber]>=(1)),
	CONSTRAINT [check_seatstatus] CHECK ([status]=(0) OR [status]=(1))
GO
EXEC sp_addextendedproperty 'MS_Description', N'行数大于0
', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'CONSTRAINT', 'check_row'
GO

-- ----------------------------
--  Primary key structure for table Theaters
-- ----------------------------
ALTER TABLE [dbo].[Theaters] ADD
	CONSTRAINT [PK__Theaters__3214EC0723B1CE45] PRIMARY KEY CLUSTERED ([Id]) 
	WITH (PAD_INDEX = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON)
GO

-- ----------------------------
--  Uniques structure for table Theaters
-- ----------------------------
ALTER TABLE [dbo].[Theaters] ADD
	CONSTRAINT [un_theaterName] UNIQUE NONCLUSTERED ([theaterName] ASC) 
	WITH (PAD_INDEX = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON)
GO
EXEC sp_addextendedproperty 'MS_Description', N'放映厅名不可重复', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'CONSTRAINT', 'un_theaterName'
GO

-- ----------------------------
--  Triggers structure for table Theaters
-- ----------------------------
CREATE TRIGGER [dbo].[tr_adminLevel] ON [dbo].[Theaters]
WITH EXECUTE AS CALLER
AFTER INSERT, UPDATE
AS
DECLARE @adminID INT
SELECT @adminID = theaterAdminId FROM inserted
DECLARE @adminLevel nvarchar(15)
SELECT @adminLevel = dbo.Users.userLevel FROM dbo.Users WHERE Users.Id = @adminId
IF(@adminLevel <> N'剧院经理')
	ROLLBACK TRANSACTION --回滚
GO
DISABLE TRIGGER [dbo].[tr_adminLevel] ON [Theaters]
GO
CREATE TRIGGER [dbo].[tr_initSeats] ON [dbo].[Theaters]
WITH EXECUTE AS CALLER
AFTER INSERT
AS
DECLARE @rowCount INT , @colCount INT , @curRowCount INT = 1 , @curColCount INT = 1 , @curCount INT = 1 , @theaterId INT 
SELECT @rowCount = seatRowCount, @colCount = seatColCount , @theaterId = Id FROM INSERTED
WHILE(@curCount < @rowCount * @colCount)
BEGIN
	IF(@curColCount >= @colCount)
	BEGIN
		SET	@curColCount = 1
		SET @curRowCount = @curRowCount + 1
	END
	ELSE
		SET @curColCount = @curColCount + 1
	
	EXEC sp_CreateSeat @theaterId , @curRowCount , @curColCount , 'NULL'
	SET @curCount = @curCount + 1
END
GO
CREATE TRIGGER [dbo].[tr_dropChild] ON [dbo].[Theaters]
WITH EXECUTE AS CALLER
INSTEAD OF DELETE
AS
DELETE Goods WHERE Goods.theaterID = (SELECT Id FROM DELETED)
DELETE Seats WHERE Seats.theaterID = (SELECT Id FROM DELETED)
DELETE Theaters WHERE Id = (SELECT Id FROM DELETED) 
GO
EXEC sp_addextendedproperty 'MS_Description', N'当添加或者修改后管理员职位不是 剧院经理  则不能添加或者修改', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'TRIGGER', 'tr_adminLevel'
GO
EXEC sp_addextendedproperty 'MS_Description', N'新建放映厅的时候初始化作为列表', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'TRIGGER', 'tr_initSeats'
GO
EXEC sp_addextendedproperty 'MS_Description', N'删除放映厅的时候删除座位', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'TRIGGER', 'tr_dropChild'
GO

-- ----------------------------
--  Primary key structure for table Tickets
-- ----------------------------
ALTER TABLE [dbo].[Tickets] ADD
	CONSTRAINT [PK__Ticket__3214EC074E8B6DD7] PRIMARY KEY CLUSTERED ([Id]) 
	WITH (PAD_INDEX = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON)
GO

-- ----------------------------
--  Checks structure for table Tickets
-- ----------------------------
ALTER TABLE [dbo].[Tickets] ADD
	CONSTRAINT [ticket_ticketstatus] CHECK ([status]=(2) OR [status]=(1) OR [status]=(0))
GO

-- ----------------------------
--  Indexes structure for table Tickets
-- ----------------------------
CREATE NONCLUSTERED INDEX [index_goodId]
ON [dbo].[Tickets] ([goodID] ASC)
WITH (PAD_INDEX = OFF,
	IGNORE_DUP_KEY = OFF,
	STATISTICS_NORECOMPUTE = OFF,
	SORT_IN_TEMPDB = OFF,
	ONLINE = OFF,
	ALLOW_ROW_LOCKS = ON,
	ALLOW_PAGE_LOCKS = ON)
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目id作为索引', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'INDEX', 'index_goodId'
GO

-- ----------------------------
--  Primary key structure for table UserIPs
-- ----------------------------
ALTER TABLE [dbo].[UserIPs] ADD
	CONSTRAINT [PK__UserIPs__3213E823C7EECE27] PRIMARY KEY CLUSTERED ([ip]) 
	WITH (PAD_INDEX = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON)
GO

-- ----------------------------
--  Primary key structure for table Users
-- ----------------------------
ALTER TABLE [dbo].[Users] ADD
	CONSTRAINT [PK__Users__3214EC079FB77262] PRIMARY KEY CLUSTERED ([Id]) 
	WITH (PAD_INDEX = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON)
GO

-- ----------------------------
--  Checks structure for table Users
-- ----------------------------
ALTER TABLE [dbo].[Users] ADD
	CONSTRAINT [CK__Users__userLevel__625A9A57] CHECK ([userLevel]=N'售票员' OR [userLevel]=N'剧院经理' OR [userLevel]=N'系统管理员'),
	CONSTRAINT [CK__Users__userSex__634EBE90] CHECK ([userSex]=N'女' OR [userSex]=N'男')
GO

-- ----------------------------
--  Foreign keys structure for table Goods
-- ----------------------------
ALTER TABLE [dbo].[Goods] ADD
	CONSTRAINT [goods_theaterId] FOREIGN KEY ([theaterID]) REFERENCES [dbo].[Theaters] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION,
	CONSTRAINT [goods_proId] FOREIGN KEY ([proID]) REFERENCES [dbo].[Programmes] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧院外键', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'CONSTRAINT', 'goods_theaterId'
GO
EXEC sp_addextendedproperty 'MS_Description', N'节目外键', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'CONSTRAINT', 'goods_proId'
GO

-- ----------------------------
--  Foreign keys structure for table Orders
-- ----------------------------
ALTER TABLE [dbo].[Orders] ADD
	CONSTRAINT [order_userID] FOREIGN KEY ([userID]) REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION,
	CONSTRAINT [order_ticketID] FOREIGN KEY ([ticketID]) REFERENCES [dbo].[Tickets] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
EXEC sp_addextendedproperty 'MS_Description', N'用户ID作为外键', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'CONSTRAINT', 'order_userID'
GO
EXEC sp_addextendedproperty 'MS_Description', N'票ID作为外键', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'CONSTRAINT', 'order_ticketID'
GO

-- ----------------------------
--  Foreign keys structure for table Seats
-- ----------------------------
ALTER TABLE [dbo].[Seats] ADD
	CONSTRAINT [theaterID] FOREIGN KEY ([theaterID]) REFERENCES [dbo].[Theaters] ([Id]) ON DELETE NO ACTION ON UPDATE CASCADE
GO
EXEC sp_addextendedproperty 'MS_Description', N'放映厅ID作为外键', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'CONSTRAINT', 'theaterID'
GO

-- ----------------------------
--  Foreign keys structure for table Theaters
-- ----------------------------
ALTER TABLE [dbo].[Theaters] ADD
	CONSTRAINT [theaterAdminID] FOREIGN KEY ([theaterAdminID]) REFERENCES [dbo].[Users] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO
EXEC sp_addextendedproperty 'MS_Description', N'放映厅管理者', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'CONSTRAINT', 'theaterAdminID'
GO

-- ----------------------------
--  Foreign keys structure for table Tickets
-- ----------------------------
ALTER TABLE [dbo].[Tickets] ADD
	CONSTRAINT [tic_seatId] FOREIGN KEY ([seatID]) REFERENCES [dbo].[Seats] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION,
	CONSTRAINT [tic_goodId] FOREIGN KEY ([goodID]) REFERENCES [dbo].[Goods] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO
EXEC sp_addextendedproperty 'MS_Description', N'使用座位ID来作为外键', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'CONSTRAINT', 'tic_seatId'
GO

-- ----------------------------
--  Options for table Goods
-- ----------------------------
ALTER TABLE [dbo].[Goods] SET (LOCK_ESCALATION = TABLE)
GO
DBCC CHECKIDENT ('[dbo].[Goods]', RESEED, 1)
GO

-- ----------------------------
--  Options for table Orders
-- ----------------------------
ALTER TABLE [dbo].[Orders] SET (LOCK_ESCALATION = TABLE)
GO
DBCC CHECKIDENT ('[dbo].[Orders]', RESEED, 1)
GO

-- ----------------------------
--  Options for table Programmes
-- ----------------------------
ALTER TABLE [dbo].[Programmes] SET (LOCK_ESCALATION = TABLE)
GO
DBCC CHECKIDENT ('[dbo].[Programmes]', RESEED, 8)
GO

-- ----------------------------
--  Options for table Seats
-- ----------------------------
ALTER TABLE [dbo].[Seats] SET (LOCK_ESCALATION = TABLE)
GO
DBCC CHECKIDENT ('[dbo].[Seats]', RESEED, 310)
GO

-- ----------------------------
--  Options for table Theaters
-- ----------------------------
ALTER TABLE [dbo].[Theaters] SET (LOCK_ESCALATION = TABLE)
GO
DBCC CHECKIDENT ('[dbo].[Theaters]', RESEED, 7)
GO

-- ----------------------------
--  Options for table Tickets
-- ----------------------------
ALTER TABLE [dbo].[Tickets] SET (LOCK_ESCALATION = TABLE)
GO
DBCC CHECKIDENT ('[dbo].[Tickets]', RESEED, 1)
GO

-- ----------------------------
--  Options for table UserIPs
-- ----------------------------
ALTER TABLE [dbo].[UserIPs] SET (LOCK_ESCALATION = TABLE)
GO

-- ----------------------------
--  Options for table Users
-- ----------------------------
ALTER TABLE [dbo].[Users] SET (LOCK_ESCALATION = TABLE)
GO
DBCC CHECKIDENT ('[dbo].[Users]', RESEED, 3)
GO

