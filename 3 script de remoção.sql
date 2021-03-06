CREATE DATABASE DBTESTE_DROP;
GO
USE DBTESTE_DROP;
GO

CREATE TABLE ALUNO(
	COD_ALUNO INT NOT NULL,
	NOM_ALUNO VARCHAR(100) NOT NULL
);
GO

CREATE TABLE [dbo].[CURSO](
	[COD_CURSO] [INT] NOT NULL,
	[NOME_CURSO] [VARCHAR](100) NOT NULL
);
GO

CREATE TABLE [dbo].[MATRICULA](
	[COD_ALUNO] [INT] NOT NULL,
	[COD_CURSO] [INT] NOT NULL,
	[DATA_MATRICULA] [DATETIME] NOT NULL
) ON [PRIMARY];
GO

CREATE SYNONYM TB_ALUNO_NEW FOR ALUNO;
GO

DROP SYNONYM TB_ALUNO_NEW;

--Remover coluna (n ? objeto independente)
ALTER TABLE ALUNO DROP COLUMN NOM_ALUNO;

--remover db
USE master;
DROP DATABASE DBTESTE_DROP;