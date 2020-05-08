USE HomeWork_004_Weapons
GO

-- �������� �������

DROP TABLE Armory
GO

CREATE TABLE Armory
(
	Name varchar (40) NOT NULL,
	Platoon int NOT NULL,
	Weapon varchar (20) NOT NULL,
	WeaponGiver varchar (40) NOT NULL
)
GO

INSERT Armory
VALUES
('������ �.�., ��.205', 222, '��-47', '����� �.�., �����'),
('������ �.�., ��.205', 222, '����20', '������� �.�., �����'),
('������� �.�., ��.221 ', 232, '��-74', '��������� �.�., ������������'),
('������� �.�., ��.221 ', 232, '����20', '������� �.�., �����'),
('�������� �.�., ��.201', 212, '��-47', '����� �.�., �����'),
('�������� �.�., ��.201', 212, '����20', '������� �.�., �����'),
('����� �.�.', 200, '��-47', '����� �.�., �����')
GO

SELECT * FROM Armory
GO

---------------------------------------------------------
--						  1 NF 						   --
---------------------------------------------------------

DROP TABLE Armory
DROP TABLE Soldiers
GO

-- ������� ������������� ������ (Platoon (�����))
CREATE TABLE Soldiers
(
	Soldier varchar (30) NOT NULL
		PRIMARY KEY,
	Platoon int NOT NULL
)
GO

CREATE TABLE Armory
(
	Soldier varchar (30) NOT NULL
		FOREIGN KEY REFERENCES Soldiers (Soldier)
				ON DELETE CASCADE
					ON UPDATE CASCADE,
	Weapon varchar (20) NOT NULL,
	WeaponGiver varchar (30) NOT NULL
)
GO

INSERT INTO Soldiers
VALUES
('������ �.�., ��.205', 222),
('������� �.�., ��.221', 232),
('�������� �.�., ��.201', 212),
('����� �.�.', 200)
GO

INSERT INTO Armory
VALUES
('������ �.�., ��.205', '��-47', '����� �.�., �����'),
('������ �.�., ��.205', '����20', '������� �.�., �����'),
('������� �.�., ��.221 ', '��-74', '��������� �.�., ������������'),
('������� �.�., ��.221 ', '����20', '������� �.�., �����'),
('�������� �.�., ��.201', '��-47', '����� �.�., �����'),
('�������� �.�., ��.201', '����20', '������� �.�., �����'),
('����� �.�.', '��-47', '����� �.�., �����')
GO

SELECT * FROM Armory
SELECT * FROM Soldiers
GO

-- ��������� ������� ������� �� ���������:

DROP TABLE Armory
DROP TABLE Soldiers
GO

CREATE TABLE Soldiers
(
	Soldier varchar (30) NOT NULL
		PRIMARY KEY,
	Office int,		-- ��������� ������� Office.
	Platoon int NOT NULL
)
GO


CREATE TABLE Armory
(
	Soldier varchar (30) NOT NULL
		FOREIGN KEY REFERENCES Soldiers (Soldier)
				ON DELETE CASCADE
					ON UPDATE CASCADE,
	Weapon varchar (20) NOT NULL,
	WeaponGiver varchar (30) NOT NULL,
	[Rank] varchar (20) NOT NULL	-- ��������� ������� Rank (������) ��� ��������� ������.
)
GO

INSERT INTO Soldiers
VALUES
('������ �.�.', 205, 222),
('������� �.�.', 221, 232),
('�������� �.�.', 201, 212),
('����� �.�.', NULL, 200)
GO

INSERT INTO Armory
VALUES
('������ �.�.', '��-47', '����� �.�.', '�����'),		-- ����� "��.205" � �.�. ����� �������, �.�. ������ �� ����� ��� ���� � ������� Soldiers
('������ �.�.', '����20', '������� �.�.', '�����'),
('������� �.�.', '��-74', '��������� �.�.', '������������'),
('������� �.�.', '����20', '������� �.�.', '�����'),
('�������� �.�.', '��-47', '����� �.�.', '�����'),
('�������� �.�.', '����20', '������� �.�.', '�����'),
('����� �.�.', '��-47', '����� �.�.', '�����')
GO

SELECT * FROM Armory
SELECT * FROM Soldiers
GO

-- ��������� ������� Line � ��������� ���� � ������� Armory - ��� ������������ ���������� �� 2��.
DROP TABLE Armory
GO

CREATE TABLE Armory
(
	Line int IDENTITY NOT NULL		-- ����������� ������� � ��������� ���� �� ��.
		PRIMARY KEY,
	Soldier varchar (30) NOT NULL
		FOREIGN KEY REFERENCES Soldiers (Soldier)
				ON DELETE CASCADE
					ON UPDATE CASCADE,
	Weapon varchar (20) NOT NULL,
	WeaponGiver varchar (30) NOT NULL,
	[Rank] varchar (20) NOT NULL
)
GO

INSERT INTO Armory
VALUES
('������ �.�.', '��-47', '����� �.�.', '�����'),
('������ �.�.', '����20', '������� �.�.', '�����'),
('������� �.�.', '��-74', '��������� �.�.', '������������'),
('������� �.�.', '����20', '������� �.�.', '�����'),
('�������� �.�.', '��-47', '����� �.�.', '�����'),
('�������� �.�.', '����20', '������� �.�.', '�����'),
('����� �.�.', '��-47', '����� �.�.', '�����')
GO

SELECT * FROM Armory
SELECT * FROM Soldiers
GO

---------------------------------------------------------
--						  2 NF 						   --
---------------------------------------------------------

-- ������� 2-� �� "������ �� �������� ������� ������ �������� �� ����� �����" ����������� ��� ���� ������.

---------------------------------------------------------
--						  3 NF 						   --
---------------------------------------------------------

-- ������� 3 ��:
-- ����� �� �������� ������� �� ������ �������� �� ������� �� ��������� ������� - �� �����������.
-- �� ������ ���� �������� � ������������ ������� - �����������.

-- ���� ����������� ����� �� ��������� ��������� WeaponGiver � Rank, ������� ������ ����� ������� Officers � �������� ������� Armory.

DROP TABLE Armory
DROP TABLE Officers
GO

CREATE TABLE Officers
(
	Officer varchar (30) NOT NULL
		PRIMARY KEY,
	[Rank] varchar (30) NOT NULL
)
GO

CREATE TABLE Armory
(
	Line int IDENTITY NOT NULL
		PRIMARY KEY,
	Soldier varchar (30) NOT NULL
		FOREIGN KEY REFERENCES Soldiers (Soldier)
				ON DELETE CASCADE
					ON UPDATE CASCADE,
	Weapon varchar (20) NOT NULL,
	WeaponGiver varchar (30) NOT NULL
		FOREIGN KEY REFERENCES Officers (Officer)
)
GO

INSERT INTO Officers
VALUES
('����� �.�.', '�����'),
('������� �.�.', '�����'),
('��������� �.�.', '������������')
GO

INSERT INTO Armory
VALUES
('������ �.�.', '��-47', '����� �.�.'),
('������ �.�.', '����20', '������� �.�.'),
('������� �.�.', '��-74', '��������� �.�.'),
('������� �.�.', '����20', '������� �.�.'),
('�������� �.�.', '��-47', '����� �.�.'),
('�������� �.�.', '����20', '������� �.�.'),
('����� �.�.', '��-47', '����� �.�.')
GO

-- ��� ������� 3 �� �����������.

SELECT * FROM Armory
SELECT * FROM Soldiers
SELECT * FROM Officers
GO