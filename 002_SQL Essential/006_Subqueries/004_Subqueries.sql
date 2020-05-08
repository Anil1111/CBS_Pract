--������� 4  
--�������� ������� ��� ������ ��������� �������� ��� ����� �����:  
--1) ��������� ������ ���������� ������ ����������� (������ ���������, ����� ����������).  
--2) ��������� ������ ���������� � ���� �������� ���� �� ������� ����������� � ������ ��������� ���� �����������.  
--3) ��������� ������ ���������� � ���� �������� ���� ����������� � ���������� �������� � ������ ��������� ���� �����������. 

USE MyJoinsDB
GO

SELECT * FROM Employees
SELECT * FROM PersonalInfo
SELECT * FROM SalaryPosition

--1) ��������� ������ ���������� ������ ����������� (������ ���������, ����� ����������).  
SELECT FName,LName, Phone, (
							SELECT [Address] FROM PersonalInfo
							WHERE EmployeeID = Employees.EmployeeID
							) AS Adress
FROM Employees
GO

--2) ��������� ������ ���������� � ���� �������� ���� �� ������� ����������� � ������ ��������� ���� �����������.  
SELECT (SELECT FName FROM Employees WHERE
		Employees.EmployeeID = PersonalInfo.EmployeeID 
		) AS FName, 
		(SELECT LName FROM Employees WHERE
		Employees.EmployeeID = PersonalInfo.EmployeeID 
		) AS LName,
		MarriageStatus as 'Martial Status',
		BirthDate,
		(SELECT Phone FROM Employees WHERE
		Employees.EmployeeID = PersonalInfo.EmployeeID 
		) AS Phone
FROM PersonalInfo WHERE 
MarriageStatus IN ('�� �����', '�� �������')
GO

--3) ��������� ������ ���������� � ���� �������� ���� ����������� � ���������� �������� � ������ ��������� ���� �����������. 
SELECT	(SELECT FName FROM Employees WHERE
		EmployeeID = SalaryPosition.EmployeeID) AS FName,
		(SELECT LName FROM Employees WHERE
		�EmployeeID = SalaryPosition.EmployeeID) AS LName,	--����� ������������ ���������, �� ����� ������������ �����, ����� ������� ��������� ��� ��������.
		Position,
		(SELECT BirthDate FROM PersonalInfo WHERE
		EmployeeID = (SELECT EmployeeID FROM Employees WHERE
					 EmployeeID = SalaryPosition.EmployeeID)
					 ) AS BirthDate,
		(SELECT Phone FROM Employees WHERE 
		EmployeeID = SalaryPosition.EmployeeID) AS Phone
FROM SalaryPosition WHERE
Position = '��������'
GO
