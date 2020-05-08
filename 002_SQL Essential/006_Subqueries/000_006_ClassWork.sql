-- ��������������� �������: 1. �������� ���������� �� ���������� �������� ������ ������ � ������� �������� (�� �������� � ��������)
--							2. ������� ����� ���� ������ �� ������� �� �������
--							3. ������� ����� ���������� ������ �� ������� �� ����������
--							4. ������� ���������� ������ �� �������
--							5. �������� ���� ������� �� ������� �� �����������
--							6. ������� ��� �� ��������� ����� ����������� �����������.

--							++ ������ ��� ��������.

USE ShopDB
GO

SELECT * FROM Orders
SELECT * FROM OrderDetails
GO

						-- 1. �������� ���������� �� ���������� �������� ������ ������ � ������� �������� (�� �������� � ��������)
SELECT Qty, (SELECT [Description] FROM Products WHERE OrderDetails.ProdID = Products.ProdID) AS ProductName, 
	(SELECT LName FROM Customers WHERE Customers.CustomerNo = (SELECT CustomerNo FROM Orders WHERE OrderDetails.OrderID = Orders.OrderID)) AS CustomerLastName
		FROM OrderDetails
			ORDER BY Qty DESC
GO
-- ����� �� ��������� ������������� ���, ����� �������� ������� ����� ���� ������� ������ �� ������ ������������ ������. �.�., �� ���������� ��������� � ����������� SELECT ���� ����� �� ������ - �� ������ ������������, ���� �� �����...

-- ����� �����:
SELECT (SELECT [Description] FROM Products WHERE Products.ProdID = OrderDetails.ProdID) AS 'Name Of Product', Qty
	FROM OrderDetails
	ORDER BY Qty DESC
GO

-- � ���� �������������, ����� ���:
CREATE TABLE #GoodsTotalSold	--��������� �������
(
	[Description] varchar (40),
	Qty int
)
GO

SELECT (SELECT [Description] FROM Products WHERE Products.ProdID = OrderDetails.ProdID) as Name, Qty
	INTO GoodsTotalSold
	FROM OrderDetails
	ORDER BY Qty DESC
GO

SELECT Name, SUM (Qty) as Total 
FROM GoodsTotalSold
GROUP BY Name
ORDER BY Total DESC
GO

-- ��� ���:
WITH GoodsSold ([Description], Qty) AS		--���������� ��������� ���������
(
SELECT (SELECT [Description] FROM Products WHERE Products.ProdID = OrderDetails.ProdID), Qty
	FROM OrderDetails
)
SELECT [Description], SUM (Qty) as Total
	FROM GoodsSold
	GROUP BY [Description]
	ORDER BY Total DESC
GO

						-- 2. ������� ����� ���� ������ �� ������� �� �������
CREATE TABLE #TempProductSales	--��������� ��������� �������
(
	Name varchar (40) NOT NULL,
	TotalPrice money NOT NULL
)
GO

SELECT (SELECT [Description] FROM Products WHERE 
		OrderDetails.ProdID = Products.ProdID) AS [Description], --����� ����������.
		TotalPrice
	INTO TempProductSales
		FROM OrderDetails
GO

SELECT [Description], SUM(TotalPrice) AS TotalPrice
	FROM TempProductSales
		GROUP BY [Description]
GO

						-- 3. ������� ����� ���������� ������ �� ������� �� ����������
WITH TotalEmpPrices (FName, LName, Qty, TotalPrice) AS		--��������� ���������� ��������� ���������.
(
SELECT (SELECT FName FROM Employees 
		WHERE EmployeeID = (
							SELECT EmployeeID FROM Orders	
							WHERE Orders.OrderID = OrderDetails.OrderID)
							)AS FName,
	   (SELECT LName FROM Employees 
		WHERE EmployeeID = (
							SELECT EmployeeID FROM Orders	
							WHERE Orders.OrderID = OrderDetails.OrderID)
							)AS FName,
							Qty,
							TotalPrice
FROM OrderDetails
)
SELECT FName, LName, SUM(Qty) AS OverallQuantity, SUM (TotalPrice) as TotalPrice
	FROM TotalEmpPrices
	GROUP BY FName, LName
GO
--������� ������ �� ���, ��� ��������, � �� ���������� NULL �� ���, ��� �� �������� (��� ��� ����� ���� �� ������� � ������� JOINs). � ���� ������ ������� (� NULL) �� ����� -
--���������� � ���������, ��� ��������� ������� ���������� ������ - ���, ��� ������ ������������ ������ ���� ��������. ������� ������� ������. ������� � ��������� �������� -
--��� ����� ��, ��� � ��������� ����. ����, ��� � ����� ������� �� ���������� ��������� - � ������� ���. (more than 1 value is not permitted when the subquery is used as an 
--expression...)

--WITH SalesByManagers (Qty, TotalPrice, OrderID, FName, LName) AS
--(
--SELECT Qty, TotalPrice, (SELECT OrderID FROM Orders
--						WHERE Orders.OrderID = OrderDetails.OrderID), (SELECT FName FROM Employees
--																		WHERE Employees.EmployeeID = Orders.EmployeeID)
--																		............ FAIL SOLUTION .............. �������� 3,5 ����
--FROM OrderDetails
--)

						-- 4. ������� ���������� ������ �� �������
WITH QuantityByCities (City, Qty) AS
(
SELECT (
		SELECT City FROM Customers WHERE
		CustomerNo = (
						SELECT CustomerNo FROM Orders WHERE
						Orders.OrderID = OrderDetails.OrderID
					  )
		) AS City, 
		Qty
FROM OrderDetails
)
SELECT City, SUM (Qty) FROM QuantityByCities
GROUP BY City
GO

						-- 5. �������� ���� ������� �� ������� �� �����������
SELECT OrderDate, (SELECT FName FROM Customers WHERE
							Customers.CustomerNo = Orders.CustomerNo) AS FirstName,
					(SELECT LName FROM Customers WHERE
							Customers.CustomerNo = Orders.CustomerNo) AS LastName
FROM Orders
GO -- ����� �� �������� ����������, �� ������� ������ ��� ���� �������.

-- ��� ���������� �������:
SELECT FName, MName, LName, 
							(SELECT OrderDate FROM Orders
							WHERE Cust.CustomerNo = Orders.CustomerNo) 
FROM Customers AS Cust
GO

						-- 6. ������� ��� �� ��������� ����� ����������� �����������.
SELECT	(SELECT FName FROM Employees WHERE 
				Employees.EmployeeID = (SELECT EmployeeID FROM Orders WHERE
										Orders.CustomerNo = Customers.CustomerNo)) AS EmpFirstName,
		(SELECT LName FROM Employees WHERE 
				Employees.EmployeeID = (SELECT EmployeeID FROM Orders WHERE
										Orders.CustomerNo = Customers.CustomerNo)) AS EmpLastName,
		Customers.FName AS ClientFirstName,
		Customers.LName AS ClientLastName
FROM Customers
GO --����� ������� � ��� �����������, ������� �� ����������� �����.

--��� ����� ����������, ����������� � ���������� �������:
SELECT Orders.EmployeeID AS ID,
	(SELECT FName FROM Employees WHERE Employees.EmployeeID = Orders.EmployeeID) + ' ' +
	(SELECT LName FROM Employees WHERE Employees.EmployeeID = Orders.EmployeeID) AS 'Seller Who Serves',
	Orders.CustomerNo AS [No],
	(SELECT FName FROM Customers WHERE Customers.CustomerNo = Orders.CustomerNo) + ' ' +
	(SELECT LName FROM Customers WHERE Customers.CustomerNo = Orders.CustomerNo) AS 'Customer Served by Seller'
FROM Orders
GO