USE AdventureWorks2019
GO

--INNER JOIN
SELECT Production.ProductCategory.Name AS categoria,
		Production.ProductSubcategory.Name AS subcategoria
FROM Production.ProductCategory
INNER JOIN Production.ProductSubcategory
ON Production.ProductCategory.ProductCategoryID = Production.ProductSubcategory.ProductcategoryID
ORDER BY categoria ASC, subcategoria ASC;

--Listar produtos, categoria e subcategorias usando alias
SELECT P.Name AS Nome,
	S.Name AS subcategoria,
	C.Name AS categoria
FROM Production.Product P
INNER JOIN Production.ProductSubcategory S
ON P.ProductSubcategoryID = S.ProductSubcategoryID
INNER JOIN Production.ProductCategory C
ON c.ProductCategoryID = s.ProductCategoryID
ORDER BY nome ASC;

--Em OUTER JOINS, a ordem importa
--LEFT OUTER JOIN
/*
Puxa todos as instâncias da primeira tabela,
mesmo que não haja correspondencia na segunda.
*/

--Listar todos os produtos (com venda ou não) e seus valores venais
SELECT P.Name AS Nome_Produto, S.UnitPrice AS Valor_Venda
FROM Production.Product P
LEFT JOIN Sales.SalesOrderDetail S
ON P.ProductID = S.ProductID
ORDER BY Nome_Produto ASC, Valor_Venda ASC;

--Invertendo a ordem das tabelas: Listar TODAS as vendas e seus produtos
SELECT P.Name AS Nome_Produto, S.UnitPrice AS Valor_Venda
FROM Sales.SalesOrderDetail S
LEFT JOIN Production.Product P
ON P.ProductID = S.ProductID
ORDER BY Nome_Produto ASC, Valor_Venda ASC;

--RIGHT OUTER JOIN
/*
O contrário do LEFT: Puxa todos as instâncias da segunda tabela,
mesmo que não haja correspondencia na primeira.
*/
--Listar TODAS as vendas e seus produtos
SELECT P.Name AS Nome_Produto, S.UnitPrice AS Valor_Venda
FROM Production.Product P
RIGHT JOIN Sales.SalesOrderDetail S
ON P.ProductID = S.ProductID
ORDER BY Nome_Produto ASC, Valor_Venda ASC;

--FULL OUTER JOINS: Tudo com tudo
--Listar todos os produtos e todos os modelos
SELECT P.Name AS Nome_Produto, M.Name AS Modelo
FROM Production.Product P
FULL JOIN Production.ProductModel M
ON P.ProductModelID = M.ProductModelID
ORDER BY Nome_Produto, Modelo;

--ordem inversa do full join (mesmo resultado)
SELECT P.Name AS Nome_Produto, M.Name AS Modelo
FROM Production.ProductModel M
FULL JOIN Production.Product P
ON P.ProductModelID = M.ProductModelID
ORDER BY Nome_Produto, Modelo;



--self JOINS: Não tem como evitar o uso de ALIAS
CREATE TABLE employee(
ID INT primary key,
Name VARCHAR(50),
ID_Manager INT
);

INSERT INTO employee (ID, Name, ID_Manager) VALUES (1, 'Andre', NULL);
INSERT INTO employee (ID, Name, ID_Manager) VALUES (2, 'Paulo', 1);
INSERT INTO employee (ID, Name, ID_Manager) VALUES (3, 'Pedro', 1);
INSERT INTO employee (ID, Name, ID_Manager) VALUES (4, 'Roberta', 2);
INSERT INTO employee (ID, Name, ID_Manager) VALUES (5, 'Carlos', 3);

--self INNER JOIN
--Listar funcionário e respectivo gerente
SELECT E1.Name AS Funcionario, E2.Name AS gerente
FROM Employee E1
INNER JOIN Employee E2
ON E1.ID_Manager = E2.ID;

--self LEFT OUTER JOIN
--Listar funcionário e respectivo gerente
--(dessa vez, quem não tem gerente aparece)
SELECT E1.Name AS Funcionario, E2.Name AS gerente
FROM Employee E1
LEFT JOIN Employee E2
ON E1.ID_Manager = E2.ID;

