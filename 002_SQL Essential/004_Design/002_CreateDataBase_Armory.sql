CREATE DATABASE HomeWork_004_Weapons
ON
(
	NAME = 'HomeWork_004_Weapons',
	FILENAME = 'd:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\HomeWork_004_Weapons.mdf',
	SIZE = 5 Mb,		-- ����� ������� ������ �� ������� ��.
	MAXSIZE = 10 Mb,
	FILEGROWTH = 500 Kb	-- Kb ������-�� ����������� � ������� ����� (�����...), ����� ����� ������...
)
LOG
ON
(
	NAME = 'LogHomeWork_004_Weapons',
	FILENAME = 'd:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\HomeWork_004_Weapons_Log.ldf',
	SIZE = 2 Mb,
	MAXSIZE = 3 Mb,
	FILEGROWTH = 200 kb	-- ??
)
GO