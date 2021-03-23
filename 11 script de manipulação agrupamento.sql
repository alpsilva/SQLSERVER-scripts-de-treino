USE AdventureWorks2019
GO

--Fun��es MIN e MAX com colunas numericas
SELECT MIN(UnitPrice) AS pre�o_minimo, MAX(UnitPrice) AS pre�o_maximo
FROM Sales.SalesOrderDetail;

--Fun��es MIN e MAX com colunas do tipo DATE
SELECT MIN(BirthDate) AS mais_velho, MAX(BirthDate) AS mais_novo
FROM HumanResources.Employee;

--Fun��es MIN e MAX com colunas do tipo String (ordem alfabetica)
SELECT MIN(Name), MAX(Name)
FROM Production.Product;

--Fun��o COUNT(*) vs COUNT( express�o )
SELECT COUNT(*) AS total_de_produtos, COUNT(Color) AS total_de_produtos_com_cor
FROM Production.Product;
--COUNT(*) conta com nulos, COUNT( express�o ) ignora.

--Fun��es SUM E AVG
SELECT SUM(LineTotal) AS Valor_total, AVG(LineTotal) AS media
FROM Sales.SalesOrderDetail;

--Fun��es de agrega��o com outras fun��es
SELECT MIN(YEAR(orderdate)) AS ano_compra_mais_antiga, MAX(YEAR(orderdate)) AS ano_compra_mais_velha
FROM Sales.SalesOrderHeader;

--Distinct com fun��es de agrega��o
SELECT COUNT(DISTINCT CustomerID) AS qtd_vendas_para_clientes_distintos,
		COUNT(CustomerID) AS qtd_vendas_para_clientes
FROM Sales.SalesOrderHeader;

--Valores nulos (<> de branco) e fun��es de agrega��o
SELECT AVG(Weight) AS Peso_M�dio_dos_Produtos,
		SUM(Weight) / COUNT(Weight) AS Peso_M�dio_dos_Produtos_sem_avg_Ok,
		SUM(Weight) / COUNT(*) AS Peso_M�dio_dos_Produtos_sem_avg_errado
FROM Production.Product;
--COUNT(*) conta nulls

--Tratando valores nulos
SELECT Weight AS "Sem Peso", COALESCE (Weight, 0) AS "Peso Zerado"
FROM Production.Product;
--Coalesce: Acha os valores nulos e colocam o valor passado como parametro no lugar.