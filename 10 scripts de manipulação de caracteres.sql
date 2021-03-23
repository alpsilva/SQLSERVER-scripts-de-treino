USE AdventureWorks2019
GO

--LOWER com String
SELECT LOWER('Aplica��es com Linguagem SQL') AS Nome_Disciplina
GO

--LOWER com Coluna
SELECT Name AS Nome_Original, LOWER(Name) AS Nome_novo
FROM Production.Product
ORDER BY Name
GO

--UPPER com String
SELECT UPPER('Aplica��es com Linguagem SQL') AS Nome_Disciplina
GO

--LOWER com Coluna
SELECT Name AS Nome_Original, UPPER(Name) AS Nome_novo
FROM Production.Product
ORDER BY Name
GO

--Substring
SELECT SUBSTRING ('Aplica��es com Linguagem SQL', 16, 13) AS Parte_do_Nome
GO

--Substring com Coluna
SELECT Name AS Nome_Original, SUBSTRING(Name, 5, 15) AS Parte_do_Nome
FROM Production.Product
ORDER BY Name
GO

--LEFT
SELECT LEFT('Aplica��es com Linguagem SQL', 10) AS Parte_Esquerda
GO

SELECT Name AS Nome_Original, LEFT(Name, 10) AS Parte_Esquerda
FROM Production.Product
ORDER BY Name
GO

--RIGHT
SELECT RIGHT('Aplica��es com Linguagem SQL', 10) AS Parte_Direita
GO

SELECT Name AS Nome_Original, RIGHT(Name, 10) AS Parte_Direita
FROM Production.Product
ORDER BY Name
GO

--LEN
SELECT LEN('Aplica��es com Linguagem SQL') AS Qtde_Caracteres
GO
--Aten��o: Espa�o n � considerado caracter:
SELECT LEN('Aplica��es com Linguagem SQL                ') AS Qtde_Caracteres
GO

--DATALENGTH
SELECT DATALENGTH('Aplica��es com Linguagem SQL') AS Qtde_Caracteres
GO
--Aten��o: Essa fun��o conta espa�o
SELECT DATALENGTH('Aplica��es com Linguagem SQL                ') AS Qtde_Caracteres
GO

--CHARINDEX
SELECT CHARINDEX('SQL', 'Aplica��es com Linguagem SQL') AS Inicio_String_SQL,
	CHARINDEX('T-SQL', 'Aplica��es com Linguagem SQL') AS Inicio_String_T_SQL
GO
--Especificando um inicio para a busca
SELECT CHARINDEX('SQL', 'Aplica��es com Linguagem SQL', 27) AS Inicio_String_SQL
GO

--REPLACE
SELECT REPLACE('Aplica��es com Linguagem ABC', 'ABC', 'SQL') AS String_Trocada
GO

--Tirando espa�o em branco com replace
SELECT Name AS Nome_Original, REPLACE(Name, ' ', '') AS Nome_sem_espa�o
FROM Production.Product
ORDER BY Name
GO

--REPLICATE
SELECT REPLICATE ('SQL ', 5) AS String_Replicada
GO

--Exibir zeros � esquerda de uma coluna
SELECT Name AS Nome, ProductNumber,
REPLICATE('0', 5) + ' - ' + ProductNumber AS New_ProductNumber
FROM Production.Product
ORDER BY Name
GO

--REVERSE
SELECT REVERSE('Aplica��es com Linguagem SQL') AS String_Invertida
GO

--LTRIM Tira os espa�os a esquerda
SELECT LTRIM('     Aplica��es com Linguagem SQL') AS Nova_String
GO

--RTRIM Tira os espa�os a direita
SELECT RTRIM('Aplica��es com Linguagem SQL     ') AS Nova_String
GO

--TRIM Tira os espa�os
SELECT TRIM('     Aplica��es com Linguagem SQL     ') AS Nova_String
GO 

--TRIM com FROM
SELECT TRIM('#!' FROM '##   Aplica��es com Linguagem SQL   !##') AS Nova_String
GO 

--Concat
SELECT CONCAT('Aplica��es',  'com',  'Linguagem',  'SQL') AS Nova_String
GO 

