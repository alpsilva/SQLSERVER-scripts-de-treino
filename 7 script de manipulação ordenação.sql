USE AdventureWorks2019
GO

--Classificando pelo primeiro nome de forma ascendente
SELECT FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY FirstName;

--Classificando pelo primeiro nome de forma descendente
SELECT FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY FirstName DESC;

--Classificando pelo primeiro nome de forma ascendente
-- e pelo ultimo de forma descendente
SELECT FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY FirstName ASC, LastName DESC;

--usar campo que não está na lista de colunas
SELECT FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY ModifiedDate;

--Usando número da coluna no ORDER BY
SELECT FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY 1;

SELECT FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY 1 ASC, 3 DESC;