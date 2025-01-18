-- Step 1: Create the database and tables for the online restaurant
CREATE DATABASE OnlineRestaurant;
USE OnlineRestaurant;

-- Table for managing customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15),
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table for managing menu items
CREATE TABLE MenuItems (
    MenuItemID INT PRIMARY KEY,
    Name VARCHAR(100),
    Price DECIMAL(10, 2),
    Category VARCHAR(50)
);

-- Table for managing orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Table for order details
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    MenuItemID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (MenuItemID) REFERENCES MenuItems(MenuItemID)
);

-- Insert data into Customers table
BULK INSERT Customers
FROM 'C:\customers.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

-- Insert data into MenuItems table
BULK INSERT MenuItems
FROM 'C:\menu_items.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

-- Insert data into Orders table
BULK INSERT Orders
FROM 'C:\orders.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

-- Insert data into OrderDetails table
BULK INSERT OrderDetails
FROM 'C:\order_details.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

-- اجرای کوئری بدون ایندکس 
SELECT * FROM Orders
WHERE CustomerID = 6;
--اجرای کوئری با Non-Clustered Index:
CREATE NONCLUSTERED INDEX IX_CustomerID ON Orders (CustomerID);
-- کوئری
SELECT * FROM Orders WHERE CustomerID = 8;
--اجرای کوئری با Clustered Index
DROP INDEX IX_CustomerID ON Orders;
CREATE CLUSTERED INDEX IX_OrderID1 ON Orders (OrderID);
--اجرای همان کوئری
SELECT * FROM Orders WHERE CustomerID = 8;
--اجرای کوئری با Clustered و Non-Clustered Index و ستون‌های Include شده
CREATE NONCLUSTERED INDEX IX_CustomerID_WithInclude 
ON Orders (CustomerID) INCLUDE (OrderDate, TotalAmount);
--اجرای کوئری
SELECT CustomerID, OrderDate, TotalAmount FROM Orders WHERE CustomerID = 8;

-- 5 پرسجو
--تعداد سفارش‌های هر مشتری:
SELECT CustomerID, COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY CustomerID;

--محصولات پرفروش:  
SELECT MenuItemID, SUM(Quantity) AS TotalSold
FROM OrderDetails
GROUP BY MenuItemID
ORDER BY TotalSold DESC;

--مجموع درآمد فروشگاه:
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders;

--مشاهده جزئیات سفارش یک مشتری خاص:
SELECT o.OrderID, od.MenuItemID, od.Quantity, od.Price
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE o.CustomerID = 8;

--تعداد سفارش‌های ثبت‌شده در هر روز:
SELECT CAST(OrderDate AS DATE) AS OrderDay, COUNT(OrderID) AS DailyOrders
FROM Orders
GROUP BY CAST(OrderDate AS DATE);


--سوال 5: نوشتن تریگر
--ایجاد جدول برای نگهداری تعداد فاکتورها:
CREATE TABLE CustomerInvoiceCount (
    CustomerID INT PRIMARY KEY,
    InvoiceCount INT DEFAULT 0
);
--نوشتن تریگر:
CREATE TRIGGER trg_UpdateInvoiceCount
ON Orders
AFTER INSERT
AS
BEGIN
    -- به‌روزرسانی تعداد فاکتورها
    MERGE CustomerInvoiceCount AS Target
    USING (SELECT CustomerID FROM Inserted) AS Source
    ON Target.CustomerID = Source.CustomerID
    WHEN MATCHED THEN
        UPDATE SET InvoiceCount = InvoiceCount + 1
    WHEN NOT MATCHED THEN
        INSERT (CustomerID, InvoiceCount) VALUES (Source.CustomerID, 1);
END;



