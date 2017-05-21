CREATE TABLE Goods
(
    Id INT PRIMARY KEY NOT NULL IDENTITY,
    proID INT NOT NULL,
    theaterID INT NOT NULL,
    performance NVARCHAR(10) DEFAULT N'早一' NOT NULL,
    playdate DATE DEFAULT '1-1-2017' NOT NULL,
    price MONEY DEFAULT '0' NOT NULL,
    CONSTRAINT goods_proId FOREIGN KEY (proID) REFERENCES Programmes (Id),
    CONSTRAINT goods_theaterId FOREIGN KEY (theaterID) REFERENCES Theaters (Id)
);
CREATE TABLE Orders
(
    Id INT PRIMARY KEY NOT NULL IDENTITY,
    ticketID INT NOT NULL,
    userID INT NOT NULL,
    type INT DEFAULT 1 NOT NULL,
    time DATETIME DEFAULT getdate() NOT NULL,
    theaterID INT NOT NULL,
    CONSTRAINT order_ticketID FOREIGN KEY (ticketID) REFERENCES Tickets (Id),
    CONSTRAINT order_userID FOREIGN KEY (userID) REFERENCES Users (Id)
);
CREATE INDEX index_order ON Orders (userID, theaterID);
CREATE TABLE Programmes
(
    Id INT PRIMARY KEY NOT NULL IDENTITY,
    proName NVARCHAR(50) NOT NULL,
    duration INT NOT NULL,
    tags NVARCHAR(20),
    profile TEXT DEFAULT N'无简介'
);
CREATE TABLE Seats
(
    Id INT PRIMARY KEY NOT NULL IDENTITY,
    theaterID INT NOT NULL,
    status BIT DEFAULT 1 NOT NULL,
    rowNumber INT DEFAULT 1 NOT NULL,
    colNumber INT DEFAULT 1 NOT NULL,
    CONSTRAINT theaterID FOREIGN KEY (theaterID) REFERENCES Theaters (Id)
);
CREATE TABLE Theaters
(
    Id INT PRIMARY KEY NOT NULL IDENTITY,
    theaterName NVARCHAR(30) DEFAULT N'影厅' NOT NULL,
    theaterLocation NVARCHAR(30) DEFAULT N'中国' NOT NULL,
    theaterMapSite NVARCHAR(30) DEFAULT 'https://gaode.com',
    theaterAdminID INT,
    seatRowCount INT DEFAULT 0 NOT NULL,
    seatColCount INT DEFAULT 0 NOT NULL,
    CONSTRAINT theaterAdminID FOREIGN KEY (theaterAdminID) REFERENCES Users (Id)
);
CREATE UNIQUE INDEX un_theaterName ON Theaters (theaterName);
CREATE TABLE Tickets
(
    Id INT PRIMARY KEY NOT NULL IDENTITY,
    status INT DEFAULT 0 NOT NULL,
    seatID INT NOT NULL,
    goodID INT NOT NULL,
    CONSTRAINT tic_seatId FOREIGN KEY (seatID) REFERENCES Seats (Id),
    CONSTRAINT tic_goodId FOREIGN KEY (goodID) REFERENCES Goods (Id)
);
CREATE INDEX index_goodId ON Tickets (goodID);
CREATE TABLE UserIPs
(
    ip VARCHAR(20) PRIMARY KEY NOT NULL,
    limitTimes INT DEFAULT 500 NOT NULL
);
CREATE TABLE Users
(
    Id INT PRIMARY KEY NOT NULL IDENTITY,
    userName NVARCHAR(30) NOT NULL,
    userAccount NVARCHAR(15) NOT NULL,
    userPassword NVARCHAR(15) NOT NULL,
    signUpTime DATETIME NOT NULL,
    lastSigninTime DATETIME NOT NULL,
    userLevel NVARCHAR(15) NOT NULL,
    userSex NVARCHAR(10),
    userAvatar VARBINARY(4096),
    userTel NVARCHAR(12)
);
CREATE PROCEDURE sp_CreateGood(@programmeId INT, @theaterId INT, @performance SYSNAME, @playDate DATE, @price MONEY, @message VARCHAR);
CREATE PROCEDURE sp_CreateProgramme(@proName SYSNAME, @duration INT, @tags SYSNAME, @profile TEXT, @message SYSNAME);
CREATE PROCEDURE sp_CreateSeat(@theaterID INT, @rowNumber INT, @colNumber INT, @message VARCHAR);
CREATE PROCEDURE sp_CreateTheater(@theaterName SYSNAME, @location SYSNAME, @mapSite SYSNAME, @adminId INT, @seatRowsCount INT, @seatColsCount INT, @message VARCHAR);
CREATE PROCEDURE sp_CreateUser(@name SYSNAME, @account SYSNAME, @password SYSNAME, @level SYSNAME, @sex SYSNAME, @tel SYSNAME, @message VARCHAR);
CREATE PROCEDURE sp_DeleteGood(@goodId INT, @message VARCHAR);
CREATE PROCEDURE sp_DeleteProgramme(@programmeId INT, @message VARCHAR);
CREATE PROCEDURE sp_DeleteSeat(@seatId INT, @message VARCHAR);
CREATE PROCEDURE sp_DeleteTheater(@theaterId INT, @message VARCHAR);
CREATE PROCEDURE sp_DeleteUser(@userId INT, @message VARCHAR);
CREATE PROCEDURE sp_GetAllGood(@message VARCHAR);
CREATE PROCEDURE sp_GetAllProgramme(@message VARCHAR);
CREATE PROCEDURE sp_GetAllSeat(@message VARCHAR);
CREATE PROCEDURE sp_GetAllTheater(@message VARCHAR);
CREATE PROCEDURE sp_GetAllUser(@message VARCHAR);
CREATE PROCEDURE sp_GetTickets(@theaterId INT, @playDate DATE, @performance SYSNAME, @message VARCHAR);
CREATE PROCEDURE sp_Login(@account SYSNAME, @password SYSNAME, @message VARCHAR);
CREATE PROCEDURE sp_QueryGood(@goodId INT, @message VARCHAR);
CREATE PROCEDURE sp_QueryProgramme(@programmeName SYSNAME, @programmeId INT, @message VARCHAR);
CREATE PROCEDURE sp_QuerySeat(@theaterId INT, @rowNumber INT, @colNumber INT, @seatId INT, @message VARCHAR);
CREATE PROCEDURE sp_QueryTheater(@theaterName SYSNAME, @theaterId INT, @message VARCHAR);
CREATE PROCEDURE sp_QueryUser(@account SYSNAME, @userId INT, @message VARCHAR);
CREATE PROCEDURE sp_SelectGood(@theaterId INT, @programmeId INT, @playDate DATE, @performance SYSNAME, @message VARCHAR);
CREATE PROCEDURE sp_SelectProgramme(@tags SYSNAME, @message VARCHAR);
CREATE PROCEDURE sp_UpdateSeatStatus(@seatID INT, @status BIT, @message VARCHAR);
CREATE PROCEDURE sp_UpdateTheater(@theaterId INT, @newAdminId INT, @message VARCHAR);
CREATE PROCEDURE sp_UpdateUser(@userId INT, @newLevel SYSNAME, @newTel SYSNAME, @newPassword SYSNAME, @message VARCHAR);reate table TTMS.dbo.Users
(
	Id int identity
		primary key,
	userName nvarchar(30) not null,
	userAccount nvarchar(15) not null,
	userPassword nvarchar(15) not null,
	signUpTime datetime not null,
	lastSigninTime datetime not null,
	userLevel nvarchar(15) not null
		constraint CK__Users__userLevel__625A9A57
			check ([userLevel]=N'售票员' OR [userLevel]=N'剧院经理' OR [userLevel]=N'系统管理员'),
	userSex nvarchar(10)
		check ([userSex]=N'女' OR [userSex]=N'男'),
	userAvatar varbinary(4096),
	userTel nvarchar(12)
)
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'用户表', N'SCHEMA', @sn, N'TABLE', N'Users'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'用户ID', N'SCHEMA', @sn, N'TABLE', N'Users', N'COLUMN', N'Id'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'用户名称', N'SCHEMA', @sn, N'TABLE', N'Users', N'COLUMN', N'userName'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'用户账号', N'SCHEMA', @sn, N'TABLE', N'Users', N'COLUMN', N'userAccount'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'用户密码', N'SCHEMA', @sn, N'TABLE', N'Users', N'COLUMN', N'userPassword'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'注册时间', N'SCHEMA', @sn, N'TABLE', N'Users', N'COLUMN', N'signUpTime'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'最后一次登陆时间', N'SCHEMA', @sn, N'TABLE', N'Users', N'COLUMN', N'lastSigninTime'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'用户级别', N'SCHEMA', @sn, N'TABLE', N'Users', N'COLUMN', N'userLevel'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'用户性别', N'SCHEMA', @sn, N'TABLE', N'Users', N'COLUMN', N'userSex'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'用户头像', N'SCHEMA', @sn, N'TABLE', N'Users', N'COLUMN', N'userAvatar'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'用户电话', N'SCHEMA', @sn, N'TABLE', N'Users', N'COLUMN', N'userTel'
go

create table TTMS.dbo.Theaters
(
	Id int identity
		primary key,
	theaterName nvarchar(30) default N'影厅' not null
		constraint un_theaterName
			unique,
	theaterLocation nvarchar(30) default N'中国' not null,
	theaterMapSite nvarchar(30) default 'https://gaode.com',
	theaterAdminID int
		constraint theaterAdminID
			references Users,
	seatRowCount int default 0 not null,
	seatColCount int default 0 not null
)
go

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
go

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
go

CREATE TRIGGER [dbo].[tr_dropChild] ON [dbo].[Theaters]
WITH EXECUTE AS CALLER
INSTEAD OF DELETE
AS
DELETE Goods WHERE Goods.theaterID = (SELECT Id FROM DELETED)
DELETE Seats WHERE Seats.theaterID = (SELECT Id FROM DELETED)
DELETE Theaters WHERE Id = (SELECT Id FROM DELETED)
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'放映厅表', N'SCHEMA', @sn, N'TABLE', N'Theaters'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'放映厅ID', N'SCHEMA', @sn, N'TABLE', N'Theaters', N'COLUMN', N'Id'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'影厅名称', N'SCHEMA', @sn, N'TABLE', N'Theaters', N'COLUMN', N'theaterName'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'影厅位置', N'SCHEMA', @sn, N'TABLE', N'Theaters', N'COLUMN', N'theaterLocation'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'影厅在地图上的位置', N'SCHEMA', @sn, N'TABLE', N'Theaters', N'COLUMN', N'theaterMapSite'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'影厅管理者的ID', N'SCHEMA', @sn, N'TABLE', N'Theaters', N'COLUMN', N'theaterAdminID'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'影厅座位行个数', N'SCHEMA', @sn, N'TABLE', N'Theaters', N'COLUMN', N'seatRowCount'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'影厅座位列个数', N'SCHEMA', @sn, N'TABLE', N'Theaters', N'COLUMN', N'seatColCount'
go

create table TTMS.dbo.Seats
(
	Id int identity
		primary key,
	theaterID int not null
		constraint theaterID
			references Theaters,
	status bit default 1 not null
		constraint check_seatstatus
			check ([status]=0 OR [status]=1),
	rowNumber int default 1 not null
		constraint check_row
			check ([rowNumber]>=1),
	colNumber int default 1 not null
		constraint check_col
			check ([colNumber]>=1)
)
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'座位表
', N'SCHEMA', @sn, N'TABLE', N'Seats'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'座位ID', N'SCHEMA', @sn, N'TABLE', N'Seats', N'COLUMN', N'Id'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'放映厅ID', N'SCHEMA', @sn, N'TABLE', N'Seats', N'COLUMN', N'theaterID'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'座位状态', N'SCHEMA', @sn, N'TABLE', N'Seats', N'COLUMN', N'status'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'第n行', N'SCHEMA', @sn, N'TABLE', N'Seats', N'COLUMN', N'rowNumber'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'第n列', N'SCHEMA', @sn, N'TABLE', N'Seats', N'COLUMN', N'colNumber'
go

create table TTMS.dbo.Programmes
(
	Id int identity
		primary key,
	proName nvarchar(50) not null,
	duration int not null,
	tags nvarchar(20),
	profile text default N'无简介'
)
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'剧目表', N'SCHEMA', @sn, N'TABLE', N'Programmes'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'剧目ID', N'SCHEMA', @sn, N'TABLE', N'Programmes', N'COLUMN', N'Id'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'剧目名称', N'SCHEMA', @sn, N'TABLE', N'Programmes', N'COLUMN', N'proName'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'剧目时长(分钟)', N'SCHEMA', @sn, N'TABLE', N'Programmes', N'COLUMN', N'duration'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'剧目标签', N'SCHEMA', @sn, N'TABLE', N'Programmes', N'COLUMN', N'tags'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'剧目简介', N'SCHEMA', @sn, N'TABLE', N'Programmes', N'COLUMN', N'profile'
go

create table TTMS.dbo.Orders
(
	Id int identity
		constraint PK__Orders__3214EC071500447B
			primary key,
	ticketID int not null,
	userID int not null
		constraint order_userID
			references Users,
	type int default 1 not null
		constraint check_status
			check ([type]=(-1) OR [type]=1),
	time datetime default getdate() not null,
	theaterID int not null
)
go

create index index_order
	on Orders (userID, theaterID)
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'订单记录表', N'SCHEMA', @sn, N'TABLE', N'Orders'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'订单ID', N'SCHEMA', @sn, N'TABLE', N'Orders', N'COLUMN', N'Id'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'订单索引', N'SCHEMA', @sn, N'TABLE', N'Orders', N'COLUMN', N'ticketID'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'完成此订单用户ID', N'SCHEMA', @sn, N'TABLE', N'Orders', N'COLUMN', N'userID'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'订单类型', N'SCHEMA', @sn, N'TABLE', N'Orders', N'COLUMN', N'type'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'交易时间', N'SCHEMA', @sn, N'TABLE', N'Orders', N'COLUMN', N'time'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'完成此订单的放映厅ID', N'SCHEMA', @sn, N'TABLE', N'Orders', N'COLUMN', N'theaterID'
go

create table TTMS.dbo.Tickets
(
	Id int identity
		constraint PK__Ticket__3214EC074E8B6DD7
			primary key,
	price money not null,
	status int default 0 not null
		constraint ticket_ticketstatus
			check ([status]=2 OR [status]=1 OR [status]=0),
	seatID int not null
		constraint tic_seatId
			references Seats,
	goodID int not null
)
go

create index index_goodId
	on Tickets (goodID)
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'影票表', N'SCHEMA', @sn, N'TABLE', N'Tickets'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'票ID', N'SCHEMA', @sn, N'TABLE', N'Tickets', N'COLUMN', N'Id'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'票状态', N'SCHEMA', @sn, N'TABLE', N'Tickets', N'COLUMN', N'status'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'座位ID', N'SCHEMA', @sn, N'TABLE', N'Tickets', N'COLUMN', N'seatID'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'商品ID', N'SCHEMA', @sn, N'TABLE', N'Tickets', N'COLUMN', N'goodID'
go

alter table Orders
	add constraint order_ticketID
		foreign key (ticketID) references Tickets
go

create table TTMS.dbo.UserIPs
(
	ip varchar(20) not null
		constraint PK__UserIPs__3213E823C7EECE27
			primary key,
	limitTimes int default 500 not null
)
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'IP限制 ， 此表用于API的限制IP', N'SCHEMA', @sn, N'TABLE', N'UserIPs'
go

create table TTMS.dbo.Goods
(
	Id int identity
		primary key,
	proID int not null
		constraint goods_proId
			references Programmes,
	theaterID int not null
		constraint goods_theaterId
			references Theaters,
	performance nvarchar(10) default N'早一' not null,
	playdate date default '1-1-2017' not null,
	price money default '0' not null
)
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'商品表', N'SCHEMA', @sn, N'TABLE', N'Goods'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'商品ID', N'SCHEMA', @sn, N'TABLE', N'Goods', N'COLUMN', N'Id'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'剧目ID', N'SCHEMA', @sn, N'TABLE', N'Goods', N'COLUMN', N'proID'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'放映厅ID', N'SCHEMA', @sn, N'TABLE', N'Goods', N'COLUMN', N'theaterID'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'场次', N'SCHEMA', @sn, N'TABLE', N'Goods', N'COLUMN', N'performance'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'播放日期', N'SCHEMA', @sn, N'TABLE', N'Goods', N'COLUMN', N'playdate'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'价格', N'SCHEMA', @sn, N'TABLE', N'Goods', N'COLUMN', N'price'
go

alter table Tickets
	add constraint tic_goodId
		foreign key (goodID) references Goods
go

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
go

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

go

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
go

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
go

CREATE PROCEDURE [dbo].[sp_login] 
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
go

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
go

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
go

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
go

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
go

CREATE PROCEDURE [dbo].[sp_CreateGood]
	@programmeId INT , @theaterId INT , @performance nvarchar(10), @playDate DATE , @price MONEY ,
	@message VARCHAR(30) OUTPUT
AS
IF(@performance NOT IN (N'早一',N'早二',N'午一',N'午二',N'晚一',N'晚二',N'午夜'))
BEGIN
	SET @message = 'invalid performance'
	RETURN 400
END
ELSE
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Theaters WHERE Theaters.Id = @theaterID)
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.Programmes WHERE Programmes.Id = @programmeID)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM Goods WHERE @theaterId = theaterId AND @performance = performance AND @playDate = playDate)
			BEGIN
				BEGIN TRY
					INSERT INTO Goods (proId , theaterId , performance , playDate , price)
					VALUES
					(@programmeId , @theaterId , @performance , @playDate , @price)
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
				SET @message = 'the theater is busy'
				RETURN 400
			END
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
go

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
go

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
go

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
go

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
go

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
go

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
go

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
go

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
go

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
go

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
go

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
go

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

go

CREATE PROCEDURE [dbo].[sp_GetAllGood]
	@message varchar(30) OUTPUT
AS
BEGIN TRY
	SELECT *
	FROM Goods
	SET @message = 'successful'
	RETURN 200 --
END TRY
BEGIN CATCH
	SET @message = ERROR_MESSAGE()
	RETURN ERROR_NUMBER()
END CATCH
go

CREATE PROCEDURE [dbo].[sp_QueryGood]
	@goodId INT ,
	@message VARCHAR(30) OUTPUT
AS
BEGIN TRY
	SELECT * FROM Goods
	WHERE Id = @goodId
	SET @message = 'successful'
	RETURN 200 --
END TRY
BEGIN CATCH
	SET @message = ERROR_MESSAGE()
	RETURN ERROR_NUMBER()
END CATCH
go

CREATE PROCEDURE [dbo].[sp_SelectGood]
	@theaterId INT = NULL , 
	@programmeId INT = NULL , 
	@playDate DATE = NULL , 
	@performance NVARCHAR(10) = NULL ,
	@message VARCHAR(30) OUTPUT
AS
BEGIN TRY
	SELECT * FROM Goods
	WHERE (@theaterId IS NULL OR theaterID = @theaterId)
		AND (@programmeId IS NULL OR proID = @programmeId)
		AND (@playDate IS NULL OR playDate = @playDate)
		AND (@performance IS NULL OR performance = @performance)
	SET @message = 'successful'
	RETURN 200 --
END TRY
BEGIN CATCH
	SET @message = ERROR_MESSAGE()
	RETURN ERROR_NUMBER()
END CATCH
go

CREATE PROCEDURE [dbo].[sp_DeleteGood]
	@goodId INT , 
	@message VARCHAR(30) OUTPUT
AS
IF EXISTS(SELECT 1 FROM Goods WHERE Id = @goodId)
BEGIN
	BEGIN TRY
		DELETE Goods WHERE Id = @goodId
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
	SET @message = 'the good is not exists'
	RETURN 404
END
go


