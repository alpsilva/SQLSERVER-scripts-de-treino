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

--Views com cláusula ORDER BY (ERROR)
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

--Ao invés disso, só ordenar a chamada à view
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
Atenção: A view é compilada na hora da criação. Se posteriormente ocorrer
alteração na  tabela, a view não ira refletir automaticamente.
*/

ALTER TABLE Sales.Customer ADD Ind_Status BIT NULL;
GO
SELECT * FROM Sales.Customer;
--Não mostrará coluna nova!
SELECT * FROM VW_CLientes_Australia_All_Info;
GO

--Solução: Recompilar view ou executar ALTER VIEW com o mesmo código:
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