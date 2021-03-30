USE AdventureWorks2019
GO

CREATE PROCEDURE SP_Clientes_Australia AS
BEGIN
	SELECT CustomerID, AccountNumber
	FROM Sales.Customer
	WHERE TerritoryID IN (
		SELECT TerritoryID
		FROM Sales.SalesTerritory
		WHERE Name = 'Australia'
	)
	ORDER BY CustomerID DESC;
END;
GO

EXEC SP_Clientes_Australia;
GO

--Procedure com par�metros
CREATE PROCEDURE SP_Insere_Departamento
--Par�metros de entrada e seus tipos de dados
	--@DepartmentID SMALLINT -> n�o precisa pois � identity
	@Name NVARCHAR(50),
	@GroupName NVARCHAR(50)
	--@ModifiedDate DATETIME -> Possui um default que recupera GETDATE()
AS
BEGIN
	--Exibir no output os valores que ser�o inseridos
	PRINT @Name + ' ' + @GroupName;

	--Inserindo os valores de entrada na tabela
	INSERT INTO HumanResources.Department
	VALUES (@Name, @GroupName, DEFAULT);
END;
GO

EXEC SP_Insere_Departamento @Name='EAD', @GroupName='Ensino';
GO

SELECT * FROM HumanResources.Department;

--IF / ELSE
IF 1=1
	PRINT 'Verdadeiro'
else
	PRINT 'Falso';
IF 1=0
	PRINT 'Verdadeiro'
else
	PRINT 'Falso';
GO

--IF com SELECT
IF EXISTS (SELECT * FROM HumanResources.Department WHERE Name = 'EAD')
	PRINT 'Registro encontrado'
ELSE
	PRINT 'Registro n�o encontrado';
GO

--IF com comandos DDL
IF OBJECT_ID ('SP_Clientes_Australia', 'P') IS NOT NULL
	DROP PROCEDURE SP_Clientes_Australia
ELSE
	PRINT 'Objeto Inexistente';
GO

--Declara��o de vari�veis
DECLARE @VariavelNome VARCHAR(100)
SET @VariavelNome = 'Bootcamp IGTI - Analista de Banco de Dados'
PRINT @VariavelNome
GO

--WHILE
DECLARE @Variavel1 INT
SET @Variavel1 = 0
WHILE @Variavel1 <= 10
BEGIN
	PRINT @Variavel1;
	SET @Variavel1 = @Variavel1 + 1;
END;

--Loop infinito
DECLARE @Variavel1 INT
SET @Variavel1 = 0
WHILE 1 = 1 OR 1 > 0
BEGIN
	PRINT @Variavel1;
	SET @Variavel1 = @Variavel1 + 1;
END;
--tem que parar a query ou vai rodar eternamente (at� o servidor crashar)

--TRY / CATCH com procedures
--Erro de resolu��o de nome n�o tratado � no mesmo n�vel por isso n�o entra no try catch
CREATE PROCEDURE usp_procTeste
AS
	SELECT * FROM TabelaInexistente;
GO

BEGIN TRY
	EXECUTE usp_procTeste;
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage
END CATCH
GO