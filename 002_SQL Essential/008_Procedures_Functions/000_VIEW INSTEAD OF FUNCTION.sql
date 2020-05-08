USE AdventureWorks2012;
GO

	--CREATE FUNCTION fnContactList() -- ������� �������
	--RETURNS TABLE -- ������������ ��� TABLE ��������� �� �� ��� ������������ ����� �������
	--AS
	--RETURN (SELECT LastName, FirstName, ModifiedDate 
	--		FROM Person.Person); 
	--GO

	--SELECT * FROM dbo.fnContactList(); -- ������� ��� ���������� �� ������� ������������� ��� ������ ������� fnContactList();
	--GO

-- �������: ��������� ���������� ������ � ������� �������������

DROP VIEW fnContactListView
GO

CREATE VIEW fnContactListView
AS
SELECT LastName, FirstName, ModifiedDate 
		FROM Person.Person
GO

SELECT * FROM fnContactListView
GO