CREATE DATABASE MyFunkDB
ON
(
	NAME = 'MyFunkDB',
	FILENAME ='d:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MyFunkDB.mdf',
	SIZE = 5 MB,
	MAXSIZE = 9 MB,
	FILEGROWTH = 1 MB
)
LOG
ON
(
	NAME = 'LogMyFunkDB',
	FILENAME ='d:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MyFunkDB_log.ldf',
	SIZE = 2 MB,
	MAXSIZE = 8 MB,
	FILEGROWTH = 1 MB
)
GO
