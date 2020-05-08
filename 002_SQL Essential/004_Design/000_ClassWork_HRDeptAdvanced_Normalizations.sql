--------------- HR Department Advanced. Normalizations.----------------------

CREATE DATABASE HRDeptAdv
ON
(
	NAME = 'HRDeptAdv',
	FILENAME = 'd:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\HRDeptAdv.mdf',
	SIZE = 5 MB,
	MAXSIZE = 10 MB,
	FILEGROWTH = 5%
)
LOG ON
(
	NAME = 'LogHRDeptAdv',
	FILENAME = 'd:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\HRDeptAdv_Log.ldf',
	SIZE = 2 MB,
	MAXSIZE = 5 MB,
	FILEGROWTH = 2%
)
GO

EXEC sp_helpdb HRDeptAdv
GO

----------------------------------------------------------------
--					INITIAL DATA (COMMON TABLE)
----------------------------------------------------------------

USE HRDeptAdv
GO

CREATE TABLE HRDept
(
	ManagerId int NOT NULL,
	ManagerName varchar (40) NOT NULL,
	ManagerPosition varchar (20) NOT NULL,
	Salary SmallMoney NOT NULL,
	EmployeeId int NOT NULL,
	EmpName varchar (40) NOT NULL,
	Address1 varchar (70) NOT NULL,
	EmpSalary SmallMoney NOT NULL,
	Department varchar (30) NOT NULL,
	Position varchar (80) NOT NULL,
	HireDate date NOT NULL,
	DismissalDate date NULL,
	Vacations varchar (100) NOT NULL,
	Premium as Salary*0.25,
	Phone varchar (12) NOT NULL,
	Activity varchar (40) NOT NULL,
		CHECK (Phone LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
GO

EXEC sp_help HRDept
GO

SELECT * FROM HRDept
GO

CREATE TABLE Candidates
(
	CandidateId int NOT NULL PRIMARY KEY,
	ManagerId int NOT NULL,
	CandName varchar (40) NOT NULL,
	Age int NOT NULL,
	PreferredSalary SmallMoney NOT NULL
)
GO

SELECT * FROM Candidates
GO

INSERT HRDept
VALUES
(55, '���� �������� �������', '����������', 500, 123,'������ ���������� ������','������������� 4, �����', 500, '��������', '����������','2008-05-05', NULL,'25, 14', '(093)7984565','�������� ������������'),
(66, '�������� �������� ������', '������� ����������', 600, 124,'������� Ը������� ������','�������� 2, �����������-��-�����', 540, '����� �����', '����������','2009-08-15', NULL,'14, 7, 10, 5', '(050)9875454','����'),
(55, '���� �������� �������', '����������', 500, 156,'������ �������� ��������','������ 6, �����-���������', 700, '�����������', '����������� �������� ����������','2011-06-07', NULL,'5, 10', '(097)1234545','������������� ����'),
(66, '�������� �������� ������', '������� ����������', 600, 178,'������� ����������� ������','��������������� 56, ������', 800, '����� ���������', '���������','2012-12-05', NULL,'20, 10', '(063)5765565','������������� ������'),
(77, '����� ���������� �������', '�����������', 900, 156,'������ �������� ��������','������ 6, �����-���������', 700, '�����������', '����������� �������� ����������','2011-06-07', NULL,'7, 25', '(097)1234545','������������� ����'),
(88, '����� �������� ��������', '���������', 1000, 123,'������ ���������� ������','������������� 4, �����', 500, '��������', '����������','2008-05-05', NULL,'10, 15', '(093)7984565','�������� ������������'),
(88, '����� �������� ��������', '���������', 1000, 178,'������� ����������� ������','��������������� 56, ������', 800, '����� ���������', '���������','2012-12-05', NULL,'14, 11', '(063)5765565','������������� ������')
GO

INSERT Candidates
VALUES
(235, 55, '������� ��������� �������', 23, 300),
(247, 66, '������ ���������� �����', 22, 500),
(258, 77, '������� ���������� ��������', 21, 600)
GO

SELECT * FROM HRDept
SELECT * FROM Candidates
GO

----------------------------------------------------------------
--			   SEVERAL TABLES - NOT NORMALIZED
----------------------------------------------------------------

DROP TABLE HRDept
DROP TABLE Candidates
GO

USE HRDeptAdv
GO

-- ������� ����� ������� ���������: ����� ������ � ��� ��������� ��������, ���������� - ��������. ��������� ������� ��������.

CREATE TABLE HRDept
(
	ManagerId int NOT NULL
		PRIMARY KEY,
	ManagerName varchar (40) NOT NULL,
	ManagerPosition varchar (20) NOT NULL,
	Salary SmallMoney NOT NULL,
)
GO

CREATE TABLE Employees
(
	EmployeeId int NOT NULL
		PRIMARY KEY,
	EmpName varchar (40) NOT NULL,
	Address1 varchar (70) NOT NULL,
	EmpSalary SmallMoney NOT NULL,
	Department varchar (30) NOT NULL,
	Position varchar (80) NOT NULL,
	HireDate date NOT NULL,
	Premium as EmpSalary * 0.25,
	Phone varchar (12) NOT NULL,
	Activity varchar (40) NOT NULL,
		CHECK (Phone LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
GO

--CREATE TABLE HRDeptEmployees
--(
--	ManagerId int NOT NULL
--		FOREIGN KEY REFERENCES HRDept (ManagerId),
--	EmployeeId int NOT NULL
--		FOREIGN KEY REFERENCES Employees (EmployeeId),
--		PRIMARY KEY (ManagerId, EmployeeId)
--)
--GO

CREATE TABLE Vacations
(
	ManagerId int NOT NULL
		FOREIGN KEY REFERENCES HRDept (ManagerId),
	EmployeeId int NOT NULL
		FOREIGN KEY REFERENCES Employees (EmployeeId),
	Vacations varchar (100) NOT NULL,
		PRIMARY KEY (ManagerId, EmployeeId)
)
GO

CREATE TABLE Candidates
(
	CandidateId int NOT NULL 
		PRIMARY KEY,
	ManagerId int NOT NULL 
		FOREIGN KEY REFERENCES HRDept (ManagerId),
	CandName varchar (40) NOT NULL,
	Age int NOT NULL,
	PreferredSalary SmallMoney NOT NULL
)
GO

INSERT HRDept
VALUES
(55, '���� �������� �������', '����������', 500),
(66, '�������� �������� ������', '������� ����������', 600),
(77, '����� ���������� �������', '�����������', 900),
(88, '����� �������� ��������', '���������', 1000)
GO

INSERT Employees
VALUES
(123, '������ ���������� ������','������������� 4, �����', 500, '��������', '����������','2008-05-05', '(093)7984565','�������� ������������'),
(124, '������� Ը������� ������','�������� 2, �����������-��-�����', 540, '����� �����', '����������','2009-08-15', '(050)9875454','����'),
(156, '������ �������� ��������','������ 6, �����-���������', 700, '�����������', '����������� �������� ����������','2011-06-07', '(097)1234545','������������� ����'),
(178, '������� ����������� ������','��������������� 56, ������', 800, '����� ���������', '���������','2012-12-05', '(063)5765565','������������� ������')
GO

--INSERT HRDeptEmployees
--VALUES
--(55, 123),
--(66, 124),
--(55, 156),
--(66, 178),
--(77, 156),
--(88, 123),
--(88, 178)
--GO

INSERT Vacations
VALUES
(55, 123, '25, 14'),
(66, 124, '14, 7, 10, 5'),
(55, 156, '5, 10'),
(66, 178, '20, 10'),
(77, 156, '7, 25'),
(88, 123, '10, 15'),
(88, 178, '14, 11')
GO

INSERT Candidates
VALUES
(235, 55, '������� ��������� �������', 23, 300),
(247, 66, '������ ���������� �����', 22, 500),
(258, 77, '������� ���������� ��������', 21, 600)
GO

SELECT * FROM HRDept
SELECT * FROM Employees
--SELECT * FROM HRDeptEmployees
SELECT * FROM Candidates
SELECT * FROM Vacations
GO

----------------------------------------------------------------
--					1-ST NORMAL FORM
----------------------------------------------------------------

DROP TABLE Vacations

CREATE TABLE Vacations
(
	ManagerId int NOT NULL
		FOREIGN KEY REFERENCES HRDept (ManagerId),
	EmployeeId int NOT NULL
		FOREIGN KEY REFERENCES Employees (EmployeeId),
	ListedVacation int NOT NULL,
	Vacations varchar (100) NOT NULL,
		PRIMARY KEY (ManagerId, EmployeeId, ListedVacation)
)
GO

INSERT Vacations
VALUES
(55, 123, 1, '25'),
(55, 123, 2, '14'),
(66, 124, 1, '14'),
(66, 124, 2, '7'),
(66, 124, 3, '10'),
(66, 124, 4, '5'),
(55, 156, 1, '5'),
(55, 156, 2, '10'),
(66, 178, 1, '20'),
(66, 178, 2, '10'),
(77, 156, 1, '7'),
(77, 156, 2, '25'),
(88, 123, 1, '10'),
(88, 123, 2, '15'),
(88, 178, 1, '14'),
(88, 178, 2, '11')
GO

SELECT * FROM HRDept
SELECT * FROM Employees
SELECT * FROM Candidates
SELECT * FROM Vacations
GO


----------------------------------------------------------------
--					2-ND NORMAL FORM
----------------------------------------------------------------

--All tables are already in 2-nd normal form

----------------------------------------------------------------
--					3-RD NORMAL FORM
----------------------------------------------------------------
-- ������ ���� �������� ��������������� (����� �������, ����� ����������� ������� ������, ������� �� � ��������� �������...)
-- ������ ����� ���������� � �������� ������ �����.

DROP TABLE Vacations
DROP TABLE Employees
GO

CREATE TABLE Employees
(
	EmployeeId int NOT NULL
		PRIMARY KEY,
	EmpName varchar (40) NOT NULL,
	Address1 varchar (70) NOT NULL,
	EmpSalary SmallMoney NOT NULL,
	Department varchar (30) NOT NULL,
	Position varchar (80) NOT NULL,
	HireDate date NOT NULL,
	Premium money NULL,
	Phone varchar (12) NOT NULL,
	Activity varchar (40) NOT NULL,
		CHECK (Phone LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
GO

CREATE TABLE Vacations
(
	ManagerId int NOT NULL
		FOREIGN KEY REFERENCES HRDept (ManagerId),
	EmployeeId int NOT NULL
		FOREIGN KEY REFERENCES Employees (EmployeeId),
	ListedVacation int NOT NULL,
	Vacations varchar (100) NOT NULL,
		PRIMARY KEY (ManagerId, EmployeeId, ListedVacation)
)
GO

INSERT Employees
VALUES
(123, '������ ���������� ������','������������� 4, �����', 500, '��������', '����������','2008-05-05', 125, '(093)7984565','�������� ������������'),
(124, '������� Ը������� ������','�������� 2, �����������-��-�����', 540, '����� �����', '����������','2009-08-15', 135, '(050)9875454','����'),
(156, '������ �������� ��������','������ 6, �����-���������', 700, '�����������', '����������� �������� ����������','2011-06-07', 175, '(097)1234545','������������� ����'),
(178, '������� ����������� ������','��������������� 56, ������', 800, '����� ���������', '���������','2012-12-05', 200, '(063)5765565','������������� ������')
GO

INSERT Vacations
VALUES
(55, 123, 1, '25'),
(55, 123, 2, '14'),
(66, 124, 1, '14'),
(66, 124, 2, '7'),
(66, 124, 3, '10'),
(66, 124, 4, '5'),
(55, 156, 1, '5'),
(55, 156, 2, '10'),
(66, 178, 1, '20'),
(66, 178, 2, '10'),
(77, 156, 1, '7'),
(77, 156, 2, '25'),
(88, 123, 1, '10'),
(88, 123, 2, '15'),
(88, 178, 1, '14'),
(88, 178, 2, '11')
GO

SELECT * FROM HRDept
SELECT * FROM Employees
SELECT * FROM Candidates
SELECT * FROM Vacations
GO

-----------WASTE------------
--		   WASTE				
----------------------------
----------------------------------------------------------------
--					1-ST NORMAL FORM
----------------------------------------------------------------


--(123, 55, '������ ���������� ������','������������� 4, �����', 500, '��������', '����������','2008-05-05', '25', '(093)7984565','�������� ������������'),
--(123, 55, '������ ���������� ������','������������� 4, �����', 500, '��������', '����������','2008-05-05', '14', '(093)7984565','�������� ������������'),
--(123, 88, '������ ���������� ������','������������� 4, �����', 500, '��������', '����������','2008-05-05', '10', '(093)7984565','�������� ������������'),
--(123, 88, '������ ���������� ������','������������� 4, �����', 500, '��������', '����������','2008-05-05', '15', '(093)7984565','�������� ������������'),
--(124, 66, '������� Ը������� ������','�������� 2, �����������-��-�����', 540, '����� �����', '����������','2009-08-15', '14', '(050)9875454','����'),
--(124, 66, '������� Ը������� ������','�������� 2, �����������-��-�����', 540, '����� �����', '����������','2009-08-15', '7', '(050)9875454','����'),
--(124, 66, '������� Ը������� ������','�������� 2, �����������-��-�����', 540, '����� �����', '����������','2009-08-15', '10', '(050)9875454','����'),
--(124, 66, '������� Ը������� ������','�������� 2, �����������-��-�����', 540, '����� �����', '����������','2009-08-15', '5', '(050)9875454','����'),
--(156, 55, '������ �������� ��������','������ 6, �����-���������', 700, '�����������', '����������� �������� ����������','2011-06-07', '5', '(097)1234545','������������� ����'),
--(156, 55, '������ �������� ��������','������ 6, �����-���������', 700, '�����������', '����������� �������� ����������','2011-06-07', '10', '(097)1234545','������������� ����'),
--(156, 77, '������ �������� ��������','������ 6, �����-���������', 700, '�����������', '����������� �������� ����������','2011-06-07', '7', '(097)1234545','������������� ����'),
--(156, 77, '������ �������� ��������','������ 6, �����-���������', 700, '�����������', '����������� �������� ����������','2011-06-07', '25', '(097)1234545','������������� ����'),
--(178, 66, '������� ����������� ������','��������������� 56, ������', 800, '����� ���������', '���������','2012-12-05', '20', '(063)5765565','������������� ������'),
--(178, 66, '������� ����������� ������','��������������� 56, ������', 800, '����� ���������', '���������','2012-12-05', '10', '(063)5765565','������������� ������'),
--(178, 88, '������� ����������� ������','��������������� 56, ������', 800, '����� ���������', '���������','2012-12-05', '14', '(063)5765565','������������� ������'),
--(178, 88, '������� ����������� ������','��������������� 56, ������', 800, '����� ���������', '���������','2012-12-05', '11', '(063)5765565','������������� ������')