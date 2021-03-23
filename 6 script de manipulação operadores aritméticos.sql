/*
Ordem de avalia��o dos operadores (no SQL SERVER)
1. Divis�o (/)
2. Multiplica��o (*)
3. M�dulo (%)
4. Adi��o/Concatena��o (+)
4. Subtra��o (-)
*/

USE AdventureWorks2019
GO

--Aritm�tico
SELECT UnitPrice, OrderQty, (UnitPrice * OrderQty) AS TotalValue
FROM Sales.SalesOrderDetail;

--Parenteses nesse caso n � obrigatorio por causa da ordem de avalia��o
SELECT UnitPrice, UnitPriceDiscount,
(UnitPriceDiscount / UnitPrice) * 100 AS DiscountPercentual
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0;

--Subtra��o
SELECT UnitPrice, UnitPriceDiscount,
UnitPrice - UnitPriceDiscount AS UnitPriceWithDiscount
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0;

--Aten��o para a ordem de avalia��o: Sem parenteses -> resultado errado
SELECT UnitPrice, UnitPriceDiscount, OrderQty,
UnitPrice - UnitPriceDiscount * OrderQty AS TotalWithDiscount
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0;

--Aten��o para a ordem de avalia��o: com parenteses -> Resultado esperado
SELECT UnitPrice, UnitPriceDiscount, OrderQty,
(UnitPrice - UnitPriceDiscount) * OrderQty AS TotalWithDiscount
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0;

--Concatena��o
SELECT FirstName, MiddleName, LastName,
FirstName + ' ' + MiddleName + ' ' + LastName AS NomeCompleto
FROM Person.Person;

SELECT * FROM sys.tables;

--Usando Concatena��o para gerar comandos dinamicamente
SELECT 'DROP TABLE ' + name + ';' FROM sys.tables;


