--S(Sn,Sname,City), P(Pn,Pname,color,weight), SP(Sn,Pn,Qty)
--Question
--1
SELECT P1.Pn, P1.Pname, P1.color, P1.weight
FROM P P1
JOIN P P2 ON P1.color = P2.color
WHERE P2.Pn = 2;

--2
CREATE PROCEDURE GetAverageProduction
    @ProducerID INT           -- شماره تولیدکننده
AS
BEGIN
    BEGIN TRANSACTION;
    
    -- محاسبه میانگین تولیدات تولیدکننده
    DECLARE @AverageProduction DECIMAL(10, 2);
    
    SELECT @AverageProduction = AVG(SP.Qty)
    FROM SP
    WHERE SP.Sn = @ProducerID;
    
    -- برگرداندن میانگین
    SELECT @AverageProduction AS AverageProduction;
    
    COMMIT TRANSACTION;
END;
GO

--3
SELECT S.Sname
FROM S
JOIN SP ON S.Sn = SP.Sn
WHERE SP.Pn = 2
GROUP BY S.Sn
ORDER BY SUM(SP.Qty) DESC
LIMIT 1;

--4
SELECT SP.Pn, COUNT(DISTINCT SP.Sn) AS ProducerCount
FROM SP
GROUP BY SP.Pn
HAVING COUNT(DISTINCT SP.Sn) > 2;

--5
SELECT P.Pn, P.Pname
FROM P
LEFT JOIN SP ON P.Pn = SP.Pn
WHERE SP.Pn IS NULL;
