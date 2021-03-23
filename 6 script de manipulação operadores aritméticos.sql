/*
Ordem de avaliação dos operadores (no SQL SERVER)
1. Divisão (/)
2. Multiplicação (*)
3. Módulo (%)
4. Adição/Concatenação (+)
4. Subtração (-)
*/

USE AdventureWorks2019
GO

--Aritmético
SELECT UnitPrice, OrderQty, (UnitPrice * OrderQty) AS TotalValue
FROM Sales.SalesOrderDetail;

--Parenteses nesse caso n é obrigatorio por causa da ordem de avaliação
SELECT UnitPrice, UnitPriceDiscount,
(UnitPriceDiscount / UnitPrice) * 100 AS DiscountPercentual
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0;

--Subtração
SELECT UnitPrice, UnitPriceDiscount,
UnitPrice - UnitPriceDiscount AS UnitPriceWithDiscount
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0;

--Atenção para a ordem de avaliação: Sem parenteses -> resultado errado
SELECT UnitPrice, UnitPriceDiscount, OrderQty,
UnitPrice - UnitPriceDiscount * OrderQty AS TotalWithDiscount
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0;

--Atenção para a ordem de avaliação: com parenteses -> Resultado esperado
SELECT UnitPrice, UnitPriceDiscount, OrderQty,
(UnitPrice - UnitPriceDiscount) * OrderQty AS TotalWithDiscount
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0;

--Concatenação
SELECT FirstName, MiddleName, LastName,
FirstName + ' ' + MiddleName + ' ' + LastName AS NomeCompleto
FROM Person.Person;

SELECT * FROM sys.tables;

--Usando Concatenação para gerar comandos dinamicamente
SELECT 'DROP TABLE ' + name + ';' FROM sys.tables;


