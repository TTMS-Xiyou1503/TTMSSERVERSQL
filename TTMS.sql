create table TTMS.dbo.Users
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
	userTel nvarchar(12),
	theaterId int default (-1) not null,
	userAvatar varbinary(900) default NULL
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
execute sp_addextendedproperty N'MS_Description', N'用户电话', N'SCHEMA', @sn, N'TABLE', N'Users', N'COLUMN', N'userTel'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'用户所在影厅', N'SCHEMA', @sn, N'TABLE', N'Users', N'COLUMN', N'theaterId'
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
	theaterAdminID int default (-1)
		constraint FK_Theaters_Users
			references Users,
	seatRowCount int default 0 not null,
	seatColCount int default 0 not null
)
go

CREATE TRIGGER [dbo].[tr_initSeats] ON [dbo].[Theaters]
WITH EXECUTE AS CALLER
AFTER INSERT
AS
DECLARE @rowCount INT , @colCount INT , @curRowCount INT = 1 , @curColCount INT = 0 , @curCount INT = 1 , @theaterId INT
SELECT @rowCount = seatRowCount, @colCount = seatColCount , @theaterId = Id FROM INSERTED
WHILE(@curCount <= @rowCount * @colCount)
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
	theaterID int not null,
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

CREATE TRIGGER tr_DeleteProgramme
  ON Programmes
INSTEAD OF DELETE
AS
  BEGIN
    DECLARE @proId INT
    SET @proId = (SELECT Id
                  FROM deleted)
    DELETE Goods
    WHERE @proId = Goods.proID
    DELETE PlayBills
    WHERE @proId = PlayBills.programmeId
    DELETE Programmes
    WHERE @proId = Id
  END
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
	status int default 0 not null
		constraint ticket_ticketstatus
			check ([status]=2 OR [status]=1 OR [status]=0),
	seatID int not null
		constraint tic_seatId
			references Seats,
	goodID int not null,
	time datetime default (1970-1)-1 not null
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

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'时间戳，用作并发操作', N'SCHEMA', @sn, N'TABLE', N'Tickets', N'COLUMN', N'time'
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

CREATE TRIGGER tr_initTicket
ON TTMS.dbo.Goods
AFTER INSERT
AS
BEGIN
  DECLARE @goodId INT

  DECLARE @seatId INT

  DECLARE @status INT

  DECLARE @theaterId INT

  SET @goodId = (SELECT inserted.Id
                 FROM INSERTED)

  SET @theaterId = (SELECT theaterID
                    FROM Goods
                    WHERE Goods.Id = @goodId)

  DECLARE cur_seat CURSOR LOCAL READ_ONLY FORWARD_ONLY DYNAMIC FOR
    SELECT Id , status
    FROM TTMS.dbo.Seats
    WHERE theaterID = @theaterId --万恶之源游标
  OPEN cur_seat

  FETCH NEXT FROM cur_seat
      INTO @seatId , @status

  WHILE @@FETCH_STATUS = 0
    BEGIN

      IF (@status = 0)
        INSERT INTO Tickets (status, seatID, goodID) VALUES (2, @seatId, @goodId)
      IF (@status = 1)
        INSERT INTO Tickets (status, seatID, goodID) VALUES (1, @seatId, @goodId)

      FETCH NEXT FROM cur_seat
      INTO @seatId , @status

    END

  CLOSE cur_seat
  DEALLOCATE cur_seat
END
go

CREATE TRIGGER tr_dropTicket ON Goods
  AFTER DELETE
  AS
  DELETE Tickets WHERE goodID IN (SELECT Id FROM deleted)
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

create table TTMS.dbo.session
(
	Id nvarchar(900) not null
		primary key,
	Value varbinary not null,
	ExpiresAtTime datetimeoffset not null,
	SlidingExpirationInSeconds bigint,
	AbsoluteExpiration datetimeoffset
)
go

create unique index session_Id_uindex
	on session (Id)
go

create table TTMS.dbo.PlayBills
(
	Id int identity
		primary key,
	programmeId int not null
		constraint PlayBills_Programme__fk
			references Programmes,
	imagePath varchar(100) default 'https://image.baidu.com' not null
)
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'图片ID', N'SCHEMA', @sn, N'TABLE', N'PlayBills', N'COLUMN', N'Id'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'图片类型', N'SCHEMA', @sn, N'TABLE', N'PlayBills', N'COLUMN', N'programmeId'
go

declare @sn nvarchar(30)
set @sn = schema_name()
execute sp_addextendedproperty N'MS_Description', N'图片位置', N'SCHEMA', @sn, N'TABLE', N'PlayBills', N'COLUMN', N'imagePath'
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
		UPDATE users SET userTel = @newTel WHERE Id = @userId
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
  @theaterName   NVARCHAR(30),
  @location      NVARCHAR(30),
  @mapSite       NVARCHAR(30),
  @seatRowsCount INT,
  @seatColsCount INT,
  @message       VARCHAR(30) OUTPUT
AS

IF NOT EXISTS(SELECT 1
              FROM dbo.Theaters
              WHERE Theaters.theaterName = @theaterName)
  BEGIN
    INSERT INTO dbo.Theaters (
      theaterName,
      theaterLocation,
      theaterMapSite,
      seatRowCount,
      seatColCount
    )
    VALUES (
      @theaterName, @location, @mapSite, @seatRowsCount, @seatColsCount
    )
    SET @message = 'successful'
    RETURN 200
  END
ELSE
  BEGIN
    SET @message = 'the theater is exists'
    RETURN 400
  END
go

CREATE PROCEDURE [dbo].[sp_DeleteUser]
    @userId  INT,
    @message VARCHAR(30) OUTPUT
AS
  IF exists(SELECT 1
            FROM Users
            WHERE Id = @userId)
    BEGIN
      BEGIN TRY
      DELETE Users
      WHERE Id = @userId
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
      SET @message = 'the user is not exists'
      RETURN 404
    END
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
  @name    NVARCHAR(30), @account NVARCHAR(15), @password NVARCHAR(15),
  @level   NVARCHAR(10), @sex NVARCHAR(10), @tel NVARCHAR(12), @theaterId INT,
  @message VARCHAR(30) OUTPUT
AS
IF EXISTS(SELECT 1
          FROM Theaters
          WHERE @theaterId = Id) OR @theaterId = -1
  BEGIN
    IF NOT exists(SELECT 1
                  FROM Users
                  WHERE userAccount = @account)
      BEGIN
        BEGIN TRY
        INSERT INTO Users VALUES
          (@name, @account, @password, getdate(), getdate(), @level, @sex, @tel, @theaterId , NULL);
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
        SET @message = 'the user is exists'
        RETURN 400
      END
  END
ELSE
  BEGIN
    SET @message = 'the theater is not exists'
    RETURN 404
  END
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
    @seatId  INT,
    @message VARCHAR(30) OUTPUT
AS
  BEGIN TRY
  SELECT *
  FROM Seats
  WHERE @SeatId = Id
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
			(@proName , @duration , @tags , @profile) --插入剧目

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
    @theaterId   INT = NULL,
    @programmeId INT = NULL,
    @playDate    DATE = NULL,
    @performance NVARCHAR(10) = NULL,
    @message     VARCHAR(30) OUTPUT
AS
  BEGIN TRY
  SELECT *
  FROM Goods
  WHERE ((@theaterId IS NULL OR @theaterId = 0) OR theaterID = @theaterId)
        AND ((@programmeId IS NULL  OR @programmeId = 0) OR proID = @programmeId)
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

CREATE PROC sp_SellTicket
    @ticketId INT,
    @message  VARCHAR(30) OUTPUT
AS
  BEGIN TRY
    IF EXISTS(SELECT 1
            FROM Tickets
            WHERE @ticketId = Id)
    BEGIN
      DECLARE @time DATETIME, @status INT
      SELECT
        @time = time,
        @status = status
      FROM Tickets
      WHERE @ticketId = Id

      -- 判断当行中时间和现在时间差值超过15m ，则此票可用
      IF (DATEADD(MM, 15, @time) < GETDATE() AND @status = 1)
        BEGIN
          UPDATE Tickets --修改时间戳
          SET time = GETDATE()
          WHERE @ticketId = Id;
          SET @message = 'successful'
          RETURN 200
        END
      ELSE
        BEGIN
          SET @message = 'the ticket is sold'
          RETURN 401
        END
    END
  ELSE
    BEGIN
      SET @message = 'the ticket is not exists'
      RETURN 200
    END
  END TRY
  BEGIN CATCH
    SET @message = ERROR_MESSAGE()
    RETURN ERROR_NUMBER()
  END CATCH
go

CREATE PROC sp_QueryTicket
  @ticketId INT,
  @message  VARCHAR(30) OUTPUT
AS
BEGIN TRY
DECLARE @time DATETIME, @status INT
SELECT
  @time = time,
  @status = status
FROM Tickets
WHERE @ticketId = Id

-- 判断当行中时间和现在时间差值超过13m ，则此票可用
IF (DATEADD(MM, 15, @time) < GETDATE() AND @status = 1)
  BEGIN
    SET @status = 1
  END
ELSE
  BEGIN
    SET @status = 0
  END
SELECT
    Name = Programmes.proName,
    Duration = Programmes.duration,
    Tags = Programmes.tags,
    Profile = Programmes.profile,
    Performance = performance,
    Date = playdate,
    Price = price,
    TheaterName = theaterName,
    SeatRowNumber = rowNumber,
    SeatColNumber = colNumber,
    Status = @status
FROM Tickets
  JOIN Goods ON Tickets.goodID = Goods.Id
  JOIN Programmes ON Goods.proID = Programmes.Id
  JOIN Seats ON Tickets.seatID = Seats.Id
  JOIN Theaters ON Goods.theaterID = Theaters.Id
WHERE @ticketId = Tickets.Id
SET @message = 'successful'
RETURN 200
END TRY
BEGIN CATCH
SET @message = error_message()
RETURN ERROR_NUMBER()
END CATCH
go

CREATE PROC sp_SelectTicket
  @goodId  INT,
  @message VARCHAR(30) OUTPUT
AS
BEGIN TRY
SELECT
    Name = Programmes.proName,
    Duration = Programmes.duration,
    Tags = Programmes.tags,
    Profile = Programmes.profile,
    Performance = performance,
    Date = playdate,
    Price = price,
    TheaterName = theaterName,
    SeatRowNumber = rowNumber,
    SeatColNumber = colNumber,
    Status =
           CASE
           WHEN Tickets.status = 2
             THEN 2
           WHEN DATEADD(MINUTE, 15, Tickets.time) < GETDATE() AND Tickets.status = 1
             THEN 1
           ELSE 0 END ,
    Id = Tickets.Id
FROM Tickets
  JOIN Goods ON Tickets.goodID = Goods.Id
  JOIN Programmes ON Goods.proID = Programmes.Id
  JOIN Seats ON Tickets.seatID = Seats.Id
  JOIN Theaters ON Goods.theaterID = Theaters.Id
WHERE @goodId = goodID
SET @message = 'successful'
RETURN 200
END TRY
BEGIN CATCH
SET @message = error_message()
RETURN ERROR_NUMBER()
END CATCH
go

CREATE PROC sp_ReturnedTicket
    @ticketId INT,
    @userId   INT,
    @message  VARCHAR(30) OUTPUT
AS
  IF EXISTS(SELECT 1
            FROM Tickets
            WHERE @ticketId = Id)
    BEGIN
      DECLARE @status INT = 1
      SET @status = (SELECT status
                     FROM Tickets
                     WHERE @ticketId = Id)
      DECLARE @theaterId INT
      SET @theaterId = (SELECT theaterID
                        FROM Tickets
                          JOIN Goods ON Tickets.goodID = Goods.Id
                        WHERE @ticketId = Tickets.Id)
      IF (@status = 1)
        BEGIN
          SET @message = 'the ticket is ready to sell'
          RETURN 400 --请求错误 , 因为票状态为已售
        END
      ELSE
        BEGIN
          UPDATE Tickets
          SET status = 1
          WHERE @ticketId = Id --更改票状态

          INSERT INTO Orders (ticketID, userID, type, time, theaterID)  --插入一条交易记录
          VALUES (@ticketId, @userId, 0 , GETDATE(), @theaterID);

          SET @message = 'successful'
          RETURN 200
        END
    END
  ELSE
    BEGIN
      SET @message = 'the ticket is not exists'
      RETURN 200
    END
go

CREATE PROC sp_GetAllOrder
    @message VARCHAR(30) OUTPUT
AS
  BEGIN TRY 
    SELECT * FROM Orders
    SET @message = 'successful'
    RETURN 200
  END TRY
  BEGIN CATCH
    SET @message = ERROR_MESSAGE()
    RETURN ERROR_NUMBER()
  END CATCH
go

CREATE PROC sp_SelectOrder
    @theaterId INT = NULL,
    @userId    INT = NULL,
    @playDate  DATE = NULL,
    @type      INT = NULL,
    @message   VARCHAR(30) OUTPUT
AS
  BEGIN TRY
  SELECT *
  FROM Orders
    JOIN Tickets ON Orders.ticketID = Tickets.Id
    JOIN Goods ON Tickets.goodID = Goods.Id
  WHERE ((@theaterId IS NULL OR @theaterId = 0) OR @theaterId = Orders.theaterID)
        AND ((@userId IS NULL OR @userId = 0) OR @userId  = userID)
        AND (@playDate IS NULL OR @playDate = playdate)
        AND (@type IS NULL OR @type = type)
  SET @message = 'successful'
  RETURN 200
  END TRY
  BEGIN CATCH
  SET @message = ERROR_MESSAGE()
  RETURN ERROR_NUMBER()
  END CATCH
go

CREATE PROC sp_CreatePlayBill
  @programmeId INT ,
  @imagePath VARCHAR(100) , 
  @message VARCHAR(30) OUTPUT 
  AS
IF EXISTS(SELECT 1 FROM Programmes WHERE @programmeId = Id)
BEGIN
  BEGIN TRY 
    INSERT INTO PlayBills (programmeId, imagePath) VALUES (@programmeId , @imagePath)
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
  SET @message = 'the programme is not exists'
  RETURN 404
END
go

CREATE PROC sp_SelectPlayBill
    @programmeId INT,
    @message     VARCHAR(30) OUTPUT
AS
  IF EXISTS(SELECT 1
            FROM Programmes
            WHERE @programmeId = Id)
    BEGIN
      BEGIN TRY
      SELECT imagePath
      FROM PlayBills
      WHERE @programmeId = programmeId
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
      SET @message = 'the programme is not exists'
      RETURN 404
    END
go

CREATE PROC sp_DeletePlayBill
    @programmeId INT,
    @message VARCHAR(30) OUTPUT
AS
  IF EXISTS(SELECT 1 FROM Programmes WHERE @programmeId = Id)
BEGIN
  BEGIN TRY
    DELETE PlayBills WHERE programmeId = @programmeId
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
  SET @message = 'the programme is not exists'
  RETURN 404
END
go

CREATE PROC sp_GetAllTags
  @message VARCHAR(30) OUTPUT
  AS
  BEGIN TRY
	SELECT DISTINCT tags
	FROM Programmes
	SET @message = 'successful'
	RETURN 200 --
END TRY
BEGIN CATCH
	SET @message = ERROR_MESSAGE()
	RETURN ERROR_NUMBER()
END CATCH
go

CREATE PROC sp_PayTicket
    @ticketId INT,
    @userId   INT,
    @message  VARCHAR(30) OUTPUT
AS
  BEGIN TRY
    IF EXISTS(SELECT 1
            FROM Tickets
            WHERE @ticketId = Id)
    BEGIN
      DECLARE @time DATETIME, @status INT
      SELECT
        @time = time,
        @status = status
      FROM Tickets
      WHERE @ticketId = Id

      -- 判断当票修改时间和现在时间差值超过15m 或者 票已经被付款  ，则超时
      IF (DATEADD(MM, 15, @time) < GETDATE())
        BEGIN
          SET @message = 'time out'
          RETURN 401
        END
      IF (@status = 0)
        BEGIN
          SET @message = 'the ticket is sold'
          RETURN 401
        END
      DECLARE @theaterId INT
      SET @theaterId = (SELECT theaterID
                        FROM Tickets
                          JOIN Goods ON Tickets.goodID = Goods.Id
                        WHERE @ticketId = Tickets.Id)

      UPDATE Tickets
      SET status = 0
      WHERE @ticketId = Id --更改票状态

      INSERT INTO Orders (ticketID, userID, type, time, theaterID)  --插入一条交易记录

      VALUES (@ticketId, @userId, 1, GETDATE(), @theaterID);

      SET @message = 'successful'
      RETURN 200
    END
  END TRY
  BEGIN CATCH
    SET @message = ERROR_MESSAGE()
    RETURN ERROR_NUMBER()
  END CATCH
go

CREATE PROCEDURE [dbo].[sp_SelectSeat]
    @theaterId INT,
    @message   VARCHAR(30) OUTPUT
AS
  BEGIN TRY
  IF EXISTS(SELECT 1
            FROM Theaters
            WHERE @theaterId = Id)
    BEGIN
      SELECT *
      FROM Seats
      WHERE @theaterId = theaterID
      SET @message = 'successful'
      RETURN 200
    END
  ELSE
    BEGIN
      SET @message = 'the theater is not exists'
      RETURN 404
    END
  END TRY
  BEGIN CATCH
  SET @message = ERROR_MESSAGE()
  RETURN ERROR_NUMBER()
  END CATCH
go

CREATE PROCEDURE [dbo].[sp_SelectUser]
    @theaterId INT,
    @message   VARCHAR(30) OUTPUT
AS
  BEGIN TRY
  IF EXISTS(SELECT 1
            FROM Theaters
            WHERE Id = @theaterId)
    BEGIN
      SELECT *
      FROM Users
      WHERE @theaterId = theaterId
      SET @message = 'successful'
      RETURN 200
    END
  ELSE
    BEGIN
      SET @message = 'the theater is not exists'
      RETURN 404
    END
  END TRY
  BEGIN CATCH
  SET @message = ERROR_MESSAGE()
  RETURN ERROR_NUMBER()
  END CATCH
go


