USE MyJoinsDB
GO

SELECT * FROM Employees			-- ���������������� �������.
SELECT * FROM PersonalInfo		-- ���������������� �������.
SELECT * FROM SalaryPosition	-- ���������������� �������.
GO

CREATE UNIQUE NONCLUSTERED INDEX PK_IND1	-- �����������: ������� ����� �� ��������. ������� ������ ���� ���������� ��� �������� ������ ����������.
ON Employees(Phone)
GO

-- �������� ������ ���������� �������� �� ������� � ����� ��������:
SELECT * FROM Employees WHERE Phone LIKE '%78745%'	-- 'Clustered Index Scan (Clustered)' - ��� ������������� IN, LIKE ��� �.�., � �����, ���� ���� '=' ����� ����� ������ �������� - ����� ����� ����.
SELECT * FROM Employees WHERE Phone = '(093)9874545'	-- ������ ��� ������������� '=', ������� ����� ������ ��������� �������� ����� ����� �� ������������������� ������� (� ����� � �� �����������������).

CREATE UNIQUE NONCLUSTERED INDEX PK_IND2	-- �����������: ������� ����� �� ������. � ���� ����������� ������ ���� ���������� ����� ;).
ON PersonalInfo([Address])
GO

-- �������� ����� ����������:
SELECT * FROM PersonalInfo WHERE [Address] = '��������, 23'	

CREATE NONCLUSTERED INDEX PK_IND3			-- ����������� ����� ���������������� :) - ������� ����� �� ��������� ��������� (� �� �����-�� - 4!). ����������� - �� ��������.
ON PersonalInfo(MarriageStatus)
GO

-- �������� ����� ���������� �������:
SELECT * FROM PersonalInfo WHERE MarriageStatus = '�� �����'	--'Clustered Index Scan (Clustered)'... �.�., ����� �������� �� �������, �� ������� ����� ������������������ ������, �� ���������, ������������ ������������ ����������������� �������. ����������������� ������ �� ������. ���������, �������� ��, �� ������������� ��������, � ������� ������� ���� ������ (� �����, ��� ��� ����� = ������ ����� ���������� ����� �� 2-� ��������)

CREATE NONCLUSTERED INDEX PK_IND4			-- ����������� - �������������� - ������� ����� �� ���������. �� ��������.
ON SalaryPosition(Position)
GO

-- �������� ����� ���������� �������:
SELECT * FROM SalaryPosition WHERE Position = '��������'	--'Clustered Index Scan (Clustered)'.