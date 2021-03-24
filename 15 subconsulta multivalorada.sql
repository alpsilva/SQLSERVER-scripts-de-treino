USE AdventureWorks2019
GO

--Subconsulta Multivalorada: Quando uma subconsulta retorna uma lista de valores
--Operador principal: IN

--Retornar ID de territorio da australia e frança
SELECT TerritoryID
FROM Sales.SalesTerritory
WHERE Name = 'Australia' OR Name = 'France';
GO

--ID e numero da conta dos clientes da Australia e França
--IN
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE TerritoryID IN (
	SELECT TerritoryID
	FROM Sales.SalesTerritory
	WHERE Name = 'Australia' OR Name = 'France'
);
GO

/*
ATENÇÃO: Evitar subconsultas que tenham o mesmo propósito de um JOIN
JOIN -> Mais eficiência/performático
*/

--Consulta anterior feita com JOIN
SELECT C.CustomerID, C.AccountNumber
FROM Sales.Customer C
INNER JOIN Sales.SalesTerritory T
ON C.TerritoryID = T.TerritoryID
WHERE T.Name = 'Australia' OR T.Name = 'France';
GO

--ID e numero da conta dos clientes QUE NÃO SÃO da Australia e França
--NOT IN
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE TerritoryID NOT IN (
	SELECT TerritoryID
	FROM Sales.SalesTerritory
	WHERE Name = 'Australia' OR Name = 'France'
);
GO

--Subconsulta Multivalorada com HAVING
--5 dias com maior valor de venda de 2012
SELECT TOP(5) CAST(DAY(OrderDate) AS VARCHAR(2)) + '-' + CAST(MONTH(OrderDate) AS VARCHAR(2))
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2012'
GROUP BY OrderDate
ORDER BY SUM(TotalDue) DESC;
GO

--Vendas dos dias de 2013 que, no ano anterior, foram os 5 dias com mais valor de vendas
--Subconsulta independente (pode ser executada sozinha)
SELECT OrderDate AS Data_Venda, SUM(TotalDue) AS Valor_Venda_Diario
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2013'
GROUP BY OrderDate
HAVING CAST(DAY(OrderDate) AS VARCHAR(2)) + '-' + CAST(MONTH(OrderDate) AS VARCHAR(2)) IN (
	SELECT TOP(5) CAST(DAY(OrderDate) AS VARCHAR(2)) + '-' + CAST(MONTH(OrderDate) AS VARCHAR(2))
	FROM Sales.SalesOrderHeader
	WHERE YEAR(OrderDate) = '2012'
	GROUP BY OrderDate
	ORDER BY SUM(TotalDue) DESC
)
ORDER BY 1 ASC;
GO
