-- we don't know how to generate database TTMS (class Database) :(
create table Users
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

exec sp_addextendedproperty 'MS_Description', '用户表', 'SCHEMA', 'dbo', 'TABLE', 'Users'
go

exec sp_addextendedproperty 'MS_Description', '用户ID', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '用户名称', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'userName'
go

exec sp_addextendedproperty 'MS_Description', '用户账号', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'userAccount'
go

exec sp_addextendedproperty 'MS_Description', '用户密码', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'userPassword'
go

exec sp_addextendedproperty 'MS_Description', '注册时间', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'signUpTime'
go

exec sp_addextendedproperty 'MS_Description', '最后一次登陆时间', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'lastSigninTime'
go

exec sp_addextendedproperty 'MS_Description', '用户级别', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'userLevel'
go

exec sp_addextendedproperty 'MS_Description', '用户性别', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'userSex'
go

exec sp_addextendedproperty 'MS_Description', '用户电话', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'userTel'
go

exec sp_addextendedproperty 'MS_Description', '用户所在影厅', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN', 'theaterId'
go

create table Theaters
(
	Id int identity
		primary key,
	theaterName nvarchar(30) default N'影厅' not null
		constraint un_theaterName
			unique,
	theaterLocation nvarchar(30) default N'中国' not null,
	theaterMapSite nvarchar(30) default 'https://gaode.com',
	seatRowCount int default 0 not null,
	seatColCount int default 0 not null
)
go

exec sp_addextendedproperty 'MS_Description', '放映厅表', 'SCHEMA', 'dbo', 'TABLE', 'Theaters'
go

exec sp_addextendedproperty 'MS_Description', '放映厅ID', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '影厅名称', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'COLUMN', 'theaterName'
go

exec sp_addextendedproperty 'MS_Description', '影厅位置', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'COLUMN', 'theaterLocation'
go

exec sp_addextendedproperty 'MS_Description', '影厅在地图上的位置', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'COLUMN', 'theaterMapSite'
go

exec sp_addextendedproperty 'MS_Description', '影厅座位行个数', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'COLUMN', 'seatRowCount'
go

exec sp_addextendedproperty 'MS_Description', '影厅座位列个数', 'SCHEMA', 'dbo', 'TABLE', 'Theaters', 'COLUMN', 'seatColCount'
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

create table Seats
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

exec sp_addextendedproperty 'MS_Description', '座位表
', 'SCHEMA', 'dbo', 'TABLE', 'Seats'
go

exec sp_addextendedproperty 'MS_Description', '座位ID', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '放映厅ID', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'COLUMN', 'theaterID'
go

exec sp_addextendedproperty 'MS_Description', '座位状态', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'COLUMN', 'status'
go

exec sp_addextendedproperty 'MS_Description', '第n行', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'COLUMN', 'rowNumber'
go

exec sp_addextendedproperty 'MS_Description', '第n列', 'SCHEMA', 'dbo', 'TABLE', 'Seats', 'COLUMN', 'colNumber'
go

CREATE TRIGGER tr_updateSeat
ON Seats
FOR UPDATE
AS
DECLARE @seatID INT, @seatStatus INT
SELECT
  @seatId = Inserted.Id,
  @seatStatus = Inserted.status
FROM Inserted

UPDATE Tickets
SET status =
CASE WHEN @seatStatus = 1
  THEN 1
WHEN @seatStatus = 0
  THEN 2
END
WHERE @seatID = Tickets.seatID
go

create table Programmes
(
	Id int identity
		primary key,
	proName nvarchar(50) not null,
	duration int not null,
	tags nvarchar(20),
	profile text default N'无简介'
)
go

exec sp_addextendedproperty 'MS_Description', '剧目表', 'SCHEMA', 'dbo', 'TABLE', 'Programmes'
go

exec sp_addextendedproperty 'MS_Description', '剧目ID', 'SCHEMA', 'dbo', 'TABLE', 'Programmes', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '剧目名称', 'SCHEMA', 'dbo', 'TABLE', 'Programmes', 'COLUMN', 'proName'
go

exec sp_addextendedproperty 'MS_Description', '剧目时长(分钟)', 'SCHEMA', 'dbo', 'TABLE', 'Programmes', 'COLUMN', 'duration'
go

exec sp_addextendedproperty 'MS_Description', '剧目标签', 'SCHEMA', 'dbo', 'TABLE', 'Programmes', 'COLUMN', 'tags'
go

exec sp_addextendedproperty 'MS_Description', '剧目简介', 'SCHEMA', 'dbo', 'TABLE', 'Programmes', 'COLUMN', 'profile'
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

create table UserIPs
(
	ip varchar(20) not null
		constraint PK__UserIPs__3213E823C7EECE27
			primary key,
	limitTimes int default 500 not null
)
go

exec sp_addextendedproperty 'MS_Description', 'IP限制 ， 此表用于API的限制IP', 'SCHEMA', 'dbo', 'TABLE', 'UserIPs'
go

create table Goods
(
	Id int identity
		primary key,
	proID int not null
		constraint goods_proId
			references Programmes
				on update cascade on delete cascade,
	theaterID int not null
		constraint goods_theaterId
			references Theaters
				on update cascade on delete cascade,
	performance nvarchar(10) default N'早一' not null,
	playdate date default '1-1-2017' not null,
	price money default '0' not null
)
go

exec sp_addextendedproperty 'MS_Description', '商品表', 'SCHEMA', 'dbo', 'TABLE', 'Goods'
go

exec sp_addextendedproperty 'MS_Description', '商品ID', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '剧目ID', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'COLUMN', 'proID'
go

exec sp_addextendedproperty 'MS_Description', '放映厅ID', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'COLUMN', 'theaterID'
go

exec sp_addextendedproperty 'MS_Description', '场次', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'COLUMN', 'performance'
go

exec sp_addextendedproperty 'MS_Description', '播放日期', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'COLUMN', 'playdate'
go

exec sp_addextendedproperty 'MS_Description', '价格', 'SCHEMA', 'dbo', 'TABLE', 'Goods', 'COLUMN', 'price'
go

create table Tickets
(
	Id int identity
		constraint PK__Ticket__3214EC074E8B6DD7
			primary key,
	status int default 0 not null
		constraint ticket_ticketstatus
			check ([status]=2 OR [status]=1 OR [status]=0),
	seatID int not null
		constraint tic_seatId
			references Seats
				on update cascade on delete cascade,
	goodID int not null
		constraint tic_goodId
			references Goods
				on update cascade on delete cascade,
	time datetime default (1970-1)-1 not null
)
go

exec sp_addextendedproperty 'MS_Description', '影票表', 'SCHEMA', 'dbo', 'TABLE', 'Tickets'
go

exec sp_addextendedproperty 'MS_Description', '票ID', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '票状态', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'COLUMN', 'status'
go

exec sp_addextendedproperty 'MS_Description', '座位ID', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'COLUMN', 'seatID'
go

exec sp_addextendedproperty 'MS_Description', '商品ID', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'COLUMN', 'goodID'
go

exec sp_addextendedproperty 'MS_Description', '时间戳，用作并发操作', 'SCHEMA', 'dbo', 'TABLE', 'Tickets', 'COLUMN', 'time'
go

create table Orders
(
	Id int identity
		constraint PK__Orders__3214EC071500447B
			primary key,
	ticketID int not null
		constraint order_ticketID
			references Tickets
				on update cascade on delete cascade,
	userID int not null
		constraint order_userID
			references Users
				on update cascade on delete cascade,
	type int default 1 not null
		constraint check_status
			check ([type]=(-1) OR [type]=1 OR [type]=2),
	time datetime default getdate() not null,
	theaterID int not null
)
go

exec sp_addextendedproperty 'MS_Description', '订单记录表', 'SCHEMA', 'dbo', 'TABLE', 'Orders'
go

exec sp_addextendedproperty 'MS_Description', '订单ID', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '订单索引', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'COLUMN', 'ticketID'
go

exec sp_addextendedproperty 'MS_Description', '完成此订单用户ID', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'COLUMN', 'userID'
go

exec sp_addextendedproperty 'MS_Description', '订单类型', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'COLUMN', 'type'
go

exec sp_addextendedproperty 'MS_Description', '交易时间', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'COLUMN', 'time'
go

exec sp_addextendedproperty 'MS_Description', '完成此订单的放映厅ID', 'SCHEMA', 'dbo', 'TABLE', 'Orders', 'COLUMN', 'theaterID'
go

create index index_order
	on Orders (userID, theaterID)
go

create index index_goodId
	on Tickets (goodID)
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

create table session
(
	Id nvarchar(1800) not null
		primary key,
	Value varbinary(900) not null,
	ExpiresAtTime datetimeoffset not null,
	SlidingExpirationInSeconds bigint,
	AbsoluteExpiration datetimeoffset
)
go

create unique index session_Id_uindex
	on session (Id)
go

create table PlayBills
(
	Id int identity
		primary key,
	programmeId int not null
		constraint PlayBills_Programme__fk
			references Programmes
				on update cascade on delete cascade,
	imagePath varchar(100) default 'https://image.baidu.com' not null
)
go

exec sp_addextendedproperty 'MS_Description', '图片ID', 'SCHEMA', 'dbo', 'TABLE', 'PlayBills', 'COLUMN', 'Id'
go

exec sp_addextendedproperty 'MS_Description', '图片类型', 'SCHEMA', 'dbo', 'TABLE', 'PlayBills', 'COLUMN', 'programmeId'
go

exec sp_addextendedproperty 'MS_Description', '图片位置', 'SCHEMA', 'dbo', 'TABLE', 'PlayBills', 'COLUMN', 'imagePath'
go

CREATE PROCEDURE [dbo].[sp_UpdateTheater]
    @theaterId INT, @theaterName NVARCHAR(30) = NULL,
    @theaterLocation  NVARCHAR(30) = NULL, @theaterMapSite NVARCHAR(30) = NULL,
    @message   VARCHAR(30) OUTPUT
AS
  IF EXISTS(SELECT 1
            FROM Theaters
            WHERE Id = @theaterId)
    BEGIN
      BEGIN TRY
      IF (@theaterName IS NOT NULL)
        UPDATE Theaters
        SET theaterName = @theaterName
        WHERE Id = @theaterId
      IF (@theaterLocation IS NOT NULL)
        UPDATE Theaters
        SET theaterLocation = @theaterLocation
        WHERE Id = @theaterId
      IF (@theaterMapSite IS NOT NULL)
        UPDATE Theaters
        SET theaterMapSite = @theaterMapSite
        WHERE Id = @theaterId
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

CREATE PROCEDURE [dbo].[sp_CreateProgrammeAndPlayBill]
    @proName nvarchar(50), @duration INT, @tags nvarchar(20), @profile TEXT, @imagePath VARCHAR(100),
    @message nvarchar(30) OUTPUT
AS
  IF NOT EXISTS(SELECT 1
                FROM dbo.Programmes
                WHERE proName = @proName)
    BEGIN
      BEGIN TRY
      INSERT INTO Programmes
      (proName, duration, tags, profile)
      VALUES
        (@proName, @duration, @tags, @profile) --插入剧目

      INSERT INTO PlayBills
      (programmeId, imagePath)
      VALUES
        ((SELECT Id
          FROM Programmes
          WHERE proName = @proName), @imagePath) --插入海报

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

CREATE PROCEDURE [dbo].[sp_UpdateProgramme]
    @programmeId        INT,
    @programmeName      nvarchar(50),
    @programmeDuration  INT,
    @programmeTags      nvarchar(20),
    @programmeProfile   TEXT,
    @programmeImagePath VARCHAR(100),
    @message            nvarchar(30) OUTPUT
AS
  IF EXISTS(SELECT 1
            FROM dbo.Programmes
            WHERE Id = @programmeId)
    BEGIN
      BEGIN TRY
      UPDATE Programmes
      SET proName = @programmeName,
        duration  = @programmeDuration,
        tags      = @programmeTags,
        profile   = @programmeProfile
      WHERE Id = @programmeId;

      IF (@programmeImagePath != '')
        BEGIN
          UPDATE PlayBills
          SET imagePath = @programmeImagePath
          WHERE programmeId = @programmeId;
        END

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
      SET @message = 'the programme is not exists'
      RETURN 400 --名称已存在
    END
go

CREATE PROCEDURE [dbo].[sp_GetAllProgrammeWithImagePath]
    @message VARCHAR(30) OUTPUT
AS
  BEGIN TRY
  SELECT
    Programmes.Id,
    proName,
    duration,
    tags,
    profile,
    imagePath
  FROM Programmes, PlayBills
  WHERE PlayBills.programmeId = Programmes.Id;
  SET @message = 'successful'
  RETURN 200
  END TRY
  BEGIN CATCH
  SET @message = ERROR_MESSAGE()
  RETURN ERROR_NUMBER()
  END CATCH
go

CREATE PROCEDURE [dbo].[sp_GetAllGoodWithName]
    @message varchar(30) OUTPUT
AS
  BEGIN TRY
  SELECT
    Goods.Id,
    proID,
    theaterID,
    performance,
    playdate,
    price,
    theaterName,
    proName
  FROM Goods, Theaters, Programmes
  where Goods.theaterID = Theaters.Id AND Goods.proID = Programmes.Id
  SET @message = 'successful'
  RETURN 200 --
  END TRY
  BEGIN CATCH
  SET @message = ERROR_MESSAGE()
  RETURN ERROR_NUMBER()
  END CATCH
go

CREATE PROCEDURE [dbo].[sp_UpdateGood]
    @goodId      INT,
    @programmeId INT = NULL, @theaterId INT = NULL, @performance nvarchar(10), @playDate DATE, @price MONEY,
    @message     VARCHAR(30) OUTPUT
AS
  IF (@performance NOT IN (N'早一', N'早二', N'午一', N'午二', N'晚一', N'晚二', N'午夜'))
    BEGIN
      SET @message = 'invalid performance'
      RETURN 400
    END
  ELSE
    BEGIN
      IF (EXISTS(SELECT 1
                 FROM Goods
                 WHERE @goodId = Id))
        BEGIN
          DECLARE @thisPerformance NVARCHAR(10), @thisPlayDate DATE;
          SELECT
            @thisPerformance = performance,
            @thisPlayDate = playdate
          FROM Goods
          WHERE Goods.Id = @goodId;
          BEGIN
            IF NOT EXISTS(SELECT 1
                          FROM Goods
                          WHERE @performance = performance AND @playDate = playDate)
               OR (@thisPerformance = @performance AND @thisPlayDate = @playDate)
              BEGIN
                BEGIN TRY
                UPDATE Goods
                SET performance = @performance,
                  playdate      = @playDate,
                  price         = @price
                WHERE Id = @goodId
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
        END
      ELSE
        BEGIN
          SET @message = 'good is not exists'
          RETURN 404 --未找到
        END
    END
go

CREATE PROCEDURE [dbo].[sp_SelectGoodWithName]
    @theaterId   INT = NULL,
    @programmeId INT = NULL,
    @playDate    DATE = NULL,
    @performance NVARCHAR(10) = NULL,
    @message     VARCHAR(30) OUTPUT
AS
  BEGIN TRY
  SELECT
    Goods.Id,
    proID,
    theaterID,
    performance,
    playdate,
    price,
    theaterName,
    proName,
    imagePath,
    duration
  FROM Goods, Theaters, Programmes, PlayBills
  WHERE ((@theaterId IS NULL OR @theaterId = 0) OR theaterID = @theaterId)
        AND ((@programmeId IS NULL OR @programmeId = 0) OR proID = @programmeId)
        AND (@playDate IS NULL OR playDate = @playDate)
        AND (@performance IS NULL OR performance = @performance)
        AND Goods.theaterID = Theaters.Id
        AND Goods.proID = Programmes.Id
        AND Programmes.Id = PlayBills.programmeId
  SET @message = 'successful'
  RETURN 200 --
  END TRY
  BEGIN CATCH
  SET @message = ERROR_MESSAGE()
  RETURN ERROR_NUMBER()
  END CATCH
go

CREATE PROC sp_NewSellTicket
    @userId   INT,
    @ticketId INT,
    @message  VARCHAR(30) OUTPUT
AS
  BEGIN TRY
  IF EXISTS(SELECT 1
            FROM Tickets
            WHERE @ticketId = Id)
    BEGIN
      IF EXISTS(SELECT 1
                FROM Users
                WHERE @userId = Id)
        BEGIN
          DECLARE @time DATETIME, @status INT
          SELECT
            @time = time,
            @status = status
          FROM Tickets
          WHERE @ticketId = Id

          -- 判断当行中时间和现在时间差值超过15m ，则此票可用
          IF (DATEADD(MINUTE, 15, @time) < GETDATE() AND @status = 1)
            BEGIN
              UPDATE Tickets --修改时间戳
              SET time = GETDATE()
              WHERE @ticketId = Id;

              INSERT INTO Orders (ticketID, userID, type, time, theaterID)  --插入一条交易记录
              VALUES (@ticketId, @userId, 2, GETDATE(), -1);

              SET @message = 'successful'
              RETURN 200
            END
          ELSE
            BEGIN
              SET @message = 'the ticket was sold'
              RETURN 401
            END
        END
      ELSE
        BEGIN
          SET @message = 'the user is not exists'
          RETURN 200
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

CREATE PROCEDURE sp_SelectUnPaidOrder
    @userId  INT,
    @message VARCHAR(30) OUTPUT
AS
  IF EXISTS(SELECT 1
            FROM Users
            WHERE @userId = Id)
    BEGIN
      SELECT
          Id = Tickets.Id,
          Name = Programmes.proName,
          Duration = Programmes.duration,
          Tags = Programmes.tags,
          Profile = Programmes.profile,
          Performance = performance,
          Date = playdate,
          Price = price,
          TheaterName = theaterName,
          SeatRowNumber = rowNumber,
          SeatColNumber = colNumber
      FROM Tickets
        JOIN Goods ON Tickets.goodID = Goods.Id
        JOIN Programmes ON Goods.proID = Programmes.Id
        JOIN Seats ON Tickets.seatID = Seats.Id
        JOIN Theaters ON Goods.theaterID = Theaters.Id
        JOIN Orders ON Tickets.Id = Orders.ticketID
      WHERE @userId = Orders.userID AND Orders.type = 2
            AND DATEADD(MINUTE, 15, Tickets.time) > GETDATE() AND
            Tickets.status = 1
      SET @message = 'successful'
      RETURN 200 --
    END
  ELSE
    BEGIN
      SET @message = 'the user is not exist'
      RETURN 404
    END
go

CREATE PROCEDURE [dbo].[sp_UpdateUser]
    @userId  INT, @newLevel nvarchar(15) = NULL, @newTel nvarchar(12) = NULL, @newPassword nvarchar(15) = NULL,
    @message varchar(30) OUTPUT
AS
  IF EXISTS(SELECT 1
            FROM users
            WHERE Id = @userId)
    BEGIN
      BEGIN TRY
      IF (@newLevel IS NOT NULL)
        UPDATE users
        SET userLevel = @newLevel
        WHERE Id = @userId
      IF (@newTel IS NOT NULL)
        UPDATE users
        SET userTel = @newTel
        WHERE Id = @userId
      IF (@newPassword IS NOT NULL)
        UPDATE users
        SET userPassword = @newPassword
        WHERE Id = @userId
      set @message = 'update successful'
      return 200
      END TRY
      BEGIN CATCH
      SET @message = ERROR_MESSAGE()
      RETURN ERROR_NUMBER()
      END CATCH

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
  @theaterId INT = NULL,
  @message   VARCHAR(30) OUTPUT
AS
IF EXISTS(SELECT 1
          FROM Theaters
          WHERE (@theaterId = NULL OR @theaterId = 0) OR Id = @theaterId)
  BEGIN
    BEGIN TRY
    SELECT *
    FROM Theaters
    WHERE (@theaterId = NULL OR @theaterId = 0) OR Id = @theaterId
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
g
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
      IF (DATEADD(MINUTE, 15, @time) < GETDATE() AND @status = 1)
        BEGIN
          UPDATE Tickets --修改时间戳
          SET time = GETDATE()
          WHERE @ticketId = Id;
          SET @message = 'successful'
          RETURN 200
        END
      ELSE
        BEGIN
          SET @message = 'the ticket was sold'
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
    Status = CASE
             WHEN Tickets.status = 2
               THEN 2
             -- 判断当行中时间和现在时间差值超过15m ，则此票可用
             WHEN DATEADD(MINUTE, 15, Tickets.time) < GETDATE() AND Tickets.status = 1
               THEN 1
             ELSE 0 END
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
             ELSE 0 END,
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
          RETURN 400 --请求错误 , 因为票状态为未售
        END
      ELSE
        BEGIN
          UPDATE Tickets
          SET status = 1
          WHERE @ticketId = Id --更改票状态

          INSERT INTO Orders (ticketID, userID, type, time, theaterID)  --插入一条交易记录
          VALUES (@ticketId, @userId, -1 , GETDATE(), @theaterID);

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

CREATE PROCEDURE [dbo].[sp_SelectOrder]
    @theaterId INT = NULL,
    @userId    INT = NULL,
    @tradeDate DATE = NULL,
    @type      NVARCHAR(10) = NULL,
    @message   VARCHAR(30) OUTPUT
AS
  BEGIN TRY
  SELECT
    Orders.Id,
    ticketID,
    userID,
    type,
    Orders.time,
    Orders.theaterID,
    proName,
    theaterName,
    price,
    seatRowCount,
    seatColCount,
    userName
  FROM Orders
    JOIN Tickets T on Orders.ticketID = T.Id
    JOIN Goods G on T.goodID = G.Id
    JOIN Programmes P on G.proID = P.Id
    JOIN Theaters T2 on G.theaterID = T2.Id
    JOIN Users U on Orders.userID = U.Id
  WHERE ((@theaterId IS NULL OR @theaterId = 0) OR Orders.theaterID = @theaterId)
        AND ((@userId IS NULL OR @userId = 0) OR userId = @userId)
        AND ((@type IS NULL OR @type = 0) OR type = @type)
        AND (@tradeDate IS NULL OR Orders.time = @tradeDate)
  SET @message = 'successful'
  RETURN 200 --
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
      IF (DATEADD(MINUTE, 15, @time) < GETDATE())
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
      DELETE Orders
      WHERE @ticketId = ticketID AND type = 2;

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


CREATE PROC sp_AnalyseOrder --售票分析
    @userId      INT = NULL, -- 基于用户分析
    @tradeDate   DATE = NULL, @dateLength INT = NULL, --基于日期分析
    @programmeId INT = NULL, --基于售票分析
    @theaterId INT = NULL , --基于影厅分析
    @message     VARCHAR(30) OUTPUT
AS
  BEGIN
    BEGIN TRY
    SELECT
        tradeTimes = COUNT(*),
      --交易次数
        sumPrice = SUM(Goods.price),
      --交易总额
        sumProfit = SUM
        (
            CASE Orders.type
            WHEN 1
              THEN Goods.price
            WHEN -1
              THEN (Goods.price * -1)
            END
        )
      --盈利总额
    FROM Orders
      JOIN Tickets ON Orders.ticketID = Tickets.Id
      JOIN Goods ON Tickets.goodID = Goods.Id
    WHERE ((@programmeId IS NULL OR @programmeId = 0) OR @programmeId = Goods.proID)
          AND (@tradeDate IS NULL OR (DATEADD(DAY, @dateLength , @tradeDate) > Orders.time AND @tradeDate < Orders.time))
          AND ((@userId IS NULL OR @userId = 0) OR @userId = userID)
          AND ((@theaterId IS NULL OR @theaterId = 0) OR @theaterId = Orders.theaterID)
    SET @message = 'successful'
    RETURN 200
    END TRY
    BEGIN CATCH
    SET @message = ERROR_MESSAGE()
    RETURN ERROR_NUMBER()
    END CATCH

  END
go

