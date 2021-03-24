USE AdventureWorks2019
GO

--Criar tabela de Luvas (gloves) com WIZARD de Export Data
SELECT ProductModelID, Name
FROM Production.ProductModel
WHERE ProductModelID IN (3, 4)

--Testar tabela após o tutorial em vídeo
SELECT * FROM Production.Gloves ORDER BY Name;

--UNION: Elimina as linhas duplicadas
SELECT	ProductModelID, Name
FROM Production.ProductModel
UNION
SELECT	ProductModelID, Name
FROM Production.Gloves
ORDER BY Name;
--Obs.: ORDER BY apenas no final e o número de colunas nas duas tabelas deve ser igual

--INTERSECT: Retorna instâncias presentes em ambas as tabelas
SELECT	ProductModelID, Name
FROM Production.ProductModel
INTERSECT
SELECT	ProductModelID, Name
FROM Production.Gloves
ORDER BY Name;

--EXCEPT: Subtração
SELECT	ProductModelID, Name
FROM Production.ProductModel
EXCEPT
SELECT	ProductModelID, Name
FROM Production.Gloves
ORDER BY Name;

--Obs: Em exceptOrdem dos conjuntos influncia no resultado

SELECT	ProductModelID, Name
FROM Production.Gloves
EXCEPT
SELECT	ProductModelID, Name
FROM Production.ProductModel
ORDER BY Name;