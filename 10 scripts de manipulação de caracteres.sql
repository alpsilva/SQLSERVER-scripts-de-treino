USE AdventureWorks2019
GO

--LOWER com String
SELECT LOWER('Aplicações com Linguagem SQL') AS Nome_Disciplina
GO

--LOWER com Coluna
SELECT Name AS Nome_Original, LOWER(Name) AS Nome_novo
FROM Production.Product
ORDER BY Name
GO

--UPPER com String
SELECT UPPER('Aplicações com Linguagem SQL') AS Nome_Disciplina
GO

--LOWER com Coluna
SELECT Name AS Nome_Original, UPPER(Name) AS Nome_novo
FROM Production.Product
ORDER BY Name
GO

--Substring
SELECT SUBSTRING ('Aplicações com Linguagem SQL', 16, 13) AS Parte_do_Nome
GO

--Substring com Coluna
SELECT Name AS Nome_Original, SUBSTRING(Name, 5, 15) AS Parte_do_Nome
FROM Production.Product
ORDER BY Name
GO

--LEFT
SELECT LEFT('Aplicações com Linguagem SQL', 10) AS Parte_Esquerda
GO

SELECT Name AS Nome_Original, LEFT(Name, 10) AS Parte_Esquerda
FROM Production.Product
ORDER BY Name
GO

--RIGHT
SELECT RIGHT('Aplicações com Linguagem SQL', 10) AS Parte_Direita
GO

SELECT Name AS Nome_Original, RIGHT(Name, 10) AS Parte_Direita
FROM Production.Product
ORDER BY Name
GO

--LEN
SELECT LEN('Aplicações com Linguagem SQL') AS Qtde_Caracteres
GO
--Atenção: Espaço n é considerado caracter:
SELECT LEN('Aplicações com Linguagem SQL                ') AS Qtde_Caracteres
GO

--DATALENGTH
SELECT DATALENGTH('Aplicações com Linguagem SQL') AS Qtde_Caracteres
GO
--Atenção: Essa função conta espaço
SELECT DATALENGTH('Aplicações com Linguagem SQL                ') AS Qtde_Caracteres
GO

--CHARINDEX
SELECT CHARINDEX('SQL', 'Aplicações com Linguagem SQL') AS Inicio_String_SQL,
	CHARINDEX('T-SQL', 'Aplicações com Linguagem SQL') AS Inicio_String_T_SQL
GO
--Especificando um inicio para a busca
SELECT CHARINDEX('SQL', 'Aplicações com Linguagem SQL', 27) AS Inicio_String_SQL
GO

--REPLACE
SELECT REPLACE('Aplicações com Linguagem ABC', 'ABC', 'SQL') AS String_Trocada
GO

--Tirando espaço em branco com replace
SELECT Name AS Nome_Original, REPLACE(Name, ' ', '') AS Nome_sem_espaço
FROM Production.Product
ORDER BY Name
GO

--REPLICATE
SELECT REPLICATE ('SQL ', 5) AS String_Replicada
GO

--Exibir zeros à esquerda de uma coluna
SELECT Name AS Nome, ProductNumber,
REPLICATE('0', 5) + ' - ' + ProductNumber AS New_ProductNumber
FROM Production.Product
ORDER BY Name
GO

--REVERSE
SELECT REVERSE('Aplicações com Linguagem SQL') AS String_Invertida
GO

--LTRIM Tira os espaços a esquerda
SELECT LTRIM('     Aplicações com Linguagem SQL') AS Nova_String
GO

--RTRIM Tira os espaços a direita
SELECT RTRIM('Aplicações com Linguagem SQL     ') AS Nova_String
GO

--TRIM Tira os espaços
SELECT TRIM('     Aplicações com Linguagem SQL     ') AS Nova_String
GO 

--TRIM com FROM
SELECT TRIM('#!' FROM '##   Aplicações com Linguagem SQL   !##') AS Nova_String
GO 

--Concat
SELECT CONCAT('Aplicações',  'com',  'Linguagem',  'SQL') AS Nova_String
GO 

