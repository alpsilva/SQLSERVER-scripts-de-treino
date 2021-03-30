USE AdventureWorks2019
GO

--CTE -> Common Table Expression
/*
Funciona de maneira semelhante à uma VIEW, com a diferença que CTE's
não são armazenadas no banco de dados, existem apenas durante a execução.
Vantagens:
-Conjunto de dados pode ser utilizado mais de uma vez na query, obtendo ganho de performance.
-Podem ser recursivas.
-Código mais legível.

Cláusulas que não pdoem ser usadas:
-ORDER BY (exceto quando uma cláusula TOP for especificada).
-INTO e cláusula OPTION com hints.
*/

--CTE simples
--Quantidade de vendas dos vendedores por ano
WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
AS --Define a query
(
	SELECT SalesPersonID, SalesOrderID, YEAR(OrderDate) AS SalesYear
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
)
--Consulta externa referenciando CTE
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear;
GO

--Multiplas CTE's
--Quantidade e valor de vendas dos vendedores por ano (1º query)
WITH Sales_CTE (SalesPersonID, TotalSales, SalesYear)
AS
(
	SELECT SalesPersonID, SUM(TotalDue) AS TotalSales, YEAR(OrderDate) AS SalesYear
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
	GROUP BY SalesPersonID, YEAR(OrderDate)
), --Vírgula para separar as CTE's
--Segunda CTE pode fazer referência à primeira.
Sales_Quota_CTE (BusinessEntityID, SalesQuota, SalesQuotaYear)
AS
(
	SELECT BusinessEntityID, SUM(SalesQuota) AS SalesQuota, YEAR(QuotaDate) AS SalesQuotaYear
	FROM Sales.SalesPersonQuotaHistory
	GROUP BY BusinessEntityID, YEAR(QuotaDate)
)
--Consulta externa referenciando CTE'S
SELECT SalesPersonID, SalesYear,
	FORMAT(TotalSales, 'C', 'en-us') AS TotalSales,
	SalesQuotaYear,
	FORMAT(SalesQuota, 'C', 'en-us') AS SalesQuota,
	FORMAT(TotalSales - SalesQuota, 'C', 'en-us') AS Amt_Above_or_Below_Quota
FROM Sales_CTE
JOIN Sales_Quota_CTE ON Sales_Quota_CTE.BusinessEntityID = Sales_CTE.SalesPersonID
AND Sales_CTE.SalesYear = Sales_Quota_CTE.SalesQuotaYear
ORDER BY SalesPersonID, SalesYear;
GO

--CTE's recursivas
WITH CTE_Recursiva (Nivel, Numero)
AS
(
	--Âncora  (nível 1)
	SELECT 1 AS Nivel, 1 AS Numero
	UNION ALL

	--Níveis recursivos
	SELECT Nivel + 1, Nivel AS "Nivel Anterior"
	FROM CTE_Recursiva
	WHERE Numero < 100
)
SELECT * FROM CTE_Recursiva;
GO

--Obs.: Só é possível ter 100 recursões no máximo.

--Evitar loops infinitos
WITH CTE_Recursiva (Nivel, Numero)
AS
(
	--Âncora  (nível 1)
	SELECT 1 AS Nivel, 1 AS Numero
	UNION ALL

	--Níveis recursivos
	SELECT Nivel + 1, Nivel AS "Nivel Anterior"
	FROM CTE_Recursiva
	WHERE Numero < 10
)
SELECT * FROM CTE_Recursiva
OPTION (MAXRECURSION 50);
GO

--Pra que serve?
--CTE Recursiva para listar funcionários de forma hierárquica
--Tabela dos funcionários
CREATE TABLE dbo.MyEmployees (
	EmployeeID SMALLINT NOT NULL,
	FirstName NVARCHAR(30)  NOT NULL,
	LastName NVARCHAR(40)  NOT NULL,
	Title NVARCHAR(50)  NOT NULL,
	DeptID SMALLINT NOT NULL,
	ManagerID INT NULL,
	CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC)
);
GO

--Cadastrar alguns funcionários
INSERT INTO dbo.MyEmployees VALUES
(1, N'Ken', N'Sánchez', N'Chief Executive Director', 16, NULL),
(273, N'Brian', N'Welker', N'Vice President of Sales', 3, 1),
(274, N'Stephen', N'Jiang', N'Noth American Sales Manager', 3, 273),
(275, N'Michael', N'Blythe', N'Sales Representative', 3, 274),
(276, N'Linda', N'Mitchell', N'Sales Representative', 3, 274),
(285, N'Syed', N'Abbas', N'Pacific Sales Manager', 3, 273),
(286, N'Lynn', N'Tsoflias', N'Sales Representative', 3, 285),
(16, N'David', N'Bradley', N'Marketing Manager', 4, 273),
(23, N'Mary', N'Gibson', N'Marketing Specialist', 4, 16);

--CTE Recursiva para ler os funcionários e seus chefes imediatos
WITH DirectReports AS
(
	SELECT EmployeeID, Title, FirstName, LastName, ManagerID, 0 AS EmployeeLevel
	FROM dbo.MyEmployees
	WHERE ManagerID IS NULL
	UNION ALL
	SELECT E.EmployeeID, E.Title, E.FirstName, E.LastName, E.ManagerID, EmployeeLevel + 1
	FROM dbo.MyEmployees AS E
	INNER JOIN DirectReports AS D
	ON E.ManagerID = D.EmployeeID
)
SELECT * FROM DirectReports ORDER BY EmployeeLevel;