--------------------------------Create DataBase-Store---------------------------------------
--------------------------------Create Tables-Store-----------------------------------------
Create DataBase StoreDataBase;

Use StoreDataBase
Go

-- جدول مشتریان
CREATE TABLE CustomerTbl (
    Cid INT PRIMARY KEY , -- کد مشتری
    Cname NVARCHAR(100) NOT NULL, -- نام مشتری
    Cfamily NVARCHAR(100) NOT NULL, -- نام خانوادگی مشتری
    Caddress NVARCHAR, -- آدرس مشتری
    Ctel NVARCHAR(20) -- شماره تماس
);				 

Alter Table CustomerTbl
Alter Column Caddress NVARCHAR(100);

-- جدول کالاها
CREATE TABLE ObjectTbl (
    Oid INT PRIMARY KEY , -- کد کالا
    Oname NVARCHAR(100) NOT NULL, -- نام کالا
    OCount INT NOT NULL, -- تعداد کالا
    Ofactory NVARCHAR(100) NOT NULL, -- کارخانه سازنده
    OBuyPrice DECIMAL(10, 2) NOT NULL -- قیمت خرید کالا
);

-- جدول فاکتورها
CREATE TABLE FactorTbl (
    Fid INT PRIMARY KEY , -- کد فاکتور
    Fdate DATE NOT NULL, -- تاریخ فاکتور
    Cid INT NOT NULL, -- کد مشتری
    FOREIGN KEY (Cid) REFERENCES CustomerTbl(Cid) -- ارتباط با جدول مشتریان
);

-- جدول ریز فاکتورها
CREATE TABLE SubFactorTbl (
    Sid INT PRIMARY KEY, -- شناسه ریزفاکتور
    Fid INT NOT NULL, -- کد فاکتور
    Oid INT NOT NULL, -- کد کالا
    Oprice DECIMAL(10, 2) NOT NULL, -- قیمت فروش
    OCount INT NOT NULL, -- تعداد کالا
    ODiscount DECIMAL(10, 2) DEFAULT 0, -- مقدار تخفیف
    FOREIGN KEY (Fid) REFERENCES FactorTbl(Fid), -- ارتباط با جدول فاکتورها
    FOREIGN KEY (Oid) REFERENCES ObjectTbl(Oid) -- ارتباط با جدول کالاها
);
--------------------------------Insert Value---------------------------------------
--Insert-Value-->Customer-Table
INSERT INTO Customertbl (Cid, Cname, Cfamily, Caddress, Ctel)
VALUES (1,N'محمد', N'نادری', N'آدرس 1', '11111111'),
       (2,N'حسین', N'محسنی', N'آدرس 2', '22222222'),
       (3,N'علیرضا', N'حسینی', N'آدرس 3', '33333333'),
       (4,N'زهرا', N'اسدی', N'آدرس 4', '44444444');

--Insert-Value-->Object-Table
INSERT INTO Objecttbl (Oid, Oname, OCount, Ofactory, OBuyPrice)
VALUES (1,N'یخچال', 10, 'LG', 1000),
       (2,N'ماشین لباسشویی سامسونگ', 12, 'Sony', 1100),
       (3,N'ال سی دی', 15, 'LG', 1200),
       (4,N'ماشین ظرف شویی', 24, 'Samsung', 2400),
       (5,N'اجاق گاز', 15, 'Bosh', 1100),
       (6,N'آب میوه گیری', 25, 'Tefal', 1200),
       (7,N'چای ساز', 32, 'Tefal', 1300),
       (8,N'اتو', 29, 'Tefal', 1400);

--Insert-Value-->Factor-Table
INSERT INTO Factortbl (Fid, Fdate, Cid) 
VALUES (1111, '1390/01/10', 1),
       (1112, '1390/01/11', 2),
       (1113, '1390/01/12', 3),
       (1114, '1390/01/13', 4),
       (1115, '1390/01/14', 3),
       (1116, '1390/01/14', 4),
       (1117, '1390/01/15', 2),
       (1118, '1390/01/15', 1),
       (1119, '1390/01/16', 4),
       (1120, '1390/01/16', 3);

--Insert-Value-->SubFactor-Table
INSERT INTO SubFactortbl (Sid, Fid, Oid, OPrice, OCount, ODiscount) 
VALUES (1, 1111, 1, 1100, 1, 100),
       (2, 1112, 2, 1200, 2, 20),
       (3, 1112, 3, 1400, 1, 0),
       (4, 1113, 4, 1200, 1, 20),
       (5, 1113, 5, 1280, 2, 30),
       (6, 1114, 1, 1100, 1, 50),
       (7, 1114, 6, 2530, 1, 20),
       (8, 1114, 7, 1400, 3, 30),
       (9, 1115, 1, 1100, 1, 30),
       (10, 1116, 6, 2530, 4, 32),
       (11, 1117, 8, 1450, 4, 2),
       (12, 1118, 1, 1100, 1, 20),
       (13, 1118, 6, 1400, 2, 10),
       (14, 1119, 7, 1400, 3, 20),
       (15, 1120, 7, 1400, 2, 30),
       (16, 1120, 1, 1100, 1, 10);

-----------------------------------------------------Question-----------------------------------------------------------------
--1)
Select COUNT(Distinct O.Ofactory) AS [تعداد کارخانه های سازنده]
From ObjectTbl AS O

--2)
Select O.Oname,F.Fdate
From FactorTbl AS F
Join SubFactorTbl AS SF ON F.Fid = SF.Fid
Join ObjectTbl AS O ON SF.Oid = o.Oid
Where F.Fdate Between '1390/01/12' AND '1390/01/15';

--3)
CREATE FUNCTION CalProfit (@Date DATE)
RETURNS @ProfitTable TABLE (
    Profit DECIMAL(18, 2) 
)
AS
BEGIN
    INSERT INTO @ProfitTable (Profit)
    SELECT SUM((SF.Oprice - O.OBuyPrice) * SF.OCount) AS Profit
    FROM FactorTbl AS F
    JOIN SubFactorTbl AS SF ON F.Fid = SF.Fid
    JOIN ObjectTbl AS O ON SF.Oid = O.Oid
    WHERE F.Fdate = @Date;

    RETURN;
END;

--Date = '1390/01/13'
Select * 
From CalProfit('1390/01/13')

--4)
Create View View_SUMPrice_Count AS
Select O.Oid,O.Oname,SUM(SF.Oprice) AS [مجموع تعداد فروش انجام شده]
From ObjectTbl AS O
Join SubFactorTbl AS SF ON O.Oid = SF.Oid
Join FactorTbl AS F ON SF.Fid = F.Fid
Group By O.Oid,O.Oname;

--Test
Select *
From View_SUMPrice_Count

--5)
CREATE PROCEDURE RegisterPurchaseSimple
    @Cid INT,              -- کد مشتری
    @Oid INT,              -- کد کالا
    @OCount INT,           -- تعداد کالا
    @Oprice DECIMAL(10, 2),-- قیمت فروش
    @ODate DATE            -- تاریخ خرید
AS
BEGIN
    BEGIN TRANSACTION;
    
    -- ایجاد فاکتور جدید
    DECLARE @Fid INT;
    INSERT INTO FactorTbl (Fdate, Cid)
    VALUES (@ODate, @Cid);
    
    SET @Fid = SCOPE_IDENTITY(); -- دریافت کد فاکتور جدید
    
    -- ثبت ریز فاکتور
    INSERT INTO SubFactorTbl (Fid, Oid, Oprice, OCount)
    VALUES (@Fid, @Oid, @Oprice, @OCount);
    
    -- کاهش موجودی کالا
    UPDATE ObjectTbl
    SET OCount = OCount - @OCount
    WHERE Oid = @Oid;
    
    COMMIT TRANSACTION;
END;
GO


--Test
EXEC RegisterPurchase 
    @Cid = 1,
    @Oid = 101,
    @OCount = 5,
    @Oprice = 2000.00,
    @ODate = GETDATE();

--6)
SELECT C.Cname, C.Cfamily,SUM(S.OCount) AS [جمع تعداد کالا به ازای هر مشتری]
FROM FactorTbl F
JOIN SubFactorTbl S ON F.Fid = S.Fid
JOIN CustomerTbl C ON F.Cid = C.Cid
GROUP BY C.Cid, C.Cname, C.Cfamily
HAVING 
    SUM(S.OCount) > (
        SELECT AVG(TotalItems)
        FROM (
            SELECT SUM(SF.OCount) AS TotalItems
            FROM FactorTbl FT
            JOIN SubFactorTbl SF ON FT.Fid = SF.Fid
            GROUP BY FT.Cid
        ) AS AvgQuery
    );

--7)
--پرس و جویی که تعداد دفعات خرید یک مشتری خاص با کد مشتری  2 را نمایش دهی دهد
Select COUNT(SF.OCount) [تعداد دفعات خرید کالا]
From CustomerTbl AS C
Join FactorTbl AS F ON C.Cid = F.Cid
Join SubFactorTbl AS SF ON F.Fid = SF.Fid
Where C.Cid = 2
