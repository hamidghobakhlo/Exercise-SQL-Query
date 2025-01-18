-- ساخت دیتابیس
CREATE DATABASE TryDataBase;

-- این کوئری دیتابیس  را از سرور جدا می‌کند
EXEC sp_detach_db 'TryDataBase'

-- این کوئری دیتابیس را دوباره به سرور متصل می‌کند 
-- فایل اصلی پایگاه داده و فایل لاگ مربوطه را از مسیر مشخص‌شده استفاده می‌کند
EXEC sp_attach_db 'TryDataBase',
    "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TryDataBase.mdf",
    "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TryDataBase_log.ldf"

-- این کوئری دیتابیس را به طور کامل از سرور حذف می‌کند
DROP DATABASE TryDataBase;

-- وارد شدن به دیتابیس قبل نوشتن کوئری
USE TryDataBase
Go

-- ساخت جدول 
create table Mammad
(
ID smallint primary key identity(1,1),
F_Name nvarchar(35) not null,
L_Name nvarchar(40) not null,
Age tinyint ,
Address nvarchar(500)
);

-- تغییر نوع یک ستون مشخص
ALTER table dbo.Mammad
ALTER COLUMN F_Name nvarchar(160);

-- اضافه کردن ستون جدید
alter table dbo.Mammad
add [Data] Datetime;

-- اضافه کردن شرط یونیک بودن
alter table Mammad
add UNIQUE (L_Name);

-- 2 ساخت جدول
create table Mammad2
(
ID tinyint primary key,
F_Name nvarchar(35) not null,
L_Name nvarchar(40) not null,
Age tinyint unique,
Address nvarchar(500),
[DateTime] DateTime
);

--.تغییر میدهد (Last_Name) - (L_Name) <--این کوئری نام جدول یا شی 
EXEC sp_rename 'Mammad2.L_Name', 'Last_Name', 'COLUMN';

--را نمایش می‌دهدAddress این کوئری اطلاعات کامل مربوط به شیء یا جدول   
EXECUTE sp_help 'Mammad2';

-- اضافه کردن شرط به یک ستون
alter table Mammad2
add check (Age <= 100);

-- ساخت جدول 3
create table Mammad3
(
ID smallint primary key,
F_Name nvarchar(20) not null,
L_Name nvarchar(35) not null unique,
Age tinyint check(Age <= 90),
Address nvarchar(800)
);

--نمایش محدویت های جداول 
SELECT * 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Mammad2';

--حذف شرط یونیک بودن
alter table Mammad2
drop constraint UQ__Mammad2__C6971A5140976063;

-- حذف یک جدول
drop table Mammad3;

-- وارد کردن داده به جدول به انتخاب
insert into TryDataBase.dbo.Mammad2(ID,F_Name,Last_Name,Age,Address)
values(7,N'حمید',N'قباخلو',20,N'تهران ، صادقیه');

--وارد کردن داده به جدول به ترتیب اصلی
insert into TryDataBase.dbo.Mammad2
values(3,N'علی',N'قباخلو',20,N'تهران ، صادقیه','2024');

-- وارد کردن داده به حدول با چند سطر
insert into TryDataBase.dbo.Mammad2
values
(1,N'رضا',N'عسگرس',20,N'تهران','2024'),
(2,N'حمید',N'محمدی',20,N'تهران','2024');
--
insert into TryDataBase.dbo.Mammad2
values
(8,N'Ali',N'Moka',20,N'Tehran','2024'),
(9,N'Reza',N'Mohammadi',21,N'Shiraz','2025');


-- تغییر داده ی مشخص در جدول
update Mammad2
set ID = 4 , F_Name = 'Hamid'
where ID = 7;

/*براي بررسي تهي بودن يا نبودن يک فيلد از دستورات 
IS NULL 
NOT NULL
استفاده می نماييم*/
UPDATE Mammad2
SET F_Name= N'حمید'
WHERE F_Name IS NULL
AND ID = 4

-- حذف داده های مشخص
delete from Mammad2 
where ID = 7;

-- حذف داده به داده جدول ها
delete from Mammad2;

-- حذف داده های جدول به ترتیب صفحات
truncate table Mammad2;

-- دریافت داده از جدول با ستون های خاص
select ID,F_Name 
from Mammad2;

-- دریافت همه داده  ها از جدول
select * 
from Mammad2;

-- دریافت همه داده  ها از جدول با شرط خاص
select * 
from Mammad2
where ID = 3;

-- دریافت همه داده  ها از جدول با شرط خاص
select * 
from Mammad2
where ID between 3 and 5;

-- دریافت همه داده  ها از جدول با شرط نبود داده تکراری
select distinct Last_Name 
from Mammad2;

-- دریافت همه داده  ها از جدول با شرط 2 سطر اول جدول
select top(2) * 
from Mammad2;

-- دریافت  داده ها از جدول با شرط 2 سطر اول جدول
select top(2) ID,Last_Name 
from Mammad2;

-- دریافت  داده ها از جدول با شرط 30 درصد رکورد های اول جدول
select top(30)percent * 
from Mammad2;

-- دریافت همه داده  ها از جدول با شرط شباهت خاص داده
select * 
from Mammad2
where F_Name Like N'%ح%'
--
Select*
from Mammad2
where F_Name LIKE '[A-H]%'
--
Select*
from Mammad2
where F_Name LIKE '[^A-H]%'
--
Select*
from Mammad2
where F_Name LIKE 'A--'

-- دریافت داده به صورت مرتب شده بر اساس یک یا چند ستون به صورت صعودی
select *
from Mammad2
order by F_Name; -- ASC

-- دریافت داده به صورت مرتب شده بر اساس یک یا  چند ستون به صورت نزولی
select * 
from Mammad2 
order by F_Name DESC;

-- IN <--دستور 
select * 
from Mammad2
where F_Name IN (N'رضا',N'حمید');

-- NOT IN <--دستور 
select * 
from Mammad2
where F_Name  NOT IN (N'رضا',N'حمید');

-- تعویض نام ستون به صورت مجازی و فقط برای نمایش داده ها
select ID, F_Name AS [نام] , Last_Name AS [نام خانوادگی]
from Mammad2;

-- تعویض نام ستون و تغییر داده های مقداری به صورت مجازی و فقط برای نمایش داده ها
select ID, Age, F_Name AS [نام] , Last_Name AS [نام خانوادگی] , AGE+5 AS [سن + 5]
from Mammad2;

-- وارد کردن اطلاعات برای بقیه مثال ها
CREATE DATABASE University;

USE University;
GO

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Family NVARCHAR(50),
    Major NVARCHAR(50),
    City NVARCHAR(50),
    Grade INT
);
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CoTitle NVARCHAR(50),
    Credit INT,
    CoType NVARCHAR(50)
);
/*مدیریت خودکار حذف و به‌روزرسانی: استفاده از قیدهای
ON DELETE CASCADE و ON UPDATE CASCADE
عملیات حذف و به‌روزرسانی را خودکار و منظم می‌کند.*/
CREATE TABLE Selection (
    StudentID INT FOREIGN KEY REFERENCES Student(StudentID) ON DELETE CASCADE ON UPDATE CASCADE,
    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID) ON DELETE CASCADE ON UPDATE CASCADE,
    Term INT,
    [Year] NVARCHAR(10),
    Grade INT
);

INSERT INTO Student (StudentID, Name, Family, Major, City, Grade)
VALUES
  (41252214, N'احمد', N'رضایی', N'سخت افزار', N'تهران', 18),
  (10724113, N'احسان', N'امیری', N'نرم افزار', N'کرج', 14),
  (10254861, N'زهرا', N'حسینی', N'سخت افزار', N'تهران', 17),
  (27365187, N'سحر', N'احمدی', N'نرم افزار', N'بم', 16),
  (35654415, N'حسام', N'رضوی', N'نرم افزار', N'تهران', 19);

INSERT INTO Courses (CourseID, CoTitle, Credit, CoType)
VALUES
  (1011, N'پایگاه داده', 3, N'عملی'),
  (1012, N'مباحث ویژه', 3, N'عملی'),
  (1013, N'زبان تخصصی', 2, N'نظری');

INSERT INTO Selection (StudentID, CourseID, Term, [year], Grade)
VALUES
  (41252214, 1011, 2, '85-86', 16),
  (10724113, 1011, 2, '85-86', 14),
  (41252214, 1012, 1, '85-86', 17),
  (10724113, 1012, 1, '85-86', 11),
  (10254861, 1013, 2, '85-86', 13),
  (10254861, 1011, 2, '84-85', 8),
  (27365187, 1012, 1, '84-85', 19),
  (27365187, 1013, 1, '84-85', 16),
  (35654415, 1011, 2, '84-85', 9),
  (35654415, 1013, 2, '84-85', 17);

Select [Name] As نام , [Family] As خانوادگی 
From Student 
Where Major = N'نرم افزار'
Order By Family ;

-- تلفیق دو جدول با هم و دریافت اطلاعات از نتیجه تلفیق آن ها
--1
Select Student.Name, Student.Family, Selection.Term,Selection.[year]
From Student, Selection
where Student.StudentID = Selection.StudentID
	AND CourseID = 1012 AND Term = 1  AND [year] = '85-86'
order by Student.Family;
-- 2 
Select Courses.CourseID, Courses.CoTitle
from Courses , Selection
Where Courses.CourseID = Selection.CourseID
	AND Selection.StudentID = 10254861;

-- 3 
SELECT Student.Name, Student.Family
From Student, Selection
Where Student.Studentid = Selection.Studentid
	And Selection.Courseid = '1013' And Year = '84-85' And Student.Grade > 15 ;

-- پیوند بیش از ۲ جدول) 4) 
Select Student.Name, Student.Family, Courses.CoTitle, Courses.CoType
From Student, Courses, Selection
Where Student.StudentID = Selection.StudentID
	AND Courses.CourseID = Selection.CourseID
	AND Courses.CoType = N'نظری';

SELECT Student.Name, Student.Family, Courses.CoTitle, Courses.CoType
FROM Student, Courses, Selection
WHERE Student.StudentID = Selection.StudentID
	AND Courses.CourseID = Selection.CourseID
	AND Courses.CoType IN (N'نظری', N'عملی');

SELECT Student.Name , Student.Family, Selection.Term,Selection.year
FROM Student,Selection,Courses
WHERE Student.StudentID = Selection.StudentID
	AND Courses.CourseID = Selection.CourseID
	AND Selection.Term = 1 
	AND Selection.year = '85-86'
	AND Courses.CourseID = 1012;

--5 تلفیق با اینر جوین 
Select Student.Name, Student.Family, Selection.Term, Selection.[year]
From Student
Inner Join Selection
On Student.StudentID = Selection.StudentID
Where Selection.CourseID = 1012 AND Term = 1 AND [year] ='85-86';

--6 inner Join
Select Courses.CourseID, Courses.CoTitle
From Courses
Inner Join Selection
ON Courses.CourseID = Selection.CourseID
Where Selection.StudentID = 10254861;

-- 7 سلکت های تو در تو درجه۲
Select [Name], [Family]
From Student
Where StudentID IN (Select StudentID
					From Selection
					Where CourseID = 1012 AND Term = 1 AND [year] ='85-86');
-- 8 
Select CourseID, CoTitle
From Courses
Where CourseID IN (Select CourseID
					From Selection
					Where StudentID = 10254861);

-- 9 سلکت تو در تو درجه۳
Select Name , Family
From Student
where StudentID IN (Select StudentID
					From Selection
					Where CourseID IN (Select CourseID
										From Courses 
										Where CoType = N'نظری'));

-- 10 تابع های محاسباتی
-- میانگین
Select AVG(Grade) as Average_Grade 
from Student;

-- 11 
Select AVG(Selection.Grade) AS N'معدل'
from Student,Selection,Courses
WHERE Student.StudentID = Selection.StudentID
	AND Selection.CourseID = Courses.CourseID
	AND Major = N'نرم افزار' 
	AND CoTitle = N'پایگاه داده';

-- 12  
-- مجموع
Select Sum (Selection.Grade) As [مجموع نمرات پایگاه داده]
From Selection,Courses
where Selection.CourseID = Courses.CourseID
	AND Selection.CourseID = 1011 ;

-- 13
Select Sum(Selection.Grade) As [مجموع نمرات یک شخص]
From Student,Selection
Where Student.StudentID = Selection.StudentID
	AND Name = N'حسام'
	AND Family = N'رضوی';

-- 14
-- حداقل
Select Min(Family) As Family From Student;

Select Min (Grade) As [کمترین نمره] From Selection

--15
-- حداکثر
Select Max (Grade) As [بيشترين نمره] From Selection;

--16
--تعداد درس هایی که دانشجو با شماره دانشجویی 35654415 در آن ها قبول شده را بدهید
Select Count (CourseID) AS [تعداد دروس]
From Selection 
Where StudentID = 35654415 
	AND Grade > 10 ;

-- تعداد موجود به طوری که موارد تکراری یا خالی حذف میشوند
--تعداد دانشجویانی که درس پایگاه داده را انتخاب کرده اند را اعلام کنید
Select Count (DISTINCT Selection.CourseID) AS [تعداد دانشجویان]
From Selection , Courses
Where Selection.CourseID = Courses.CourseID
	AND CoTitle = N'پایگاه داده';
-- تعداد موجود با موارد تکراری و خالی
Select Count (Selection.CourseID) AS [تعداد دانشجویان]
From Selection , Courses
Where Selection.CourseID = Courses.CourseID
	AND CoTitle = N'پایگاه داده';

-- 17  ترکیب و ادغام دو یا چند ستون از دو یا چند جدول مختلف و نشان دادن ان ها در یک ستون مشترک بدون تکرار
Select StudentID 
From Student
Where Major = N'نرم افزار'
Union
Select StudentID 
From Selection
Where CourseID = 1013;

-- ترکیب و ادغام دو یا چند ستون از دو یا چند جدول مختلف و نشان دادن ان ها در یک ستون مشترک بدون تکرار
Select StudentID From Student
Where Major = N'نرم افزار'
Union 
Select StudentID From Selection
Where CourseID = 1013;

-- ترکیب و ادغام دو یا چند ستون از دو یا چند جدول مختلف و نشان دادن ان ها در یک ستون مشترک با تکرار
Select StudentID From Student
Where Major = N'نرم افزار'
Union ALL
Select StudentID From Selection
Where CourseID = 1013;

-- نکته : میتوان به جای دستور Union از Intersect برای اشتراک و Escept براى تفاضل استفاده كرد.
/*شماره دانشجویی ، نام و نام خانوادگی دانشجویانی را بدهید که در رشته سخت افزار تحصیل کرده یا
: حداقل یک درس از نوع نظری را انتخاب کرده باشند */
Select StudentID , Name , Family
From Student
Where Major = N'سخت افزار'
Union
Select Student.StudentID , Student.Name , Student.Family
From Student, Selection, Courses
where Student.StudentID = Selection.StudentID
	AND Selection.CourseID = Courses.CourseID
	AND Courses.CoType = N'نظری' ;
-- فقط رکوردهایی را که در هر دو مجموعه نتیجه وجود دارند (تقاطع) برمی‌گرداند.
Select StudentID , Name , Family
From Student
Where Major = N'سخت افزار'
Intersect
Select Student.StudentID , Name , Family
From Student, Selection, Courses
where Student.StudentID = Selection.StudentID
	AND Selection.CourseID = Courses.CourseID
	AND CoType = N'نظری' ;
-- تمام رکوردهایی که در مجموعه اول وجود دارند ولی در مجموعه دوم وجود ندارند، برمی‌گرداند. به عبارت دیگر، آن‌ها را از مجموعه اول "استثنا" می‌کند.
Select StudentID , Name , Family
From Student
Where Major = N'سخت افزار'
EXCEPT 
Select Student.StudentID , Name , Family
From Student, Selection, Courses
where Student.StudentID = Selection.StudentID
	AND Selection.CourseID = Courses.CourseID
	AND CoType = N'نظری' ;

-- 18 استفاده از گروپ بای به منظور گروه بندی بر اساسی مشخص
Select Name , Family, Sum(Selection.Grade) As [مجموع نمرات]
From Student , Selection
Where Student.StudentID = Selection.StudentID
Group By Name, Family
Order By Family;

-- 19 استفاده ی شرط در گروپ بای
-- شرط 1 
Select Name , Family , Sum (Selection.Grade) As [مجموع نمرات]
From Student , Selection 
Where Student.StudentID = Selection.StudentID 
Group By Name , Family 
Having Sum (Selection.Grade) > 25 
Order By Family;

-- شرط 2
Select Name , Family, Sum(Selection.Grade) As [مجموع نمرات]
From Student , Selection
Where Student.StudentID = Selection.StudentID
Group By Name, Family
Having Name = N'حسام'
Order By Family;

--نام دروسی را ارائه دهید که 4 بار توسط دانشجویان انتخاب شده باشد
Select CoTitle , Count (Selection.CourseID) As [تعداد انتخاب]
From Selection , Courses 
Where Selection.CourseID = Courses.CourseID 
Group By CoTitle 
Having Count (Selection.Grade) = 4 ;

-- 20 پشتیبان گیری از داده ها در یک جدول جدید و با قرار دادن داده هایی از قبل در جدول جدید و ... 

Select * Into Student_Backup
From Student;

-- 21 اگر دیتا بیس ذکر نشود ، در خود دیتابیس جدول مبدا ذخیره میشود.
SELECT * INTO TryDataBase.dbo.Student_Backup2
FROM Student;

--22ایجاد یک نسخه پشتیبان از جدول مورد نظر  در یک پایگاه داده جدید
CREATE DATABASE Backup_m

USE Backup_m; -- پایگاه داده مقصد را مشخص کنید
SELECT * INTO Students_Backup
FROM University.dbo.Student; -- پایگاه داده و جدول مبدأ را مشخص کنید

--23 لیست دانشجویانی که نمره آنها بیش از 17 است را در جدول جدید
USE University  -- پایگاه داده مقصد را مشخص کنید
Select * Into Highscores1 
From Student 
where Grade > 17 ;

/*مشخصات نام ، نام خانوادگی ، نام درس و نمره دانشجویانی که در جدول انتخاب واحد ، نمره آنها بیش
از 15 بوده را در یک جدول جدید*/
USE University  -- پایگاه داده مقصد را مشخص کنید
Select Name , Family , CoTitle , Selection.Grade Into Highgrades2 
From Student , Selection , Courses 
Where Student.StudentID = Selection.StudentID 
AND Selection.CourseID = Courses.CourseID 
AND Selection.Grade > 15 ;


