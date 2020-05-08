USE MyFunkDB
GO

SELECT * FROM Employees
SELECT * FROM PersonalInfo
SELECT * FROM SalaryAndPosition
GO

--1) �������� �� ������� Employees
DROP TRIGGER dbo.EmployeesPhoneOperatorAndPosition
GO

CREATE TRIGGER dbo.EmployeesPhoneOperatorAndPosition	--// ����� ��������� �����������
	ON dbo.Employees
	FOR INSERT, UPDATE, DELETE
AS
	IF EXISTS -- ��� INSERT, UPDATE
	(
		SELECT * FROM inserted 
			WHERE Phone LIKE '(044)' + '%' OR
			Phone LIKE '(057)' + '%'
	)
BEGIN
	RAISERROR ('� ������� ���������� ������� ������ ������ ��������� ����������, � �� ��������� ������',1,15)
	ROLLBACK TRAN
END
	ELSE
	IF EXISTS -- ��� DELETE - ��������� ������ � ������� ������ ������� - �� ��� ��������� ������� ����� ������ ������. ��� ������ ����� �������� ����� �������� ���� ������� � �� ��������� �� ��� �� ������ ������.
	(
		SELECT * FROM deleted
			WHERE LName = '����������'
	)
BEGIN
	RAISERROR ('� ������� ������ ������ ������� ������� ����������, � ���� "���������"...',1,15)
	ROLLBACK TRAN
END
GO 

--2) �������� �� ������� PersonalInfo
DROP TRIGGER dbo.PersonalInfoAgeAddress
GO

CREATE TRIGGER dbo.PersonalInfoAgeAddress
	ON PersonalInfo
	FOR INSERT, UPDATE, DELETE
AS
	IF EXISTS -- ��� INSERT
	(
	SELECT * FROM inserted
		WHERE BirthDate > '1994-01-01' -- ������ ������ ���������� ������ 1994-01-01
	)
BEGIN
	RAISERROR ('�� ����������� �� ������ ���������� ������ 22 ���',1,15)
	ROLLBACK TRAN
END
	IF EXISTS -- ��� INSERT, UPDATE
	(
	SELECT * FROM inserted  
		WHERE Adress LIKE '��������' + '%' -- ������ ������ �����, ���������� �������� ����� ��������
	)
BEGIN
	RAISERROR ('����� ���������� ������� ����� �� �����. ���������� ������ ������ � �����������',1,15)
	ROLLBACK TRAN SavePointPersonalInfoTableIsDone -- ����� � ����� ����������	// (������� ���������� �������... � ���� �� ����� ����� ����������?)
END
	IF EXISTS -- ��� DELETE
	(
	SELECT * FROM deleted
		WHERE BirthDate > '1956-01-01'	-- ������ ��������� ����������� � ���������, ������ �����������
	)
BEGIN
	RAISERROR ('������ ��������� ����������� ���� ����������� ��������',1,15)
	ROLLBACK TRAN SavePointPersonalInfoTableIsDone
END
GO

--3) �������� ��� ������� SalaryAndPosition
DROP TRIGGER dbo.SalaryAndPositionBigSalaryDirector
GO

CREATE TRIGGER dbo.SalaryAndPositionBigSalaryDirector
	ON SalaryAndPosition
	FOR INSERT, UPDATE, DELETE
AS
	IF EXISTS --for INSERT, UPDATE
	(
		SELECT * FROM inserted
		WHERE Salary > 1500
	)
BEGIN
	RAISERROR ('������ �������� ������� ������ ��� ���������� - ������ 1500 ��������� ������',1,15)
	ROLLBACK TRAN SavePointPersonalInfoIsDone	--// (������� ���������� �������... � ���� �� ����� ����� ����������?)
END
	IF EXISTS --for DELETE
	(
		SELECT * FROM deleted
		WHERE Position = '������� ��������'
	)
BEGIN
	RAISERROR ('������ ������� ������ ���������', 1, 15)
	ROLLBACK TRAN SavePointPersonalInfoIsDone	--// (������� ���������� �������... � ���� �� ����� ����� ����������?)
END
GO