USE AdventureWorks2019
GO

--Lista produtos da cor preta
SELECT Name, Color
FROM Production.Product
WHERE Color = 'Black'
ORDER BY Name;

--Lista produtos que não sejam da cor preta
SELECT Name, Color
FROM Production.Product
WHERE Color <> 'Black'
ORDER BY Name;

--Lista produtos com valor de venda superior a $1000
SELECT Name AS Produto, Color AS Cor, ListPrice AS "Preço de Lista"
FROM Production.Product
WHERE ListPrice > 1000
ORDER BY Name;

--Filtros com operadores lógicos

--Listar produtos que iniciam com 'Chain'
SELECT Name, Color
FROM Production.Product
WHERE Name LIKE 'Chain%'
ORDER BY Name;

--Listar produtos que tenham 'chainring' em qualquer posição
SELECT Name, Color
FROM Production.Product
WHERE Name LIKE '%Chainring%'
ORDER BY Name;

--Listar produtos que possuam a letra 'a' como segunda letra
SELECT Name, Color
FROM Production.Product
WHERE Name LIKE '_a%'
ORDER BY Name;

--Lista produtos da cor preta OU da cor prata
SELECT Name, Color
FROM Production.Product
WHERE Color = 'Black' OR Color = 'Silver'
ORDER BY Name;

--Listar produtos que iniciam com 'Chain' E sejam da cor preta OU da cor prata
SELECT Name, Color
FROM Production.Product
WHERE Name LIKE 'Chain%'
AND (Color = 'Black' OR Color = 'Silver')
ORDER BY Name;

--Atenção para o uso dos parentes indicando a ordem de execução
--Sem parenteses (errado):
SELECT Name, Color
FROM Production.Product
WHERE Name LIKE 'Chain%'
AND Color = 'Black' OR Color = 'Silver'
ORDER BY Name;

--Uso de TOP para retornar os 5 primeiros resultados
SELECT TOP (5) Name AS Nome_Produto
FROM Production.Product
ORDER BY Nome_Produto;

--Impacto do order by na cláusula TOP
SELECT TOP (5) Name AS Nome_Produto
FROM Production.Product
ORDER BY Nome_Produto DESC;

--Uso de TOP para retornar 10% do total de produtos
SELECT TOP (10) PERCENT Name AS Nome_Produto
FROM Production.Product
ORDER BY Nome_Produto;

--uso do OFFSET-FETCH para "paginar" os dados

--Retornar os 50 primeiros produtos
SELECT Name AS Nome_Produto
FROM Production.Product
ORDER BY Nome_Produto
OFFSET 0 ROWS FETCH FIRST 50 ROWS ONLY;

--Retornar do 51 ao 100
SELECT Name AS Nome_Produto
FROM Production.Product
ORDER BY Nome_Produto
OFFSET 50 ROWS FETCH FIRST 50 ROWS ONLY;

--Uso de DISTINCT para retornar cores existentes de produtos
--Eliminando as repetidas
SELECT DISTINCT Color AS Cores_de_Produtos
FROM Production.Product
WHERE Color IS NOT NULL
ORDER BY Cores_de_Produtos;

--Sem o DISTINCT
SELECT Color AS Cores_de_Produtos
FROM Production.Product
WHERE Color IS NOT NULL
ORDER BY Cores_de_Produtos;

--DISTINCT age em múltiplas colunas
SELECT DISTINCT Name AS Nome_Produto, Color AS Cores_de_Produtos
FROM Production.Product
WHERE Color IS NOT NULL
ORDER BY Nome_Produto, Cores_de_Produtos;

SELECT DISTINCT FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY FirstName, MiddleName, LastName;