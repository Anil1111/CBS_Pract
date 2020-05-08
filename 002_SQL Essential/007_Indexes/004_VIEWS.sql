USE MyJoinsDB
GO

SELECT * FROM Employees
SELECT * FROM PersonalInfo
SELECT * FROM SalaryPosition
GO

-- 1. ���������� ������ ���������� ������ ����������� (������ ���������, ����� ����������). 
CREATE VIEW ContactData
AS SELECT FName, LName, Phone, [Address]
	FROM Employees
		INNER JOIN
		PersonalInfo
ON Employees.EmployeeID = PersonalInfo.EmployeeID
GO

SELECT * FROM ContactData
GO

-- 2. ���������� ������ ���������� � ���� �������� ���� �� ������� ����������� � ������ ��������� ���� �����������.
CREATE VIEW NotMarried
AS SELECT FName, LName, MarriageStatus, BirthDate, Phone
	FROM Employees as e
		JOIN
		PersonalInfo as p
ON e.EmployeeID = p.EmployeeID
	WHERE MarriageStatus = '�� �����' OR MarriageStatus = '�� �������'
GO

SELECT * FROM NotMarried
GO

-- 3. ���������� ������ ���������� � ���� �������� ���� ����������� � ���������� �������� � ������ ��������� ���� �����������. 
CREATE VIEW Managers
WITH SCHEMABINDING
AS SELECT FName, LName, Position, BirthDate, Phone
		FROM dbo.Employees as e		-- ���������������� ��������� ����� ������� � ������� ������� �������������.	// ����������� ���������! ��� ������������� WITH SCHEMABINDING. ����� ������ ������: Cannot schema bind view 'Managers' because name 'Employees' is invalid for schema binding. Names must be in two-part format and an object cannot reference itself.
			JOIN
			dbo.PersonalInfo as p
ON e.EmployeeID = p.EmployeeID
			JOIN
			dbo.SalaryPosition as s
ON p.EmployeeID = s.EmployeeID
WHERE Position = '��������'
GO

SELECT * FROM Managers
GO

UPDATE Employees	-- ����� ������������ DML, � �� DDL. � ������� ��������� - ������� ALTER TABLE...
SET LName = '����' 
WHERE FName = '����';
GO					-- ����� �������, ��� 'WITH SCHEMABINDING' �������� ������ ������ � �������, ������� ����� � ������. ������ ������ ������� �. 

SELECT * FROM Managers
GO

-- �������:
UPDATE Employees	
SET LName = '������' 
WHERE FName = '����';
GO					

DROP TABLE PersonalInfo	-- ������. Cannot DROP TABLE 'PersonalInfo' because it is being referenced by object 'Managers'. (��������� SCHEMABINDING).

-----------------------------------------------------------------------------------------------------------------------------------
--		�������� ���������� ������� � �����	- ����� �� ��������� ������ � �������������, ���� ��� ������ �� ���������� ��������.
-----------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Managers
(FName, LName, Position, BirthDate, Phone)
VALUES
('Vasiliy', 'Pupkin', 'General Director', '1981-11-24', '(050)33322211')	-- ������: View or function 'Managers' is not updatable because the modification affects multiple base tables.
GO