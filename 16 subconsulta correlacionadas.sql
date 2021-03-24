USE AdventureWorks2019
GO

--Subconsulta correlacionada (não é possível executá-las separadamente)

--Retornar as vendas mais recentes feitas por cada funcionario
select Q1.SalesOrderID, Q1.SalesPersonID, Q1.OrderDate
FROM Sales.SalesOrderHeader AS Q1
WHERE Q1.OrderDate = (
	SELECT MAX(Q2.OrderDate)
	FROM Sales.SalesOrderHeader AS Q2
	WHERE Q2.SalesPersonID = Q1.SalesPersonID
)
ORDER BY Q1.SalesPersonID, Q1.OrderDate
GO

--Operador EXISTS
--Retornar o ID e o bônus das pessoas que fizeram vendas em 2011
SELECT P.BusinessEntityID, P.Bonus
FROM Sales.SalesPerson P
WHERE EXISTS (
	SELECT *
	FROM Sales.SalesOrderHeader O
	WHERE O.SalesPersonID = P.BusinessEntityID
	AND YEAR(OrderDate) = '2011'
)
ORDER BY 1 ASC;

--Retornar o ID e o bônus das pessoas que NÃO fizeram vendas em 2011
SELECT P.BusinessEntityID, P.Bonus
FROM Sales.SalesPerson P
WHERE NOT EXISTS (
	SELECT *
	FROM Sales.SalesOrderHeader O
	WHERE O.SalesPersonID = P.BusinessEntityID
	AND YEAR(OrderDate) = '2011'
)
ORDER BY 1 ASC;

/*
ATENÇÃO: Evitar subconsultas que tenham o mesmo propósito de um JOIN
JOIN -> Mais eficiência/performático
*/

--EXISTS VS IN
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE TerritoryID IN (
	SELECT TerritoryID
	FROM Sales.SalesTerritory
	WHERE Name = 'Australia' OR Name = 'France'
);
GO

SELECT CustomerID, AccountNumber
FROM Sales.Customer C
WHERE EXISTS (
	SELECT *
	FROM Sales.SalesTerritory T
	WHERE T.TerritoryID = C.TerritoryID
	AND Name = 'Australia' OR Name = 'France'
);
GO
--Nesse caso, o EXISTS é mais performático,
--Pois ele para na primeira instância encontrada que dê match e já retorna

