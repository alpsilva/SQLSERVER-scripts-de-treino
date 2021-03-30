USE AdventureWorks2019
GO

--AutoCommit (DEFAULT)
CREATE TABLE TRAN1 (COD INT);
GO

INSERT INTO TRAN1
VALUES (1)
GO

SELECT * FROM TRAN1;
GO

--Transação implícita
--SSMS: Tools -> Options -> Query Execution -> SQL Server -> ANSI -> SET IMPLICIT_TRANSACTIONS
--T-SQL: SET IMPLICIT_TRANSACTIONS ON
SET IMPLICIT_TRANSACTIONS ON
GO

--Agora, se eu criar uma nova seção (outra query/arquivo), e tentar visualizar TRAN1,
--não haverá resposta.

INSERT INTO TRAN1
VALUES (2);
GO

SELECT * FROM TRAN1;
GO

--Desativar abertura de transação implicita
SET IMPLICIT_TRANSACTIONS OFF
GO

--Abertura de transação explícita
BEGIN TRANSACTION
	INSERT INTO TRAN1
		VALUES (3);
GO

--Como a transação está "pendente", o resultado só aparece dentro dessa sessão/arquivo
--SELECT de dentro da sessão
SELECT * FROM TRAN1;
GO

--Efetivando uma transação aberta implicitamente
COMMIT
GO
--Se for feito um select em outra sessão, ele refletirá o ultimo insert pois a transação foi commitada.

--Rollback de transição aberta explicitamente
BEGIN TRANSACTION
	INSERT INTO TRAN1
		VALUES (5)
GO

SELECT * FROM TRAN1;
GO

--Aplicando o rollback
ROLLBACK
GO

SELECT * FROM TRAN1;
GO

BEGIN TRANSACTION T1

	--Verificar quantas transações estão abertas
	SELECT @@TRANCOUNT

	CREATE TABLE TRAN2 (COD INT);
	GO
GO

	BEGIN TRANSACTION T2
		SELECT @@TRANCOUNT

		INSERT INTO TRAN2
			VALUES (1)
		GO

		SELECT * FROM TRAN2;
		GO
	GO

	COMMIT TRANSACTION T2
	GO

	SELECT @@TRANCOUNT

COMMIT TRANSACTION T1;
GO

--TRY / CATCH
BEGIN TRY
	--Gerar erro de divisão por zero
	SELECT 1/0
END TRY
BEGIN CATCH
	--Query a ser executada quando houver erro no TRY
	SELECT ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage
END CATCH
GO

--Erro de resolução de nome não tratado no TRY / CATCH
BEGIN TRY
	--Tentar acessar tabela inexiste
	SELECT * FROM TabelaInexistente
END TRY
BEGIN CATCH
	--Query a ser executada quando houver erro no TRY
	--Não acontece pois o erro é tratado ainda no TRY.
	SELECT ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage
END CATCH
GO

-- TRY / CATCH com transação
BEGIN TRANSACTION

	BEGIN TRY
		--Forçar um erro (violação de constraint)
		DELETE FROM Production.Product
		WHERE ProductID = 980;
	END TRY
	BEGIN CATCH
		SELECT ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;

		PRINT 'Quantidade de transações: ' + CAST (@@TRANCOUNT AS VARCHAR)
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION
	END CATCH

	PRINT 'Quantidade de transações: ' + CAST (@@TRANCOUNT AS VARCHAR)
	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION
	GO
GO

--Sem acionar o CATCH
--Usando Production.Gloves
BEGIN TRANSACTION
	BEGIN TRY
		--Não forçar um erro 
		DELETE FROM Production.Gloves
	END TRY
	BEGIN CATCH
		SELECT ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;

		PRINT 'Quantidade de transações: ' + CAST (@@TRANCOUNT AS VARCHAR)
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION
	END CATCH

	PRINT 'Quantidade de transações: ' + CAST (@@TRANCOUNT AS VARCHAR)
	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION
	GO
GO

SELECT * FROM Production.Gloves;
GO