--------------------------------Create DataBase-UniversityRegistration---------------------------------------
--------------------------------Create Tables-UniversityRegistration-----------------------------------------

Create DataBase UniversityRegistration

Use UniversityRegistration
Go

--Create Table-Subject_Course
Create Table Subjecttbl(
SubID INT Primary Key,
Subject NVarchar(50) Not Null,
);

--Create Table-Type_Course
Create Table Typetbl(
TypeID INT Primary Key,
Type NVarchar(50) Not Null, 
);

--Create Table-Course
Create Table Crstbl(
CID INT Primary Key,
CName Nvarchar(50) Not Null,
CUnit INT Not Null,
CType INT FOREIGN KEY REFERENCES Typetbl(TypeID),
);

--Create Table-Teacher
Create Table Teachertbl(
TID INT Primary Key,
TName NVarchar(35) Not Null,
TFamily NVarchar(45) Not Null,
TSubID INT FOREIGN KEY REFERENCES Subjecttbl(SubID),
);

--Create Table-Student
Create Table Stdtbl(
SID INT Primary Key ,
SName NVarchar(35) Not Null,
SFamily NVarchar(45) Not Null,
SSubID INT FOREIGN KEY REFERENCES Subjecttbl(SubID),
City NVarchar(25) Not NuLL,
);

--Create Table-Group
Create Table Grouptbl(    
GID INT Primary Key,
CID INT FOREIGN KEY REFERENCES Crstbl(CID),
TID INT FOREIGN KEY REFERENCES Teachertbl(TID),
Term INT Not Null,
Groupn INT Not Null,
);

--Create Table-Regesteration
Create Table Registertbl(
RID INT Primary Key,
GID INT FOREIGN KEY REFERENCES Grouptbl(GID),
SID INT FOREIGN KEY REFERENCES Stdtbl(SID),
Score Decimal Not Null,
);
--------------------------------Insert Value---------------------------------------
--Insert Value-----> Subject_Course
Insert Into Subjecttbl (SubID,Subject)
Values
	(1,N'مهندسی کامپیوتر'),
	(2,N'مهندسی عمران'),
	(3,N'مهندسی صنایع');

--Insert Value-----> Type_Course
Insert Into Typetbl (TypeID,Type)
Values
	(1,N'تئوری'),
	(2,N'عملی'),
	(3,N'تئوری-عملی');

--Insert Value-----> Course
Insert Into Crstbl (CID,CName,CUnit,CType)
Values
	(1310,N'مهندسی نرم افزار 1', 3 ,3 ),
	(1311,N'ریاضی 1', 3 ,1 ),
	(1312,N'ریاضی 2', 3 ,1 ),
	(1313,N'فیزیک 1', 3 ,1 ),
	(1314,N'بتن 1', 3 ,3 ),
	(1315,N'بتن 2', 3 ,3 ),
	(1316,N'پایگاه داده ها', 3 ,1 ),
	(1317,N'سیستم عامل', 3 ,1 ),
	(1318,N'ریاضی مهندسی', 3 ,1 ),
	(1319,N'آز مدار', 1 ,2 ),
	(1320,N'آز معماری', 1 ,2 ),
	(1321,N'تحقیق در عملیات', 3 ,2 ),
	(1322,N'آمار مهندسی', 3 ,1 );

--Insert Value-----> Teacher
Insert Into Teachertbl(TID,TName,TFamily,TSubID)
Values
	(1111,N'حمید',N'مسعودی',1),
	(1112,N'حسین',N'قربانی',1),
	(1113,N'علی',N'کریمی',3),
	(1114,N'علیرضا',N'جوادی',2),
	(1115,N'محمود',N'رضایی',2),
	(1116,N'محسن',N'صابری',3);

--Insert Value-----> Group
Insert Into Grouptbl(GID,CID,TID,Term,Groupn)
Values 
	(1,1310,1111,881,1),
	(2,1315,1114,881,1),
	(3,1316,1112,881,1),
	(4,1320,1113,881,1),
	(5,1311,1112,881,1),
	(6,1312,1114,881,1),
	(7,1317,1111,881,1),
	(8,1321,1112,881,1),
	(9,1313,1115,881,1),
	(10,1318,1116,881,2),
	(11,1314,1115,881,2),
	(12,1319,1116,881,2),
	(13,1320,1111,881,2),
	(14,1317,1112,881,2);

--Insert Value-----> Student
Insert Into Stdtbl (SID, SName, SFamily, SSubID, City)
Values
  (88001, N'وحید', N'نادري', 1 , N'اراک'),
  (88002, N'محمد', N'غلامی', 1 , N'تهران'),
  (88003,N'رسول',N'محمدی', 2 ,N'اراک'),
  (88004,N'علی',N'اکبری', 2 ,N'تبریز'),
  (88005,N'حسین',N'براتی', 1 ,N'مشهد'),
  (88006,N'زهرا',N'مجیدی', 3 ,N'اراک'),
  (88007,N'فاطمه',N'میرطاهری', 3 ,N'شیراز'),
  (88008,N'مریم',N'مرادی', 2 ,N'اراک');

--Insert Value-----> Registeration
Insert Into Registertbl(RID, GID, SID, Score)
Values
    (1, 1, 88001, 17),
    (2, 9, 88001, 8),
    (3, 11, 88001, 20),
    (4, 9, 88002, 13),
    (5, 11, 88002, 12),
    (6, 2, 88003, 15),
    (7, 3, 88003, 18),
    (8, 8, 88003, 17),
    (9, 8, 88004, 8),
    (10, 1, 88005, 8),
    (11, 9, 88005, 9),
    (12, 4, 88006, 14),
    (13, 8, 88006, 13),
    (14, 10, 88006, 16),
    (15, 8, 88007, 19),
    (16, 14, 88007, 20),
    (17, 13, 88006, 16),
    (18, 3, 88005, 19),
    (19, 6, 88008, 15),
    (20, 2, 88008, 19),
    (21, 3, 88008, 12);
--------------------------------Question-Answer-With-Query---------------------------------------
--1)
--Duplicate
Select City
From Stdtbl;
--Non-Duplicate
Select Distinct City
From Stdtbl;

--2)
-- ASC
Select *
From Stdtbl
Order By SFamily; -- ASC
-- DESC
Select *
From Stdtbl
Order By SFamily DESC;

--3)
Select *
From Stdtbl
Where City NOT IN (
			N'اراک', N'تهران');

--4)
SELECT *
FROM Teachertbl
WHERE Teachertbl.TName NOT IN (
				SELECT Stdtbl.SName
				FROM Stdtbl);
--OR
Select TName
From Teachertbl
Except
Select SName
From Stdtbl 
--OR
SELECT * 
FROM Teachertbl 
LEFT JOIN Stdtbl 
ON Teachertbl.tname = Stdtbl.sname
WHERE Stdtbl.sname IS NULL;

--5) 
Select C.CID
From Crstbl As C
Where C.CID NOT IN (
			Select G.CID 
			From Grouptbl AS G
			Where G.Term = 881);

--6)
Select T.TName
From Teachertbl AS T
Where T.TName In (
			Select S.SName
			From Stdtbl As S);
--OR
Select TName
From Teachertbl
Intersect
Select SName
From Stdtbl;

--7)
Select * 
From Stdtbl 
Where SID NOT IN (
			88002, 88003);

--8)
Select *
From Crstbl
Where CUnit = 3;

--9)
Select *
From Crstbl 
Where CName Like N'ر%'

--10)
Select *
From Stdtbl 
Where SFamily Like N'%ا%';

--11)
Select R.SID,R.Score,C.CID
From Crstbl AS C , Grouptbl AS G,Registertbl AS R
Where C.CID = G.CID
AND G.GID = R.GID
AND R.Score = 20;
--12)
Select R.SID,R.Score,C.CID
From Crstbl AS c,Grouptbl AS G,Registertbl AS R
Where C.CID = G.CID
AND G.GID = R.GID
AND R.Score Between 16 AND 20 ;

--13)
Select SID
From Registertbl
Where Score = 20 AND SID != 88001;

--14)
SELECT CID, CName, CUnit 
FROM Crstbl 
WHERE CID NOT IN (
    SELECT CID 
    FROM Grouptbl AS G 
    JOIN Registertbl As R ON G.gid = R.gid 
    WHERE R.SID = 88002 AND G.term = 881);
	
--OR
Select C.CID,C.CName,C.CUnit
From Crstbl AS C
			Where C.CID Not In (
			Select G.CID
			From Grouptbl AS G ,Registertbl AS R
			Where G.GID = R.GID
			AND R.SID = 88002 AND G.Term = 881);

--15)
SELECT S.sid, S.SName, S.SFamily,CID
FROM Stdtbl AS S
	JOIN Registertbl AS R ON S.sid = R.sid 
	JOIN Grouptbl AS G ON R.gid = G.gid 
	WHERE CID = 1313;
--OR
Select S.sid, S.SName, S.SFamily,G.CID
From Stdtbl AS S,Grouptbl AS G,Registertbl AS R
Where S.SID = R.SID
AND R.GID = G.GID
AND G.CID = 1313;

--16)
Select S.SID,S.SName,S.SFamily,G.CID
From Stdtbl AS S
	Join Registertbl AS R On R.SID = S.SID
	Join Grouptbl As G ON G.GID = R.GID
	Where G.CID!= 1315;

--17)
Select S.SID,S.SName,S.SFamily,G.Term,C.CType
From Stdtbl AS S
	Join Registertbl AS R ON R.SID = S.SID
	Join Grouptbl AS G ON G.GID = R.GID
	Join Crstbl AS C ON G.CID = C.CID
	Where G.Term = 881 AND C.CType=2;
--OR
Select S.SID,S.SName,S.SFamily,G.Term,C.CType
From Stdtbl AS S, Crstbl AS C,Grouptbl AS G , Registertbl AS R
Where S.SID=R.SID
AND R.GID = G.GID
AND G.CID = C.CID
AND G.Term = 881 AND C.CType=2;

--18)
Select C.CID,C.CName,C.CUnit,R.Score,R.SID
From Crstbl AS C
	Join Grouptbl AS G ON C.CID = G.CID
	Join Registertbl AS R On R.GID = G.GID
	Where R.SID = 88006 AND R.Score>=10;

--19)*
select C.CID,C.CName,C.CUnit,Count(R.SID) AS [تعداد دانشجویان] 
From Crstbl AS C
join Grouptbl AS G on C.CID = G.CID
join Registertbl AS R on R.GID = G.GID
where term = 881
group by C.CID,C.CName,C.CUnit
having Count(R.SID) > (
						select Count(R.SID) 
						From Registertbl AS R join Grouptbl AS G
						on R.GID = G.GID
						where CID = 1310);

--20)
SELECT C.CID, C.CName, C.CUnit
FROM Crstbl AS C
WHERE C.CUnit > (
				SELECT C2.CUnit
				FROM Crstbl AS C2
				WHERE C2.CID = 1319);

--21)
Select G.GID,C.CName
From Crstbl AS C
	Join Grouptbl As G ON G.CID = C.CID
	Join Teachertbl As T ON T.TID = G.TID
	Where T.TFamily = N'قربانی' AND G.Term = 881;

--22)
--Max-Score
Select Top(1) S.SID,S.SName,S.SFamily,R.Score
From Crstbl AS C
	Join Grouptbl AS G On C.CID = G.CID
	Join Registertbl AS R ON R.GID = G.GID
	Join Stdtbl As S ON S.SID = R.SID
	Where C.CName = N'بتن 2'
	order by R.Score DESC; 
--Min-Score
Select Top(1) S.SID,S.SName,S.SFamily,R.Score
From Crstbl AS C
	Join Grouptbl AS G On C.CID = G.CID
	Join Registertbl AS R ON R.GID = G.GID
	Join Stdtbl As S ON S.SID = R.SID
	Where C.CName = N'بتن 2'
	order by R.Score ASC;

--23)
Select R.SID,sum(C.CUnit) AS [جمع تعداد واحد گذرانده]
From Crstbl AS C
	Join Grouptbl AS G on C.CID = G.CID
	Join Registertbl AS R on R.GID = G.GID
	Where R.Score>=10
	Group By R.SID;

--24)
Select COUNT(R.SID) AS [تعداد دروس گذرانده]
From Registertbl AS R
	Where R.Score >=10 AND R.SID = 88007;
--OR
Select COUNT(G.CID)
From Grouptbl AS G
Join Registertbl AS R ON G.GID = R.GID
Where R.SID = 88007 AND R.Score >= 10;

--25)*
Select C.CID,C.CName,C.CUnit,COUNT(R.SID) AS [ تعداد دانشجویان ترم = 881 ]
From Crstbl AS C
Join Grouptbl AS G ON C.CID = G.CID
Join Registertbl AS R ON G.GID = R.GID
Where G.Term = 881
Group By C.CID,C.CName,C.CUnit;

--26)*
/*اگر هدف شما فقط یافتن شناسه درس‌هایی با کمتر از 3 دانشجو باشد، این کد کافی و ساده‌تر است.*/
Select C.CID,COUNT(R.SID) AS [تعداد دانشجویان]
From Crstbl As C
Join Grouptbl AS G ON C.CID = G.CID
Join Registertbl AS R ON G.GID = R.GID
Where G.Term = 881 
Group BY C.CID
Having COUNT(R.SID)<3;
/*اگر هدف شما این است که اطلاعات بیشتری در مورد درس‌ها (مانند نام و تعداد واحد) داشته باشید
و همچنین گروه‌هایی که هیچ دانشجویی ندارند را هم بررسی کنید، این کد انتخاب بهتری است.*/

/*Registertbl و  Grouptbl بین LEFT JOIN
گروه‌هایی که هیچ ثبت‌نامی ندارند نیز در نتیجه نشان داده می‌شوند.*/
Select C.CID,C.CName,C.CUnit,COUNT(R.SID) [تعداد دانشجویان]
From Crstbl As C
	Join Grouptbl AS G ON C.CID = G.CID
	LEFT JOIN Registertbl AS R ON G.GID = R.GID
	Where G.Term = 881
	Group By C.CID,C.CName,C.CUnit
	Having COUNT(R.SID) < 3;

--27)*
Select S.SID,S.SName,S.SFamily
From Stdtbl AS  S
Where S.SSubID = (Select SSubID
			   From Stdtbl
			   Where SID = 88008);

--28)
Select S.SID,S.SName,S.SFamily
From Stdtbl AS S
Where SID IN(Select SID
				From Registertbl AS R
				Join Grouptbl AS G On R.GID = G.GID
				Where G.CID IN(1319,1320) AND R.Score >=10);

--29)
Select Top(1) S.SID,S.SName,S.SFamily,R.Score,G.CID
From Stdtbl AS S
	Join Registertbl As R ON S.SID = R.SID
	Join Grouptbl AS G ON R.GID = R.GID
	Where G.CID = 1315 
	Order BY R.Score DESC;

--30)
Select  S.SID,S.SName,S.SFamily,C.CID,C.CName,R.Score,T.TName
From Registertbl AS R
	Join Stdtbl AS S ON R.SID = S.SID
	Join Grouptbl AS G ON R.GID = G.GID
	Join Crstbl AS C ON G.CID = C.CID
	Join Teachertbl AS T ON G.TID = T.TID
	Where G.Term = 881;

--31)*
Select Distinct T.TName,T.TID,T.TSubID
From Teachertbl AS T
Join Grouptbl AS G ON T.TID = G.TID
Join Registertbl AS R ON G.GID = R.GID
Where T.TFamily Not In(N'رضایی',N'قربانی') AND R.Score != 20;

--32)*
Select C.CID,C.CName,C.CUnit
From Crstbl AS C
Join Grouptbl AS G ON C.CID = G.CID 
Group By C.CID,C.CName,C.CUnit
Having COUNT(Distinct G.TID) > 1;

--33)
Select C.CID,C.CName,C.CUnit
From Crstbl AS C
Join Grouptbl AS G ON C.CID = G.CID
Group By C.CID,C.CName,C.CUnit
Having COUNT(G.GID) = 1;

--34)
Select G.CID,MAX(R.Score) AS [MAX-SCORE],MIN(R.Score) AS [MIN-SCORE]
From Registertbl AS R
	Join Grouptbl AS G ON R.GID = G.GID
	Group By G.CID;

--35)*
/*
1)
اگر می‌خواهید فقط دروسی که دانشجوی ثبت‌نام شده دارند نمایش داده شوند، پرس‌وجوی اول مناسب‌تر است
2)
اگر می‌خواهید همه دروس نمایش داده شوند، حتی آن‌هایی که دانشجوی ثبت‌نام شده ندارند، پرس‌وجوی دوم مناسب است
*/
--1)
Select C.CID,C.CName,C.CUnit,COUNT(DISTINCT R.SID) AS [Student-Count]
From Crstbl As C
	Join Grouptbl AS G ON C.CID = G.CID
	Join Registertbl AS R ON G.GID = R.GID
	Group By C.CID,C.CName,C.CUnit
--2)
Select C.CID,C.CName,C.CUnit,COUNT(DISTINCT R.SID) AS [Student-Count]
From Crstbl As C
	Join Grouptbl AS G ON C.CID = G.CID
	Left Join Registertbl AS R ON G.GID = R.GID
	Group By C.CID,C.CName,C.CUnit

--36)
Select C.CID,C.CName,C.CUnit,COUNT(R.RID) AS [Student-Count]
From Crstbl AS C
	Join Grouptbl AS G ON C.CID = G.CID
	Join Registertbl AS R ON G.GID = R.GID
	Group By C.CID,C.CName,C.CUnit
	Having COUNT(R.RID) >= 2;

--37)*
Select S.SID,S.SName,S.SFamily,CAST(SUM(R.Score * C.CUnit) AS FLOAT) / SUM(C.CUnit) AS [AVG-score]
From Registertbl AS R
	Join Grouptbl AS G ON R.GID = G.GID
	Join Crstbl AS C ON G.CID = C.CID
	Join Stdtbl AS S ON R.SID = S.SID
	Where G.Term = 881
	Group By S.SID,S.SName,S.SFamily;


