USE AdventureWorks2019;
GO

SELECT Name, ProductNumber FROM Production.Product;
GO

SELECT * FROM Production.Product;
GO

--Adcionar coluna e repetir comando
ALTER TABLE Production.Product
ADD SpecialEdition BIT NULL;
GO

--Objeto inexistente
SELECT Name, ProductNumber
FROM master.Production.Product
GO

SELECT Name, ProductNumber
FROM AdventureWorks2019.Production.Product
GO

--Coluna inexistente
SELECT ProductName, ProductNumber
FROM AdventureWorks2019.Production.Product
GO

--Alias para colunas
SELECT Name AS Nome_do_Produto, 
ProductNumber AS Número_do_Produto
FROM Production.Product;
GO

--Outra forma de criar alias
SELECT Nome_do_Produto = Name, 
Número_do_Produto = ProductNumber
FROM Production.Product;
GO

--Alias de tabelas
SELECT P.Name,  P.ProductNumber FROM Production.Product P
GO

--Ambiguidade de Colunas
SELECT Name, ProductNumber, Name
FROM Production.Product, Production.Location
GO

--Ambiguidade de Colunas
SELECT P.Name, P.ProductNumber, L.Name
FROM Production.Product P, Production.Location L
GO

--Prefixar colunas com nome de tabelas tb resolve
SELECT Product.Name, Product.ProductNumber, Location.Name
FROM Production.Product, Production.Location
GO