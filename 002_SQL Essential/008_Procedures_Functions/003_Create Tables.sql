USE MyFunkDB
GO

CREATE TABLE Employees
(
	EmployeeID int IDENTITY NOT NULL
		PRIMARY KEY,
	FName varchar (40) NOT NULL,
	LName varchar (40) NOT NULL,
	Phone char (12) NOT NULL,
		CHECK (Phone LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
GO

CREATE TABLE SalaryAndPosition
(
	EmployeeID int NOT NULL
		PRIMARY KEY
		FOREIGN KEY REFERENCES Employees (EmployeeID),
	Salary smallmoney NOT NULL,
	Position varchar (40) NOT NULL
)
GO

CREATE TABLE PersonalInfo
(
	EmployeeID int NOT NULL
		PRIMARY KEY
		FOREIGN KEY REFERENCES Employees (EmployeeID),
	MartialStatus varchar (40) NOT NULL,
	BirthDate date NOT NULL,
	[Address] varchar (40) NOT NULL
)
GO

INSERT INTO Employees
VALUES
	('���������',	'��������',	'(093)9874545'),
	('����',	'������',	'(050)4542412'),
	('������',	'��������',	'(066)7874545'),
	('����',	'�����������',	'(097)2312424'),
	('����',	'�������',	'(099)5554447'),
	('�����',	'���������',	'(068)4457788'),
	('�������',	'������',	'(098)5547799'),
	('�����',	'�����������',	'(093)3215487'),
	('����',	'��������',	'(095)4856712'),
	('Jose',	'Del Villiar',	'(098)5557788')
GO

INSERT INTO	SalaryAndPosition
VALUES
	(1,1500,'������� ��������'),
	(2,700,	'��������'),
	(3,600,	'��������'),
	(4,500,	'��������'),
	(5,120,	'�������'),
	(6,140,	'�������'),
	(7,90,	'�������'),
	(8,130,	'�������'),
	(9,150,	'�������'),
	(10,100,'�������')

GO

INSERT INTO	PersonalInfo
VALUES
	(1,  '�����', '1968-05-05', '�������, 65'),
	(2,  '�� �����', '1975-06-06', '������� 45'),
	(3,  '�����', '1974-07-04', '��������, 23'),
	(4,  '�� �����', '1973-06-08', '������, 67'),
	(5,  '�������', '1985-03-04', '���������, 56'),
	(6,  '�� �������', '1987-07-12', '������, 4'),
	(7,  '�����', '1983-12-25', '��������, 9'),
	(8,  '�������', '1980-11-09', '���������, 8'),
	(9,  '�� �����', '1981-09-29', '�������������, 77'),
	(10, '�����', '1980-10-23', '˸������, 76')
GO

SELECT * FROM Employees
SELECT * FROM SalaryAndPosition
SELECT * FROM PersonalInfo
GO