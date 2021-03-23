USE AdventureWorks2019
GO

--Agrupar quantidade de vendas por funcion�rio
SELECT SalesPersonID, COUNT(SalesOrderID) AS Total_Vendas
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID
ORDER BY 2 DESC;

--Agrupar Quantidade de vendas dos funcion�rios por dias (N�o ok, colula n�o definida)
SELECT SalesPersonID, OrderDate, COUNT(SalesOrderID) AS Total_Vendas
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
ORDER BY OrderDate DESC;
--Corrigido
SELECT SalesPersonID, OrderDate, COUNT(SalesOrderID) AS Total_Vendas
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID, OrderDate
ORDER BY OrderDate DESC;

--Agrupar Quantidade de vendas dos funcion�rios por ano
SELECT SalesPersonID, YEAR(OrderDate) AS Ano, COUNT(SalesOrderID) AS Total_Vendas
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID, YEAR(OrderDate)
ORDER BY YEAR(OrderDate) DESC;

--Filtrando agrupamentos

--Valor total de vendas por dia em 2013
SELECT OrderDate AS Data_da_venda, SUM(TotalDue) AS Valor_total_diario_vendas
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2013'
GROUP BY OrderDate
ORDER BY 1 ASC;

--Valor total de vendas por m�s em 2013
SELECT MONTH(OrderDate) AS Data_da_venda, SUM(TotalDue) AS Valor_total_mensal_vendas
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2013'
GROUP BY MONTH(OrderDate)
ORDER BY 1 ASC;

--Filtrando com HAVING os dias com vendas superiores a 4milh�es, no ano de 2013
SELECT OrderDate AS Data_da_venda, SUM(TotalDue) AS Valor_total_diario_vendas
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2013'
GROUP BY OrderDate
HAVING SUM(TotalDue) > 4000000
ORDER BY 1 ASC;

--Quantidade de vendas por funcion�rio com ID maior que 280
SELECT SalesPersonID, COUNT(SalesOrderID) AS Total_Vendas
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID
HAVING SalesPersonID > 280
ORDER BY 2 DESC;

/*
Lembrar que WHERE limita as linhas passadas para o GROUP BY
Podendo reduzir a quantidade de linhas! Quando usar GROUP BY
d� preferencia para HAVING.
*/

--Clientes que fizeram mais de 10 compras em 2013
--HAVING + WHERE
SELECT CustomerID, COUNT(SalesOrderID) AS Total_compras
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2013'
GROUP BY CustomerID
HAVING COUNT(SalesOrderID) > 10
ORDER BY COUNT(SalesOrderID) DESC;