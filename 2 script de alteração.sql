USE DBTESTE
GO

--Adcionar chave primária
--Clustered significa que a tabela inteira vai ser ordenada por esse atributo.
ALTER TABLE ALUNO
ADD CONSTRAINT PK_ALUNO PRIMARY KEY CLUSTERED(COD_ALUNO);

ALTER TABLE CURSO
ADD CONSTRAINT PK_CURSO PRIMARY KEY CLUSTERED(COD_CURSO);

ALTER TABLE ALUNO
ADD COD_CURSO_FK INT NOT NULL;

--mostra info sobre objetos
sp_help 'ALUNO';

--aumentar tamanho da coluna nome_curso
ALTER TABLE CURSO ALTER COLUMN NOME_CURSO VARCHAR(200) NOT NULL;

--diminuir tamanho da coluna nome_curso
ALTER TABLE CURSO ALTER COLUMN NOME_CURSO VARCHAR(50) NOT NULL;

--inserir dados para teste
INSERT INTO CURSO VALUES (1, 'Linguagem SQL');
INSERT INTO CURSO VALUES (2, 'T-SQL');

SELECT * FROM CURSO;

--TAMANHO DOS VALORES DA COLUNA NOME_CURSO
SELECT COD_CURSO, LEN(NOME_CURSO) FROM CURSO;

--TENTAR diminuir tamanho da coluna nome_curso para menos que a maior entrada
--causa erro, pois existe uma entrada da coluna que tem 13 caracteres
ALTER TABLE CURSO ALTER COLUMN NOME_CURSO VARCHAR(10) NOT NULL;

--Adcionar NOT NULL com tabela populada
--opção 1
ALTER TABLE CURSO ADD VLR_CURSO MONEY NOT NULL; --ERROR
ALTER TABLE CURSO ADD VLR_CURSO MONEY NULL; --SAFE
ALTER TABLE CURSO ALTER COLUMN VLR_CURSO MONEY NOT NULL; --ERROR

UPDATE CURSO SET VLR_CURSO = 10000;
SELECT * FROM CURSO;

--Agora funciona pois nenhuma linha tem essa coluna vazia
ALTER TABLE CURSO ALTER COLUMN VLR_CURSO MONEY NOT NULL;

--opção 2
ALTER TABLE CURSO ADD IND_STATUS CHAR(1) NOT NULL DEFAULT 'S'; --SAFE
SELECT * FROM CURSO;