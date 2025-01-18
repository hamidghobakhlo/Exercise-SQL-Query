--------------------------------Create DataBase-CarRepairShop---------------------------------------
--------------------------------Create Tables-CarRepairShop-----------------------------------------
-- ایجاد دیتابیس تعمیرگاه خودرو
CREATE DATABASE CarRepairShop;

-- استفاده از دیتابیس
USE CarRepairShop;

-- ایجاد جدول Customer
CREATE TABLE Customer (
    Cid INT PRIMARY KEY,
    Cname NVARCHAR(50),
    Caddress NVARCHAR(50),
    Ctel NVARCHAR(15)
);

-- ایجاد جدول Car
CREATE TABLE Car (
    Aid INT PRIMARY KEY,
    Cid INT,
    Aname NVARCHAR(50),
    Aserial NVARCHAR(50),
    Amodel INT,
    Acolor NVARCHAR(50),
    FOREIGN KEY (Cid) REFERENCES Customer(Cid)
);

-- ایجاد جدول Location
CREATE TABLE Location (
    Lid INT PRIMARY KEY,
    Locate NVARCHAR(50)
);

-- ایجاد جدول Service
CREATE TABLE Service (
    Sid INT PRIMARY KEY,
    Aid INT,
    Sdate DATE,
    Scomment NVARCHAR(255),
    FOREIGN KEY (Aid) REFERENCES Car(Aid)
);

-- ایجاد جدول ServiceLocation
CREATE TABLE ServiceLocation (
    id INT PRIMARY KEY,
    Sid INT,
    Lid INT,
    Comment NVARCHAR(255),
    Price INT,
    FOREIGN KEY (Sid) REFERENCES Service(Sid),
    FOREIGN KEY (Lid) REFERENCES Location(Lid)
);

--------------------------------Insert Value---------------------------------------

-- ورود داده‌ها به جدول Customer
INSERT INTO Customer (Cid, Cname, Caddress, Ctel)
VALUES 
(1, N'محمدی', N'خ ایثار', N'22222'),
(2, N'احمدی', N'خ بهار', N'33333'),
(3, N'جوادی', N'خ یاس', N'44444'),
(4, N'حسینی', N'خ شمسی', N'55555');

-- ورود داده‌ها به جدول Car
INSERT INTO Car (Aid, Cid, Aname, Aserial, Amodel, Acolor)
VALUES
(1, 1, N'پژو 206', N'12222', 1388, N'سفید'),
(2, 1, N'سمند LX', N'32232', 1390, N'مشکی'),
(3, 2, N'پژو 405', N'23332', 1387, N'نقره ای'),
(4, 3, N'پژو 206', N'12222', 1385, N'سرمه ای'),
(5, 4, N'L90', N'12232', 1384, N'مشکی'),
(6, 4, N'مزدا 3', N'12233', 1385, N'سفید'),
(7, 4, N'پژو 206', N'12234', 1389, N'مشکی');

-- ورود داده‌ها به جدول Location
INSERT INTO Location (Lid, Locate)
VALUES
(1, N'مکانیکی'),
(2, N'باتری و برق'),
(3, N'جلو بندی'),
(4, N'تعویض روغن');

-- ورود داده‌ها به جدول Service
INSERT INTO Service (Sid, Aid, Sdate, Scomment)
VALUES
(1, 1, '1390-01-01', N'12'),
(2, 1, '1390-01-02', N'33'),
(3, 2, '1390-02-03', N'34'),
(4, 2, '1390-04-13', N'43'),
(5, 3, '1390-04-13', N'34'),
(6, 3, '1390-04-14', N'45'),
(7, 4, '1390-04-15', N'45'),
(8, 5, '1390-05-15', N'45'),
(9, 5, '1391-09-05', N'56'),
(10, 5, '1391-09-20', N'5');

-- ورود داده‌ها به جدول ServiceLocation
INSERT INTO ServiceLocation (id, Sid, Lid, Comment, Price)
VALUES
(1, 1, 1, N'0', 1200),
(2, 1, 2, N'0', 1200),
(3, 1, 3, N'0', 1000),
(4, 2, 4, N'0', 1200),
(5, 3, 1, N'0', 1200),
(6, 3, 2, N'0', 1200),
(7, 4, 3, N'0', 1000),
(8, 4, 4, N'0', 1200),
(9, 5, 1, N'0', 1300),
(10, 5, 2, N'0', 2000),
(11, 6, 3, N'0', 4500),
(12, 7, 4, N'0', 2000),
(13, 8, 1, N'0', 1300),
(14, 8, 2, N'0', 2000),
(15, 9, 3, N'0', 4500),
(16, 9, 4, N'0', 2000),
(17, 10, 1, N'0', 1300),
(18, 10, 2, N'0', 2000),
(19, 10, 3, N'0', 4500),
(20, 10, 4, N'0', 2000);

--------------------------------Question-Answer-With-Query---------------------------------------
--1)
Select C.Cname,Caddress,C.Ctel
From Customer AS C
Join Car ON C.Cid = Car.Cid
Join Service AS S ON Car.Aid = S.Aid
Where S.Sdate Between '1390-01-01' AND '1391-09-20';

--3)
Select Top(1) L.Locate,COUNT(SL.Sid) AS [تعداد مراجعین]
From Service AS S
Join ServiceLocation AS SL ON S.Sid = SL.Sid
Join Location AS L ON SL.Lid = L.Lid
Where S.Sdate >= '1391/01/01' 
Group By L.Locate
Order By COUNT(SL.Sid)

--4)
Select C.Cname,Car.Aname,Count(S.Aid) AS [تعداد مراجعین به ازای خودرو]
From Customer AS C
Join Car ON C.Cid = Car.Cid
Join Service AS S ON Car.Aid = S.Aid
Group By C.Cname,Car.Aname

-- 5)
--Procedure
CREATE PROCEDURE GetCustomerPayments
    @CustomerId INT
AS
BEGIN
    -- اطلاعات مشتری، خودرو و هزینه‌های پرداختی
    SELECT Customer.Cname ,Car.Aname,SUM(ServiceLocation.Price) 
    FROM Customer
    JOIN Car ON Customer.Cid = Car.Cid
    JOIN Service ON Car.Aid = Service.Aid
    JOIN ServiceLocation ON Service.Sid = ServiceLocation.Sid
    WHERE Customer.Cid = @CustomerId; -- فیلتر براساس شماره مشتری
	Group By Customer.Cname ,Car.Aname 
END;

--Test
EXEC GetCustomerPayments @CustomerId = 1;


--Function
Create Function PriceList (@CID_Customer INT)
Returns Table 
AS
Begin
	Return 
	Select C.Cname,Car.Aname,SUM(SL.Price) AS [لیست هزینه های پرداختی به ازای مشتری]
	From Customer AS C
	Join Car ON C.Cid = Car.Cid
	Join Service AS S ON Car.Aid = S.Aid
	Join ServiceLocation AS SL ON S.Sid = SL.Sid
	Where C.Cid = @CID_Customer
	Group By C.Cname,Car.Aname
END;
--Customer = 2
select *
from PriceList(2)


