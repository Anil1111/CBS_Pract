USE MyFunkDB
GO

SELECT * FROM Employees
SELECT * FROM PersonalInfo
SELECT * FROM SalaryAndPosition
GO

-- Procedures:
-- 1) ��������� ������ ���������� ������ ����������� (������ ���������, ����� ����������). 
DROP PROC ContactsProc
GO

CREATE PROC ContactsProc
	@EmployeeID int = NULL
AS
	IF @EmployeeID IS NOT NULL
		SELECT FName, LName, Phone, Adress
		FROM Employees emp
			JOIN
			PersonalInfo [pi]
		ON emp.EmployeeID = [pi].EmployeeID
		WHERE emp.EmployeeID = @EmployeeID
	ELSE
	SELECT FName, LName, Phone, Adress
		FROM Employees emp
			JOIN
			PersonalInfo [pi]
		ON emp.EmployeeID = [pi].EmployeeID
GO

EXEC ContactsProc 5
GO

-- 2) ��������� ������ ���������� � ���� �������� ���� �� ������� ����������� � ������ ��������� ���� �����������.
DROP PROC MarriageProc
GO

CREATE PROC MarriageProc
AS
	SELECT FName, LName, MartialStatus, BirthDate, Phone
	FROM Employees as e
		JOIN
		PersonalInfo as p
	ON e.EmployeeID = p.EmployeeID
	WHERE p.MartialStatus = '�� �����'
	OR p.MartialStatus = '�� �������'
GO

EXEC MarriageProc
GO

-- 3) ��������� ������ ���������� � ���� �������� ���� ����������� � ���������� �������� � ������ ��������� ���� �����������.
DROP PROC ManagersProc
GO

CREATE PROC ManagersProc
AS
BEGIN
	SELECT FName, LName, Position, BirthDate, Phone
	FROM PersonalInfo p
		JOIN
		Employees e
	ON p.EmployeeID = e.EmployeeID 
		JOIN
		SalaryAndPosition s
	ON e.EmployeeID = s.EmployeeID
	WHERE Position = '��������'

	PRINT '������ ����������� ���������� ����������'
	DECLARE @Count int
	
	SET @Count = 
	(SELECT COUNT (*)
	FROM PersonalInfo p
		JOIN
		Employees e
	ON p.EmployeeID = e.EmployeeID 
		JOIN
		SalaryAndPosition s
	ON e.EmployeeID = s.EmployeeID
	WHERE Position = '��������')

	RETURN @Count		-- ���� ����� ������ �������� PRINT ����� � �� ������ ����� ������� ������� � ����������� ���������� � �.�.
END
GO						-- // ��� ����� ��������� ������� �������...

EXEC ManagersProc
GO

DECLARE @MyVar int
EXEC @MyVar = ManagersProc
PRINT '���������� ����������� � ���������� �������� - ' + CAST(@MyVAR as varchar)+ ' �������(�)'
GO

-- Functions
-- 1) ��������� ������ ���������� ������ ����������� (������ ���������, ����� ����������). 
DROP FUNCTION ContactsFunc
GO

CREATE FUNCTION ContactsFunc (@Id int = NULL)
RETURNS @Result TABLE							-- ������ ���� ������������ ���������� ���������� ���� ������� ����� ��������� � ���� ��������� ������ � ����� BEGIN - END.
	(
	Fname varchar (40),
	Lname varchar (40),
	Phone varchar (12),
	[Address] varchar (40)
	)
AS
BEGIN
	IF @Id IS NULL
	INSERT @Result SELECT FName, LName, Phone, Adress	-- �������� ����� �� [Address] - � �� � � ����� �������� ������ ����������� ��� ����� ���� ��� �� ������. ���� �� ����������� �� ���� Adress (� ����� d).
				FROM Employees e
					JOIN
					PersonalInfo i
				ON e.EmployeeID = i.EmployeeID
	ELSE
	INSERT @Result SELECT FName, LName, Phone, Adress
				FROM Employees e
					JOIN
					PersonalInfo i
				ON e.EmployeeID = i.EmployeeID
				WHERE e.EmployeeID = @Id
RETURN	-- ���������� @Result �� �����, ����� ����� ������!
END
GO

SELECT * FROM dbo.ContactsFunc(default) -- ��� ��� ��� ��������, ����� � ������� ����������� �������������� ���������!
GO

SELECT * FROM dbo.ContactsFunc(5)
GO

-- 2) ��������� ������ ���������� � ���� �������� ���� �� ������� ����������� � ������ ��������� ���� �����������. 
DROP FUNCTION MarriageFunc
GO

CREATE FUNCTION MarriageFunc ()
RETURNS TABLE
AS 
	RETURN (SELECT FName, LName, MartialStatus, BirthDate, Phone
	FROM Employees as e
		JOIN
		PersonalInfo as p
	ON e.EmployeeID = p.EmployeeID
	WHERE p.MartialStatus = '�� �����'
	OR p.MartialStatus = '�� �������')
GO

SELECT * FROM dbo.MarriageFunc()
GO

-- 3) ��������� ������ ���������� � ���� �������� ���� ����������� � ���������� �������� � ������ ��������� ���� �����������.
DROP FUNCTION ManagersFunc
GO
DROP FUNCTION CountManagers
GO

CREATE FUNCTION ManagersFunc ()
RETURNS TABLE
AS
RETURN (SELECT FName, LName, Position, BirthDate, Phone
	FROM PersonalInfo p
		JOIN
		Employees e
	ON p.EmployeeID = e.EmployeeID 
		JOIN
		SalaryAndPosition s
	ON e.EmployeeID = s.EmployeeID
	WHERE Position = '��������')
GO

CREATE FUNCTION CountManagers ()	-- �������������� ������� ��� �������� ����������
RETURNS int
AS
BEGIN
	DECLARE @Count int
	
	SET @Count = 
	(SELECT COUNT (*)
	FROM dbo.ManagersFunc())
	RETURN @Count
END									-- � ��� � ���! (�� ������ ����, ��� ������ ���� ������� ���������� ���������� ���������� ���� �� ������� ����� ��������� ��������� ������ � ����� BEGIN-END). �����! �� ����� ���� ������� ����� ��������� ��������� ������ � ����� BEGIN-END � ����� ������, ���������� ������ �� ���� ��� �� ����������. ��� �������� ������� ����� �� ������ ��������� SELECT... ��� INSERT... ����� �� ����� ���� �����-�� ����������, �� ��� � �� ��������... ��� � ��� �������� ����������� ���� - �� ����� :)...
GO

SELECT * FROM dbo.ManagersFunc()
GO

PRINT '���������� ����������� � ���������� �������� - ' + CAST (dbo.CountManagers() as varchar)