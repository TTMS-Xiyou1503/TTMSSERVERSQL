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

 Date: 05/18/2017 20:17:26 PM
*/

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
--  Table structure for Repertoires
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[Repertoires]') AND type IN ('U'))
	DROP TABLE [dbo].[Repertoires]
GO
CREATE TABLE [dbo].[Repertoires] (
	[Id] int IDENTITY(1,1) NOT NULL,
	[repName] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL DEFAULT (N'未知'),
	[theaterID] int NOT NULL,
	[duration] int NOT NULL,
	[tags] nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL,
	[profile] text COLLATE Chinese_PRC_CI_AS NULL DEFAULT (N'无简介'),
	[startTime] datetime NOT NULL,
	[endTime] datetime NOT NULL
)
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目表', 'SCHEMA', 'dbo', 'TABLE', 'Repertoires'
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目ID', 'SCHEMA', 'dbo', 'TABLE', 'Repertoires', 'COLUMN', 'Id'
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目名称', 'SCHEMA', 'dbo', 'TABLE', 'Repertoires', 'COLUMN', 'repName'
GO
EXEC sp_addextendedproperty 'MS_Description', N'此剧目在哪个影厅上映', 'SCHEMA', 'dbo', 'TABLE', 'Repertoires', 'COLUMN', 'theaterID'
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目时长(分钟)', 'SCHEMA', 'dbo', 'TABLE', 'Repertoires', 'COLUMN', 'duration'
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目标签', 'SCHEMA', 'dbo', 'TABLE', 'Repertoires', 'COLUMN', 'tags'
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目简介', 'SCHEMA', 'dbo', 'TABLE', 'Repertoires', 'COLUMN', 'profile'
GO
EXEC sp_addextendedproperty 'MS_Description', N'开始放映时间', 'SCHEMA', 'dbo', 'TABLE', 'Repertoires', 'COLUMN', 'startTime'
GO
EXEC sp_addextendedproperty 'MS_Description', N'放映结束时间', 'SCHEMA', 'dbo', 'TABLE', 'Repertoires', 'COLUMN', 'endTime'
GO

-- ----------------------------
--  Records of Repertoires
-- ----------------------------
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [dbo].[Repertoires] ON
GO
INSERT INTO [dbo].[Repertoires] ([Id], [repName], [theaterID], [duration], [tags], [profile], [startTime], [endTime]) VALUES ('7', N'一只狗的使命', '2', '120', N'宠物', N'一只狗的使命', '2017-05-23 12:38:00.000', '2017-05-23 14:18:00.000');
GO
SET IDENTITY_INSERT [dbo].[Repertoires] OFF
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
	[Id] int IDENTITY(1,1) NOT NULL,
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
	[theaterAdminID] int NOT NULL DEFAULT ((1)),
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
	[repID] int NOT NULL,
	[price] money NOT NULL,
	[status] int NOT NULL DEFAULT ((0)),
	[seatID] int NOT NULL
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
INSERT INTO [dbo].[UserIPs] VALUES ('0.0.0.1', '443');
INSERT INTO [dbo].[UserIPs] VALUES ('111.20.21.85', '500');
INSERT INTO [dbo].[UserIPs] VALUES ('115.239.212.132', '500');
INSERT INTO [dbo].[UserIPs] VALUES ('117.32.216.111', '500');
INSERT INTO [dbo].[UserIPs] VALUES ('117.32.216.41', '500');
INSERT INTO [dbo].[UserIPs] VALUES ('117.32.216.63', '499');
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
INSERT INTO [dbo].[Users] ([Id], [userName], [userAccount], [userPassword], [signUpTime], [lastSigninTime], [userLevel], [userSex], [userAvatar], [userTel]) VALUES ('2', N'杨帆', 'yangfan', '123456', '2017-05-04 22:47:29.570', '2017-05-04 22:47:49.380', N'剧院经理', N'男', null, '18829076013');
INSERT INTO [dbo].[Users] ([Id], [userName], [userAccount], [userPassword], [signUpTime], [lastSigninTime], [userLevel], [userSex], [userAvatar], [userTel]) VALUES ('3', N'杨帆', 'ksgin', 'yf123456', '2017-05-09 17:06:16.247', '2017-05-09 17:06:16.247', N'系统管理员', N'男', null, '18628561591');
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
COMMIT
GO

-- ----------------------------
--  Procedure structure for sp_UpdateUserLevel
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_UpdateUserLevel]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_UpdateUserLevel]
GO
CREATE PROCEDURE [dbo].[sp_UpdateUserLevel] 
	@account nvarchar(15) , @newLevel nvarchar(15),
	@message varchar(30) OUTPUT
AS
IF EXISTS(SELECT 1 FROM users WHERE userAccount = @account)
BEGIN
	UPDATE users SET userLevel = @newLevel WHERE userAccount = @account 
	set @message = 'update successful'
	return 200
end
else
BEGIN
	set @message = 'the user is not exists'
	return 404
END
GO
IF ((SELECT COUNT(*) FROM ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'PROCEDURE', 'sp_UpdateUserLevel', NULL, NULL)) > 0) EXEC sp_updateextendedproperty 'MS_Description', N'修改用户等级', 'schema', 'dbo', 'PROCEDURE', 'sp_UpdateUserLevel' ELSE EXEC sp_addextendedproperty 'MS_Description', N'修改用户等级', 'schema', 'dbo', 'PROCEDURE', 'sp_UpdateUserLevel'
GO

-- ----------------------------
--  Procedure structure for sp_UpdateUserTel
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_UpdateUserTel]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_UpdateUserTel]
GO
CREATE PROCEDURE [dbo].[sp_UpdateUserTel] 
	@account nvarchar(15),
	@newTel nvarchar(12),
	@message varchar(30)
AS
IF EXISTS(SELECT 1 FROM users where useraccount = @account)
begin
	UPDATE users set userTel = @newTel WHERE userAccount = @account
	set @message = 'update successful'
	return 200
end
else
BEGIN
	set @message = 'the user is not exists'
	return 404
END
GO

-- ----------------------------
--  Procedure structure for sp_CreateTheater
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_CreateTheater]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_CreateTheater]
GO
CREATE PROCEDURE [dbo].[sp_CreateTheater] 
	@name nvarchar(30), 
	@location nvarchar(30),
	@mapSite nvarchar(30),
	@adminId int,
	@seatRowsCount int,
	@seatColsCount int,
	@message varchar(30) OUTPUT
AS
IF EXISTS(SELECT 1 FROM dbo.Users WHERE Id = @adminId)
BEGIN
	IF NOT EXISTS(SELECT 1 FROM dbo.Theaters WHERE Theaters.theaterName = @name)
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
			@name , @location , @mapSite , @adminId , @seatRowsCount , @seatColsCount
		)
		SET @message = 'created successful'
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
--  Procedure structure for sp_UpdateTheaterAdminId
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_UpdateTheaterAdminId]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_UpdateTheaterAdminId]
GO
CREATE PROCEDURE [dbo].[sp_UpdateTheaterAdminId] 
	@name nvarchar(30), 
	@adminId int,
	@message varchar(30) OUTPUT
AS
IF EXISTS(SELECT 1 FROM dbo.Users WHERE Id = @adminId)
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Theaters WHERE Theaters.theaterName = @name)
	BEGIN
		UPDATE Theaters SET theaterAdminID = @adminId WHERE theaterName = @name
		SET @message = 'update successful'
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
	SET @message = 'the user  is not exists'
	RETURN 404
END
GO
IF ((SELECT COUNT(*) FROM ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'PROCEDURE', 'sp_UpdateTheaterAdminId', NULL, NULL)) > 0) EXEC sp_updateextendedproperty 'MS_Description', N'修改影厅管理者', 'schema', 'dbo', 'PROCEDURE', 'sp_UpdateTheaterAdminId' ELSE EXEC sp_addextendedproperty 'MS_Description', N'修改影厅管理者', 'schema', 'dbo', 'PROCEDURE', 'sp_UpdateTheaterAdminId'
GO

-- ----------------------------
--  Procedure structure for sp_DeleteUser
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_DeleteUser]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_DeleteUser]
GO
CREATE PROCEDURE [dbo].[sp_DeleteUser]   
@account nvarchar(15),
@message varchar(30) OUTPUT
as
if exists(select 1 from Users where userAccount = @account)
begin
	begin try
		DELETE Users WHERE userAccount = @account
		set @message = 'delete successful'
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
		set @message = 'login successful' 
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
--  Procedure structure for sp_GetUser
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_GetUser]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_GetUser]
GO
CREATE PROCEDURE [dbo].[sp_GetUser]   
@account nvarchar(15)
as
select userName , userAccount , userPassword , signUpTime , lastSigninTime , userLevel , userSex , userAvatar , userTel
from Users where userAccount = @account
GO

-- ----------------------------
--  Procedure structure for sp_UpdateUserPassword
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_UpdateUserPassword]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_UpdateUserPassword]
GO
CREATE PROCEDURE [dbo].[sp_UpdateUserPassword]  
@account nvarchar(18) , @newPassword nvarchar(18),
@message varchar(30) OUTPUT
AS
if EXISTS(select 1 from users where userAccount = @account)
begin
	update users set userPassword = @newPassword where userAccount = @account
	set @message = 'update successful'
	return 200
end
else
BEGIN
	set @message = 'the user is not exists'
	return 404
END
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
		set @message = 'create successful'
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
--  Procedure structure for sp_CreateRepertoires
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[sp_CreateRepertoires]') AND type IN ('P', 'PC', 'RF', 'X'))
	DROP PROCEDURE [dbo].[sp_CreateRepertoires]
GO
CREATE PROCEDURE [dbo].[sp_CreateRepertoires] 
@repName nvarchar(50) , @theaterID INT , @duration INT , @tags nvarchar(20) , @profile TEXT , @startTime datetime , @endTime datetime ,
@message nvarchar(30) OUTPUT
AS	
IF EXISTS(SELECT 1 FROM dbo.Theaters WHERE Theaters.Id = @theaterID)
BEGIN
	IF NOT EXISTS(SELECT 1 FROM dbo.Repertoires WHERE repName = @repName)
	BEGIN
		BEGIN TRY
			INSERT INTO Repertoires 
				(repName , theaterID , duration , tags , profile , startTime , endTime)
				VALUES(
				@repName , @theaterID , @duration , @tags , @profile , @startTime , @endTime
			)
		SET @message = 'created successful'
		RETURN 200
		END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE()
			RETURN ERROR_MESSAGE() --其他错误
		END CATCH
	END
	ELSE
	BEGIN 
		SET @message = 'the repertoires is exists'
		RETURN 400 --名称已存在
	END
END
ELSE
BEGIN
	SET @message = 'theater id is not exists'
	RETURN 404 --未找到
END
GO
IF ((SELECT COUNT(*) FROM ::fn_listextendedproperty('MS_Description', 'schema', 'dbo', 'PROCEDURE', 'sp_CreateRepertoires', NULL, NULL)) > 0) EXEC sp_updateextendedproperty 'MS_Description', N'增加一个新的剧目', 'schema', 'dbo', 'PROCEDURE', 'sp_CreateRepertoires' ELSE EXEC sp_addextendedproperty 'MS_Description', N'增加一个新的剧目', 'schema', 'dbo', 'PROCEDURE', 'sp_CreateRepertoires'
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
				SET @message = 'created successful'
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
--  Primary key structure for table Repertoires
-- ----------------------------
ALTER TABLE [dbo].[Repertoires] ADD
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
--  Indexes structure for table Seats
-- ----------------------------
CREATE NONCLUSTERED INDEX [theaterID]
ON [dbo].[Seats] ([theaterID] ASC)
WITH (PAD_INDEX = OFF,
	IGNORE_DUP_KEY = OFF,
	STATISTICS_NORECOMPUTE = OFF,
	SORT_IN_TEMPDB = OFF,
	ONLINE = OFF,
	ALLOW_ROW_LOCKS = ON,
	ALLOW_PAGE_LOCKS = ON)
GO
EXEC sp_addextendedproperty 'MS_Description', N'用放映厅ID作为索引', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'INDEX', 'theaterID'
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
EXEC sp_addextendedproperty 'MS_Description', N'当添加或者修改后管理员职位不是 剧院经理  则不能添加或者修改', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'TRIGGER', 'tr_adminLevel'
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
CREATE NONCLUSTERED INDEX [index_repid]
ON [dbo].[Tickets] ([repID] ASC)
WITH (PAD_INDEX = OFF,
	IGNORE_DUP_KEY = OFF,
	STATISTICS_NORECOMPUTE = OFF,
	SORT_IN_TEMPDB = OFF,
	ONLINE = OFF,
	ALLOW_ROW_LOCKS = ON,
	ALLOW_PAGE_LOCKS = ON)
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目id作为索引', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'INDEX', 'index_repid'
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
--  Foreign keys structure for table Orders
-- ----------------------------
ALTER TABLE [dbo].[Orders] ADD
	CONSTRAINT [order_userID] FOREIGN KEY ([userID]) REFERENCES [dbo].[Users] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT [order_theaterID] FOREIGN KEY ([theaterID]) REFERENCES [dbo].[Theaters] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT [order_ticketID] FOREIGN KEY ([ticketID]) REFERENCES [dbo].[Tickets] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
EXEC sp_addextendedproperty 'MS_Description', N'用户ID作为外键', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'CONSTRAINT', 'order_userID'
GO
EXEC sp_addextendedproperty 'MS_Description', N'放映厅ID作为外键', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'CONSTRAINT', 'order_theaterID'
GO
EXEC sp_addextendedproperty 'MS_Description', N'票ID作为外键', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'CONSTRAINT', 'order_ticketID'
GO

-- ----------------------------
--  Foreign keys structure for table Repertoires
-- ----------------------------
ALTER TABLE [dbo].[Repertoires] ADD
	CONSTRAINT [theaterIDRep] FOREIGN KEY ([theaterID]) REFERENCES [dbo].[Theaters] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- ----------------------------
--  Foreign keys structure for table Seats
-- ----------------------------
ALTER TABLE [dbo].[Seats] ADD
	CONSTRAINT [theaterID] FOREIGN KEY ([theaterID]) REFERENCES [dbo].[Theaters] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
EXEC sp_addextendedproperty 'MS_Description', N'放映厅ID作为外键', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'CONSTRAINT', 'theaterID'
GO

-- ----------------------------
--  Foreign keys structure for table Theaters
-- ----------------------------
ALTER TABLE [dbo].[Theaters] ADD
	CONSTRAINT [theaterAdminID] FOREIGN KEY ([theaterAdminID]) REFERENCES [dbo].[Users] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
EXEC sp_addextendedproperty 'MS_Description', N'放映厅管理者', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'CONSTRAINT', 'theaterAdminID'
GO

-- ----------------------------
--  Foreign keys structure for table Tickets
-- ----------------------------
ALTER TABLE [dbo].[Tickets] ADD
	CONSTRAINT [repIDticket] FOREIGN KEY ([repID]) REFERENCES [dbo].[Repertoires] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT [seatIDticket] FOREIGN KEY ([seatID]) REFERENCES [dbo].[Seats] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
EXEC sp_addextendedproperty 'MS_Description', N'剧目信息作为外键', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'CONSTRAINT', 'repIDticket'
GO
EXEC sp_addextendedproperty 'MS_Description', N'使用座位ID来作为外键', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'CONSTRAINT', 'seatIDticket'
GO

-- ----------------------------
--  Options for table Orders
-- ----------------------------
ALTER TABLE [dbo].[Orders] SET (LOCK_ESCALATION = TABLE)
GO
DBCC CHECKIDENT ('[dbo].[Orders]', RESEED, 1)
GO

-- ----------------------------
--  Options for table Repertoires
-- ----------------------------
ALTER TABLE [dbo].[Repertoires] SET (LOCK_ESCALATION = TABLE)
GO
DBCC CHECKIDENT ('[dbo].[Repertoires]', RESEED, 7)
GO

-- ----------------------------
--  Options for table Seats
-- ----------------------------
ALTER TABLE [dbo].[Seats] SET (LOCK_ESCALATION = TABLE)
GO
DBCC CHECKIDENT ('[dbo].[Seats]', RESEED, 23)
GO

-- ----------------------------
--  Options for table Theaters
-- ----------------------------
ALTER TABLE [dbo].[Theaters] SET (LOCK_ESCALATION = TABLE)
GO
DBCC CHECKIDENT ('[dbo].[Theaters]', RESEED, 1)
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

