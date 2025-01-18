-- جدول برای مثال ها
--ID	F_Name	L_Name	Address	Age	DATES
--1	Mammad	Heydar	Theran	20	NULL
--2	Mammad2	Heydar2	Theran2	21	2018-05-10
--3	Mammad3	Heydar3	Theran3	22	NULL
--4	Mammad4	Heydar	Theran	23	NULL
--5	Mammad5	Heydar2	Theran	24	2018-05-26
--6	Mammad6	Heydar3	Theran3	25	NULL
--7	Ali2	Heydari2	Theran2	29	NULL

--ID	F_Name	L_Name	Address	Age	foreign_kye
--1	Ali	Heydari	Tehran	25	1
--2	Ali2	Heydari2	Theran2	26	2
--3	Ali3	Heydari3	Tehran3	27	2
--4	ALi4	heydari	Thran5	28	3
--5	ALi4	heydari	Thran5	54	1
--6	ALI	HEYDARI	TEHRAN	35	2
--7	ALI2	HEYDARI2	TEHRAN2	36	1


-- 1 : ساخت دیتابیس 
CREATE DATABASE Name_Database;

-- 2 : حذف دیتابیس
DROP DATABASE Name_DataBase;

-- 3 : تعریف و ساخت جدول
CREATE TABLE Mammad1
(
ID int Primary key identity(1,1),
F_Name nvarchar(50) not null,
L_Name nvarchar(50),
Address nvarchar(200),
Age tinyint unique not null,
check (Age >= 10)
);
CREATE TABLE Mammad2
(
ID int Primary key,
F_Name nvarchar(50) not null,
L_Name nvarchar(50),
Address nvarchar(200),
Age tinyint unique not null check (Age >= 10),
foreign_kye int foreign key references Mammad1(ID)
);
-- مقدار ستون foreign_kye باید قبلاً در ستون ID جدول Mammad1 وجود داشته باشد.
-- افزودن به Mammad2: باید مقدار foreign_kye به یک مقدار موجود در Mammad1.ID اشاره کند.

-- 3 : حذف جدول
DROP TABLE Mammad1;

-- 4 : اضافه کردن ستون به جدول
ALTER TABLE Mammad2
ADD [Days] date;
-- ++
ALTER TABLE Mammad2
ADD [months] date;

-- 5 : حذف یک ستون از جدول ***
alter table Mammad2
drop column [Days];

-- 6 :تغییر نوع یک ستون در یک جدول 
alter table Mammad2
alter column Address nvarchar(max);

-- 7 : اضافه کردن داده به جدول مورد نظر
INSERT INTO Mammad1
VALUES
('Mammad','Heydar','Theran',20),
('Mammad2','Heydar2','Theran2',21),
('Mammad3','Heydar3','Theran3',22),
('Mammad4','Heydar','Theran',23),
('Mammad5','Heydar2','Theran2',24),
('Mammad6','Heydar3','Theran3',25);

-- 8 : حذف داده های یک جدول با حفظ ساختار جدول
delete from Mammad1;

-- ++ ( حذف کامل داده‌ها و بازنشانی شمارنده ایدنتیتی)
TRUNCATE TABLE Mammad1; -- سریع تر از دیلیت است اما در جدول های دارای فارن کی نمیشود استفاده کرد 

-- 9 : اضافه کردن داده به جدول با استفاده از یک جدول دیگر
insert into Name_Table
select * from Name_Table2
-- where .....

-- 10 : تغییر داده در یک سطر یا سطر های یک جدول
update Mammad1
set F_Name = 'Mammad1'
Where ID = 6;

-- 11 : خارج کردن اطلاعات از یک جدول
select * from Mammad1;

-- ++(بازنشانی شمارنده ایدنتیتی به 1)
DBCC CHECKIDENT ('Mammad1', RESEED, 0);

-- 12 : خروجی داده بدون تکراری
select distinct L_Name from  Mammad1;

-- 13 : (مرتب سازی داده های خروجی(صعودی به صورت پیش فرض
select * from Mammad1
order by Mammad1.L_Name
-- ++
select * from Mammad1
order by Mammad1.L_Name , Age;
-- ++ Desc نزولی
select * from Mammad1
order by Mammad1.L_Name desc;
-- ++ asc صعودی
select * from Mammad1
order by Mammad1.L_Name asc;

-- 14 : اجتماع دو مجموعه
select ID , F_Name from Mammad1
union
select ID , F_Name from Mammad2;
-- اگر در دو جدول یک یا چند سطر وجود داشته باشد، داده هایشان ، آن وقت دو سطر تکراری را نشان نمیدهد و در آنیون آل نشان میدهد
select ID , F_Name from Mammad1
union all
select ID , F_Name from Mammad2;

-- 15 : اشتراک دو مجموعه
select ID , F_Name from Mammad1
intersect
select ID , F_Name from Mammad2;
-- سطر هایی که دقیقا یکی باشند را نشان میدهد

-- 16 تفاضل دو مجموعه
select ID , F_Name from Mammad2
except
select ID , F_Name from Mammad1;
-- سطر هایی که دقیقا یکی باشند را حذف میکند از مجموعه دوم

-- 17 : متعلق بودن
select * from Mammad2
where Address IN('Theran2','Tehran')
-- ++ نبودن
select * from Mammad2
where Address NOT IN('Theran2','Tehran')

-- 18 : شامل بودن
SELECT * FROM Mammad2
WHERE Address like 'Theran2';

-- 19 : Nested Query 
SELECT * 
FROM Mammad2 m2
WHERE F_Name in(SELECT F_Name FROM Mammad1 m1 
							WHERE m1.F_Name = m2.F_Name);
-- ++
SELECT * 
FROM Mammad2 m2
WHERE EXISTS (SELECT * FROM Mammad1 m1 
							WHERE m1.F_Name = m2.F_Name);
-- اگر می‌خواهید یک مقدار خاص را با یک ستون مقایسه کنید و فقط یک مقدار برگردانده شود، از زیرپرسش مستقیم با = استفاده کنید.
-- اگر می‌خواهید بررسی کنید که آیا رکوردهایی با شرایط خاص وجود دارند، از (EXISTS) استفاده کنید که به شما این امکان را می‌دهد که چندین رکورد وجود داشته باشد.

-- 20 : توابع محاسباتی
select  MAX(Age) as Max_Age , MIN(Age) as Min_Age , Count(*) as count_Persons , AVG(Age) as AVG_Age , Sum(Age) as SUM_Age from Mammad1;

-- 21 : گروه بندی
SELECT foreign_kye , count(*) as count , MAX(Age) AS MaxAgeInGroup , MIN(Age) AS MinAgeInGroup
FROM Mammad2
GROUP BY foreign_kye ; 
-- ++ گروه بندی با شرط
SELECT foreign_kye , count(*) as [count] , MAX(Age) AS MaxAgeInGroup , MIN(Age) AS MinAgeInGroup
FROM Mammad2
GROUP BY foreign_kye 
having foreign_kye > 1; 

-- 22 : دستور لایک در پیدا کردن و فیلتر کردن داده ها از جدول ها
select * from Mammad1
where Address LIKE 'T_____'
-- ++
select * from Mammad1
where Address LIKE 'T%'
-- ++
select * from Mammad1
where Address LIKE '%n'
-- ++ 
select * from Mammad1
where Address LIKE '%n%'

-- 23 : EXISTS

SELECT * FROM Mammad2 m2
WHERE EXISTS (SELECT * FROM Mammad1 m1 
							WHERE m1.F_Name = m2.F_Name); -- شامل اینها باشد
-- ++ NOT EXISTS
SELECT * FROM Mammad2 m2
WHERE NOT EXISTS (SELECT * FROM Mammad1 m1 
							WHERE m1.F_Name = m2.F_Name); -- شامل این ها نباشند
-- اشتباه در جزوه
--SELECT * FROM Mammad2 m2
--WHERE m2.F_Name is null(SELECT * FROM Mammad1 m1 
--							WHERE m1.F_Name = m2.F_Name);
--SELECT * 
--FROM Mammad2 m2
--WHERE m2.F_Name NULL (SELECT * FROM Mammad1 m1 
--							WHERE m1.F_Name = m2.F_Name);
-- اشتباه در جزوه

-- 24 : null and not null
select * from Mammad1
where DATES is null;
select * from Mammad1
where DATES is not null;

-- 25 : three-valued logic (نتیجه مقایسه ها)
-- جدول حالت آن ها مطالعه شود
-- FALSE = 0 ,  TRUE=1    ,  UNKNOWN = 0.5
SELECT * FROM Mammad1
WHERE DATES IS NULL OR DATES = '2018-05-10';
SELECT * FROM Mammad1
WHERE ID IS NULL AND DATES = '2018-05-10';
SELECT * FROM Mammad1
WHERE ID IS NULL AND DATES <> '2018-05-10';

-- 26 : ANY , ALL
-- اگر سن در جدول ممد2 از حداقل یکی از مقادیر سن در جدول ممد1 بیشتر باشد ، رکورد از جدول ممد 2 به نتیجه اضافه میشود
SELECT *  FROM Mammad2
WHERE Age > ANY (SELECT Age FROM Mammad1);
-- ++
-- اگر سن در جدول ممد2 از تمام مقادیر سن در جدول ممد۱ بیشتر باشد ، رکورد از جدول ممد۲ به نتیجه اضافه میشود
SELECT * FROM Mammad2
WHERE Age > ALL (SELECT Age FROM Mammad1);

-- 27 : joins
-- inner join
SELECT * FROM Mammad1 m1
INNER JOIN Mammad2 m2
ON m1.Address = m2.Address;
-- LEFT JOIN
SELECT * FROM Mammad1 m1
LEFT JOIN Mammad2 m2
ON m1.Address = m2.Address;
-- LEFT JOIN
SELECT * FROM Mammad1 m1
LEFT JOIN Mammad2 m2
ON m1.ID = m2.[foreign_kye];
-- RIGHT JOIN
SELECT * 
FROM Mammad1 m1
RIGHT JOIN Mammad2 m2
ON m1.Address = m2.Address;
-- FULL JOIN
SELECT * FROM Mammad1 m1
FULL JOIN Mammad2 m2
ON m1.Address = m2.Address;
--  CROSS JOIN
SELECT * FROM Mammad1 m1
CROSS JOIN Mammad2 m2;
-- SELF JOIN
SELECT a.ID, a.F_Name as a_Name, a.L_Name as a_L_Name, b.F_Name , b.L_Name 
FROM Mammad1 a, Mammad1 b
WHERE a.Address = b.Address;

-- از صفحه ۹۸ تا ۱۰۵ درس داده نشده و جهت مطالعه آزاد خوانده شود

-- 28 : ساخت تابع
create function sumfunc(@num1 int,@num2 int)
returns int
as
begin
	return @num1+@num2
end;

-- استفاده از تابع
select *,dbo.sumfunc(ID,Age) as sum_AgeAndID from Mammad1;
