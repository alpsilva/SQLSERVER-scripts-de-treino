USE AdventureWorks2019
GO

--Permite apenas o uso da instru~ção SELECT
--Deve obrigatoriamente retornar um valor
--Não é possível chamar Procedures de dentro de funções

--Função escalar para retornar data e hora de start do SQL server
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

--Faz a primeira recuperação de uma linha que está no cursor
FETCH NEXT FROM contact_cursor;

--Enquanto existirem mais linhas para serem buscadas no cursoR
WHILE @@FETCH_STATUS = 0 --(0 -> Instrução FETCH foi bem sucedida, retornou linha)
BEGIN
	--Busca próxima linha do cursor
	FETCH NEXT FROM contact_cursor;
END;

CLOSE contact_cursor;
DEALLOCATE contact_cursor;
GO