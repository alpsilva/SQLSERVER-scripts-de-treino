USE AdventureWorks2019
GO

--Subconsulta Escalar: Quando a subconsulta retorna um único valor
--Operador principal: =

--Retornar ultima venda
SELECT MAX(SalesOrderID) AS ultima_venda
FROM Sales.SalesOrderHeader;
GO

--Retornar os itens vendidos na ultima venda
--Subconsulta independente
SELECT SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, LineTotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = (
	SELECT MAX(SalesOrderID) AS ultima_venda
	FROM Sales.SalesOrderHeader
);
GO

--Erro de subconsulta retornando mais de um valor
--Operadores =, !=, <, <=, >, >=
SELECT SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, LineTotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = (
	SELECT TOP(5) SalesOrderID AS ultimas_5_venda
	FROM Sales.SalesOrderHeader
	ORDER BY SalesOrderID DESC
);
GO

--Subconsulta Escalar com HAVING
--Vendas medias de 2012
SELECT AVG(TotalDue) AS media
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2012';
GO

--Vendas diarias de 2013 com valores inferiores à media de vendas do ano anterior
--Subconsulta independente (pode ser executada sozinha)
SELECT OrderDate AS Data_Venda, SUM(TotalDue) AS Valor_Venda_Diario
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2013'
GROUP BY OrderDate
HAVING SUM(TotalDue) < (
	SELECT AVG(TotalDue) AS media
	FROM Sales.SalesOrderHeader
	WHERE YEAR(OrderDate) = '2012'
)
ORDER BY 1 ASC;
GO