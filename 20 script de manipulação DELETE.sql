USE AdventureWorks2019
GO

--DELETE com WHERE simples
SELECT * FROM TAB1;
GO

DELETE TAB1
WHERE COL1 = 11;
GO

--DELETE com WHERE composto
DELETE TAB1
WHERE COL1 BETWEEN 9 AND 12
GO

SELECT * FROM TAB1;
GO

--DELETE "aleatório"
DELETE TOP(2) TAB1;
GO

--DELETE sem WHERE
DELETE FROM TAB1;
GO

--DELETE sem WHERE vs TRUNCATE
SELECT *
INTO SalesOrderDetail_DELETE
FROM Sales.SalesOrderDetail;
GO

SELECT *
INTO SalesOrderDetail_TRUNCATE
FROM Sales.SalesOrderDetail;
GO

SELECT COUNT(*) FROM SalesOrderDetail_DELETE;
GO
SELECT COUNT(*) FROM SalesOrderDetail_TRUNCATE;
GO

--Client Statistics
DELETE SalesOrderDetail_DELETE;
GO
TRUNCATE TABLE SalesOrderDetail_TRUNCATE;
GO

--DELETE com funções
SELECT * FROM TAB1_COPIA;
GO

DELETE FROM TAB1_COPIA
WHERE COL3 <= GETDATE()-7;
GO

--DELETE com subconsultas
DELETE FROM Sales.SalesPersonQuotaHistory
WHERE BusinessEntityID IN (
	SELECT BusinessEntityID
	FROM SALES.SalesPerson
	WHERE SalesYTD > 2500000
);
GO

--DELETE com JOIN
DELETE FROM Sales.SalesPersonQuotaHistory
FROM Sales.SalesPersonQuotaHistory AS spqh
INNER JOIN Sales.SalesPerson AS sp
ON spqh.BusinessEntityID = sp.BusinessEntityID
WHERE sp.SalesYTD > 2000000;
GO

--DELETE vs Integridade Referencial (CASCADE)
--Default é o RESTRICT (NO ACTION), que não deixa apagar registros pais que tenham filhos
CREATE TABLE dbo.Socios_Titulares
(
	NUM_COTA INT NOT NULL PRIMARY KEY,
	NOME VARCHAR(255) NOT NULL
);
GO

CREATE TABLE dbo.Socios_Dependentes
(
	Id_Dependente INT NOT NULL,
	NUM_COTA_FK INT NOT NULL,
	NOME VARCHAR(255) NOT NULL
);
GO

ALTER TABLE dbo.Socios_Dependentes
ADD CONSTRAINT FK_Titular FOREIGN KEY (NUM_COTA_FK) REFERENCES Socios_Titulares (NUM_COTA)
ON DELETE CASCADE;
GO

INSERT INTO dbo.Socios_Titulares
VALUES (1, 'Gustavo');
GO

INSERT INTO dbo.Socios_Dependentes
VALUES (1, 1, 'Juliana'),
	(2, 1, 'Pedro'),
	(3, 1, 'Giovana'),
	(4, 1, 'Davi')
GO

SELECT * FROM Socios_Titulares;
GO
SELECT * FROM Socios_Dependentes;
GO

DELETE FROM dbo.Socios_Titulares
WHERE NUM_COTA = 1;
GO

--DELETE vs Integridade Referencial (SET NULL)
ALTER TABLE Socios_Dependentes
DROP CONSTRAINT FK_Titular;
GO

ALTER TABLE Socios_Dependentes
ADD CONSTRAINT FK_Titular FOREIGN KEY (NUM_COTA_FK) REFERENCES Socios_Titulares (NUM_COTA)
ON DELETE SET NULL;
GO
--dá erro pois a coluna num_cota_fk não aceita valores nulos. Como resolver?
--alterando a coluna:
ALTER TABLE Socios_Dependentes ALTER COLUMN NUM_COTA_FK INT NULL;
GO

INSERT INTO dbo.Socios_Titulares
VALUES (1, 'Gustavo');
GO

INSERT INTO dbo.Socios_Dependentes
VALUES (1, 1, 'Juliana'),
	(2, 1, 'Pedro'),
	(3, 1, 'Giovana'),
	(4, 1, 'Davi')
GO

--Tentando novamente
ALTER TABLE Socios_Dependentes
ADD CONSTRAINT FK_Titular FOREIGN KEY (NUM_COTA_FK) REFERENCES Socios_Titulares (NUM_COTA)
ON DELETE SET NULL;
GO

DELETE FROM dbo.Socios_Titulares
WHERE NUM_COTA = 1;
GO

SELECT * FROM Socios_Titulares;
GO
SELECT * FROM Socios_Dependentes;
GO