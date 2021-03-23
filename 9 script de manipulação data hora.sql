USE AdventureWorks2019
GO

--separar dia, mês e ano
SELECT DISTINCT DueDate AS Data_hora_Vencimento,
DAY(DueDate) AS Dia_Vencimento,
MONTH(DueDate) AS Mes_Vencimento,
YEAR(DueDate) AS AnO_Vencimento
FROM Purchasing.PurchaseOrderDetail
ORDER BY DueDate DESC
GO

SELECT CURRENT_TIMESTAMP, GETDATE()
GO

--DATENAME
SELECT DATENAME (WEEKDAY, GETDATE()) AS Dia_Semana,
DATENAME (HH, GETDATE()) AS Hora,
DATENAME (MINUTE, GETDATE()) AS Minutos
go

SET LANGUAGE Português
GO
SELECT @@LANGUAGE
GO

SELECT DATENAME (WEEKDAY, GETDATE()) AS Dia_Semana,
DATENAME (HH, GETDATE()) AS Hora,
DATENAME (MINUTE, GETDATE()) AS Minutos
go

--DATEDIFF calcula diferença entre datas de acordo com o parametro passado
SELECT DATEDIFF(HOUR, '2018', '2021');
SELECT DATEDIFF(DAY, '2018', '2021');
SELECT DATEDIFF(MONTH, '2018', '2021');

--DATEADD soma tempo a uma data
SELECT DATEADD(MONTH, 6, '15/01/2018');
SELECT DATEADD(YEAR, 4, '15/01/2020');
SELECT DATEADD(HOUR, 48, '15/01/2020 17:30:00');

--ISDATE testa se o formato de tempo é válido
IF ISDATE('15/01/2020 17:30:00') = 1
	PRINT 'VALID'
ELSE
	PRINT 'INVALID';

--ISDATE testa se o formato de tempo é válido
IF ISDATE('15/01/2020 17/30:00') = 1
	PRINT 'VALID'
ELSE
	PRINT 'INVALID';