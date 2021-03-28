USE AdventureWorks2019
GO

--UPDATE
SELECT * FROM dbo.TAB1
GO

UPDATE dbo.TAB1
SET COL2 = 'NÃO'
WHERE COL1 = 10;
GO


--Atenção: UPDATE sem WHERE
UPDATE dbo.TAB1
SET COL2 = 'NÃO'
--WHERE COL1 = 10;
GO
SELECT * FROM dbo.TAB1
GO

--UPDATE com JOIN
UPDATE dbo.TAB1
SET COL2 = 'SIM'
FROM dbo.TAB1
JOIN dbo.TAB1_COPIA ON TAB1.COL1 = TAB1_COPIA.COL1;
GO

SELECT * FROM dbo.TAB1
GO
SELECT * FROM dbo.TAB1_COPIA
GO

--UPDATE referenciando coluna de outra tabela
UPDATE TAB1
SET TAB1.COL2 = TAB1_COPIA.COL2
FROM TAB1
JOIN TAB1_COPIA ON TAB1.COL1 = TAB1_COPIA.COL1;
GO

SELECT * FROM dbo.TAB1
GO
SELECT * FROM dbo.TAB1_COPIA
GO

--UPDATE com função de data/hora + operador booleano
UPDATE TAB1
SET COL3 = GETDATE()
WHERE COL1 > 5 AND COL2 <> 'NÃO' OR COL2 IS NULL
GO
SELECT * FROM dbo.TAB1
GO

--UPDATE com expressão na cláusula SET
SELECT * FROM Production.Product
WHERE SellEndDate IS NULL
AND ListPrice <> 0.00;
GO

UPDATE Production.Product
SET ListPrice = ListPrice * 1.10
WHERE SellEndDate IS NULL
AND ListPrice <> 0.00;
GO

--UPDATE com funções de caracteres
SELECT * FROM Person.Person;
GO

UPDATE Person.Person
SET Title = UPPER(Title), FirstName = UPPER(FirstName),
	MiddleName = UPPER(MiddleName), LastName = UPPER(LastName);
GO

--UPDATE com default
EXEC sp_help 'dbo.TAB1';
GO

SELECT * FROM TAB1;
GO

UPDATE TAB1
SET COL2 = DEFAULT;
GO

--UPDATE com CASE
--UPDATE com output dos valores alterados ("backup" dos valores antigos)
--COPY WITH HEADERS
UPDATE HumanResources.Employee
SET VacationHours = 
	(
	CASE
		WHEN ((VacationHours - 10.00) < 0) THEN VacationHours + 40
		ELSE (VacationHours + 20.00)
	END
	)
OUTPUT deleted.BusinessEntityID, deleted.VacationHours AS BeforeValue,
	inserted.VacationHours AS AfterValue
WHERE SalariedFlag = 0;
GO