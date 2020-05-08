USE ShopDB
GO

SELECT * FROM Customers
SELECT * FROM Employees
SELECT * FROM OrderDetails
SELECT * FROM Orders
SELECT * FROM Products
GO

-- ��������������� �������: 1. �������� ���������� �� ���������� �������� ������ ������ � ������� �������� (�� �������� � ��������)

SELECT Qty, OrderDetails.ProdID, [Description], Orders.CustomerNo, Customers.FName, Customers.LName, Orders.EmployeeID, Employees.FName, Employees.LName FROM 
									OrderDetails
									JOIN
									Products
ON OrderDetails.ProdID = Products.ProdID
									JOIN
									Orders
ON OrderDetails.OrderID = Orders.OrderID
									JOIN
									Employees
ON Orders.EmployeeID = Employees.EmployeeID
									JOIN
									Customers
ON Orders.CustomerNo = Customers.CustomerNo
ORDER BY Qty
GO 

-- ��� ��������... ��� ���, ����������:
SELECT [Description],  SUM (OrderDetails.Qty) as TotalQuantity FROM
									Products
									JOIN
									OrderDetails
ON Products.ProdID = OrderDetails.ProdID
GROUP BY [Description]
ORDER BY TotalQuantity DESC
GO
		
--							2. ������� ����� ���� ������ �� ������� �� �������

SELECT SUM(Qty) AS Quantity, Products.UnitPrice, SUM(TotalPrice) AS '-=!!! Total Price !!!=-', OrderDetails.ProdID, Products.[Description] FROM 
										OrderDetails
										JOIN
										Products
ON OrderDetails.ProdID = Products.ProdID
GROUP BY OrderDetails.ProdID, [Description], Products.UnitPrice
GO

-- ����� ��������. � �� ���������... ��� ����� (� ����������):
SELECT [Description], SUM (TotalPrice) as '-=! Total Price !=-' FROM
							Products
							LEFT JOIN
							OrderDetails
ON Products.ProdID = OrderDetails.ProdID
GROUP BY [Description]
GO

--							3. ������� ����� ���������� ������ �� ������� �� ����������

SELECT Employees.EmployeeID, Employees.FName, Employees.LName, SUM(Qty) AS 'Quantity Of Sales' FROM
										OrderDetails
										JOIN
										Orders
ON OrderDetails.OrderID = ORDERS.OrderID
										RIGHT OUTER JOIN
										Employees
ON ORDERS.EmployeeID = Employees.EmployeeID
GROUP BY	Employees.EmployeeID, 
			Employees.FName, 
			Employees.LName
GO
-- �� ���������...

-- ��� � �������� �� �� �����, ������ ������ ���������� - ����� ����� ������:
SELECT FName, LName, SUM (TotalPrice) AS 'Total Sales ($)' FROM
						Employees
						LEFT JOIN
						Orders
ON Employees.EmployeeID = Orders.EmployeeID
						LEFT JOIN
						OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
GROUP BY FName, LName
GO

--							4. �������� ���� ������� �� ������� �� �����������

SELECT Customers.CustomerNo, Customers.FName, Customers.LName, Customers.Phone, OrderDate FROM
							Customers
							LEFT OUTER JOIN
							Orders
ON Customers.CustomerNo = orders.CustomerNo
GO
-- �� ���������, �� ���������� ������� ����� ���������.

--							5. ������� ��� �� ��������� ����� ����������� �����������.

SELECT Employees.EmployeeID, Employees.FName, Employees.LName, Customers.FName AS 'Customer First Name', Customers.LName AS 'Customer Last Name' FROM
							Employees
							LEFT OUTER JOIN
							Orders
ON Employees.EmployeeID = Orders.EmployeeID
							FULL JOIN
							Customers
ON Orders.CustomerNo = Customers.CustomerNo
GO
