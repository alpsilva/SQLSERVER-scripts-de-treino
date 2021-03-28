USE AdventureWorks2019
GO

CREATE TABLE dbo.TAB1(
	COL1 INT NOT NULL,
	COL2 VARCHAR(3) DEFAULT 'SIM',
	COL3 DATETIME NOT NULL
);

--INSERT INTO
--Especificando o nome das colunas explicitamente
SET LANGUAGE Português
GO
SELECT @@LANGUAGE
GO

INSERT INTO dbo.TAB1 (COL1, COL2, COL3)
VALUES (1, 'NÃO', '23/09/2019 00:00:00.000');
GO

SELECT * FROM dbo.TAB1;
GO

--Especificando o nome das colunas explicitamente e a ordem das colunas
INSERT INTO dbo.TAB1 (COL3, COL2, COL1)
VALUES ('24/09/2019 00:00:00.000', 'NÃO', 2);
GO

SELECT * FROM dbo.TAB1;
GO

--omitindo o nome das colunas
INSERT INTO dbo.TAB1
VALUES (3, 'NÃO', '25/09/2019 00:00:00.000');
GO
SELECT * FROM dbo.TAB1;
GO

--Omitindo o nome das colunas (erro na ordem)
INSERT INTO dbo.TAB1
VALUES ('NÃO', '25/09/2019 00:00:00.000', 4);
GO

--Se conversão implicita fosse possível
CREATE TABLE dbo.TAB2(
	COL1 INT,
	COL2 VARCHAR(1)
);

INSERT INTO dbo.TAB2
VALUES (10, 20)
GO
SELECT * FROM dbo.TAB2
GO

INSERT INTO dbo.TAB2
VALUES (10, 2)
GO
SELECT * FROM dbo.TAB2
GO

--Se a coluna do mesmo tipo de dados: linha com dados "inválidos"
CREATE TABLE dbo.TAB3(
	IDADE INT,
	COMISSAO INT
);
GO
--Uma pessoa de 50 anos com uma comissao de 5, mas por engano a ordem foi invertida
INSERT INTO dbo.TAB3
VALUES (5, 50);
GO
--Não dá erro, pois há compatibilidade, mas o significado do dado foi perdido.
SELECT * FROM dbo.TAB3;
GO

--Omitindo a cláusula INTO
INSERT dbo.TAB1 (COL1, COL2, COL3)
VALUES (4, 'NÃO', '25/09/2019 00:00:00.000');
GO
SELECT * FROM dbo.TAB1;
GO

--insert em várias linhas
INSERT dbo.TAB1 (COL1, COL2, COL3)
VALUES (5, 'NÃO', '27/09/2019 00:00:00.000'),
		(6, 'NÃO', '28/09/2019 00:00:00.000'),
		(7, 'NÃO', '29/09/2019 00:00:00.000');
GO
SELECT * FROM dbo.TAB1;
GO

--insert em colunas que tem Default
INSERT dbo.TAB1 (COL1, COL3)
VALUES (8, '30/09/2019 00:00:00.000');

INSERT dbo.TAB1 (COL1, COL2, COL3)
VALUES (9, DEFAULT, '01/10/2019 00:00:00.000');
GO
SELECT * FROM dbo.TAB1;
GO

--INSERT de valores nulos
INSERT dbo.TAB1 (COL1, COL2, COL3)
VALUES (10, NULL, '02/10/2019 00:00:00.000');
GO
SELECT * FROM dbo.TAB1;
GO

--Usando funções no INSERT
INSERT dbo.TAB1 (COL1, COL2, COL3)
VALUES (11, NULL, GETDATE());
GO
SELECT * FROM dbo.TAB1;
GO

--INSERT x Foreign Key
ALTER TABLE DBO.TAB1
ADD CONSTRAINT PK_TAB1 PRIMARY KEY CLUSTERED(COL1);
GO

CREATE TABLE dbo.TAB4 (COL4 INT NOT NULL, COL1_FK INT NOT NULL);
GO

ALTER TABLE dbo.TAB4
ADD CONSTRAINT FK_COL1_TAB1 FOREIGN KEY (COL1_FK) REFERENCES dbo.TAB1(COL1);
GO

--Erro: Valor 0 para a chave estrangeira não foi encontrado na tabela pai.
INSERT dbo.TAB4 (COL4, COL1_FK)
VALUES (1, 0);
GO

INSERT dbo.TAB1 (COL1, COL2, COL3)
VALUES (0, NULL, GETDATE());
GO

--Agora funciona.
INSERT dbo.TAB4 (COL4, COL1_FK)
VALUES (1, 0);
GO

SELECT * FROM dbo.TAB4;
GO

--INSERT com campos IDENTITY (SQL SERVER)
--Nesse caso, começa em 1000 e incrementa de 1 em 1
CREATE TABLE dbo.TAB5 (
	COL5 INT IDENTITY (1000, 1) NOT NULL,
	COL6 CHAR(1) NOT NULL
);
GO

INSERT dbo.TAB5(COL6)
VALUES ('A'),
	('B'),
	('C'),
	('D'),
	('E')
GO

SELECT * FROM TAB5;

--INSERT com SEQUENCE
--Não fica atrlada à tabela / campo
CREATE SEQUENCE dbo.SEQUENCE_TAB6
AS INT
START WITH 100
INCREMENT BY 1
GO

CREATE TABLE dbo.TAB6 (
	COL6 INT NOT NULL,
	COL7 CHAR(1) NOT NULL
);

INSERT dbo.TAB6 (COL6, COL7)
VALUES (NEXT VALUE FOR dbo.SEQUENCE_TAB6, 'A'),
	(NEXT VALUE FOR dbo.SEQUENCE_TAB6, 'B'),
	(NEXT VALUE FOR dbo.SEQUENCE_TAB6, 'C'),
	(NEXT VALUE FOR dbo.SEQUENCE_TAB6, 'D'),
	(NEXT VALUE FOR dbo.SEQUENCE_TAB6, 'E')
GO

SELECT * FROM TAB6;
GO

--INSERT com SELECT
CREATE TABLE dbo.SUB_TAB6 (
	COL6 INT NOT NULL,
	COL7 CHAR(1) NOT NULL
);
GO

INSERT INTO dbo.SUB_TAB6
SELECT COL6, COL7
FROM dbo.TAB6
WHERE COL6 >= 103;
GO

--Obs.: Pode usar todos os recursos do select

SELECT * FROM SUB_TAB6;
GO

--Erro: Colunas não nulas sem dados retornados pelo sect
INSERT INTO dbo.SUB_TAB6
SELECT COL6
FROM dbo.TAB6
WHERE COL6 >= 103;
GO

--Mais colunas que existem na tabela
INSERT INTO dbo.SUB_TAB6
SELECT *
FROM dbo.TAB1
GO

--INSERT COM EXEC
EXEC sp_helpdb
GO

CREATE TABLE dbo.TAB_BDs(
	NOM_BANCO VARCHAR(MAX),
	TAM_BANCO VARCHAR(255),
	NOM_PROPRIETARIO VARCHAR(255),
	ID_BANCO INT,
	DAT_CRAICAO DATETIME,
	DSC_STATUS VARCHAR(MAX),
	DSC_COMPATIB SMALLINT
);

INSERT dbo.TAB_BDs
EXEC sp_helpdb;
GO

SELECT * FROM dbo.TAB_BDs;

--SELECT INTO
EXEC sp_help 'dbo.TAB1';
GO

EXEC sp_help 'dbo.TAB1_COPIA';
GO

SELECT * 
INTO dbo.TAB1_COPIA
FROM dbo.TAB1;
GO
--Obs.: Não cria constraints e chaves junto.
SELECT * FROM dbo.TAB1;
GO
SELECT * FROM dbo.TAB1_COPIA;
GO