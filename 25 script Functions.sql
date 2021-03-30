USE AdventureWorks2019
GO

--Permite apenas o uso da instru~��o SELECT
--Deve obrigatoriamente retornar um valor
--N�o � poss�vel chamar Procedures de dentro de fun��es

--Fun��o escalar para retornar data e hora de start do SQL server
CREATE FUNCTION dbo.fn_sql_start_time (@DATE datetime)
RETURNS datetime
AS
BEGIN
	DECLARE
		@start DATETIME;
	SELECT @start = sqlserver_start_time FROM sys.dm_os_sys_info
	RETURN(@start)
END;
GO

SELECT dbo.fn_sql_start_time ('') AS  'SQL server start time';
GO

--FUNCTION TVF (Table-Value Function)
CREATE FUNCTION Production.TopNProdutos (@qtde AS INT)
RETURNS TABLE AS
RETURN (
	SELECT TOP (@qtde) Productid, name, listPrice
	FROM Production.Product
	ORDER BY ListPrice DESC
);
GO

SELECT * FROM Production.TopNProdutos (3);
GO

--Cursor
DECLARE contact_cursor CURSOR FOR
SELECT DISTINCT LastName
FROM Person.Person
WHERE LastName LIKE 'Bar%'
ORDER BY LastName;

OPEN contact_cursor;

--Faz a primeira recupera��o de uma linha que est� no cursor
FETCH NEXT FROM contact_cursor;

--Enquanto existirem mais linhas para serem buscadas no cursoR
WHILE @@FETCH_STATUS = 0 --(0 -> Instru��o FETCH foi bem sucedida, retornou linha)
BEGIN
	--Busca pr�xima linha do cursor
	FETCH NEXT FROM contact_cursor;
END;

CLOSE contact_cursor;
DEALLOCATE contact_cursor;
GO