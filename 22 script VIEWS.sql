USE AdventureWorks2019
GO

--View simples
CREATE VIEW VW_CLientes_Australia AS
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE TerritoryID IN (
	SELECT TerritoryID
	FROM Sales.SalesTerritory
	WHERE Name = 'Australia'
);
GO

SELECT * FROM VW_CLientes_Australia;

--Filtrando Views
SELECT *
FROM VW_CLientes_Australia
WHERE CustomerID BETWEEN 1 AND 100;
GO

--Views com cl�usula ORDER BY (ERROR)
CREATE VIEW VW_CLientes_Australia_Ordenada AS
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE TerritoryID IN (
	SELECT TerritoryID
	FROM Sales.SalesTerritory
	WHERE Name = 'Australia'
)
ORDER BY CustomerID;
GO

--Ao inv�s disso, s� ordenar a chamada � view
SELECT * FROM VW_CLientes_Australia
ORDER BY CustomerID;
GO
--View usando * 
CREATE VIEW VW_CLientes_Australia_All_Info AS
SELECT *
FROM Sales.Customer
WHERE TerritoryID IN (
	SELECT TerritoryID
	FROM Sales.SalesTerritory
	WHERE Name = 'Australia'
);
GO
SELECT * FROM VW_CLientes_Australia_All_Info;
GO
/*
Aten��o: A view � compilada na hora da cria��o. Se posteriormente ocorrer
altera��o na  tabela, a view n�o ira refletir automaticamente.
*/

ALTER TABLE Sales.Customer ADD Ind_Status BIT NULL;
GO
SELECT * FROM Sales.Customer;
--N�o mostrar� coluna nova!
SELECT * FROM VW_CLientes_Australia_All_Info;
GO

--Solu��o: Recompilar view ou executar ALTER VIEW com o mesmo c�digo:
EXEC sp_refreshview VW_CLientes_Australia_All_Info;
GO

ALTER VIEW VW_CLientes_Australia_All_Info AS
SELECT *
FROM Sales.Customer
WHERE TerritoryID IN (
	SELECT TerritoryID
	FROM Sales.SalesTerritory
	WHERE Name = 'Australia'
);
GO