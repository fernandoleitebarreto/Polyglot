DROP TABLE WORDS_COMPLETE;
DROP TABLE WORDS;
DROP TABLE TAB_SUBCATEGORIA;
DROP TABLE TAB_CATEGORIA;
DROP TABLE TAB_USUARIO;
DROP TABLE PARAMETRO;

CREATE DOMAIN CHAR_1
AS CHAR CHARACTER SET ISO8859_1 COLLATE PT_BR;

CREATE DOMAIN "INTEGER"
AS INTEGER;

CREATE DOMAIN VARCHAR_100
AS VARCHAR(100) CHARACTER SET ISO8859_1 COLLATE PT_BR;

CREATE DOMAIN VARCHAR_15
AS VARCHAR(15) CHARACTER SET ISO8859_1 COLLATE PT_BR;

CREATE DOMAIN VARCHAR_30
AS VARCHAR(30) CHARACTER SET ISO8859_1 COLLATE PT_BR;

CREATE DOMAIN VARCHAR_500
AS VARCHAR(500) CHARACTER SET ISO8859_1 COLLATE PT_BR;

CREATE TABLE PARAMETRO (
    VERSAO     INTEGER,
    DEVELOPER  VARCHAR_100 /* VARCHAR_100 = VARCHAR(100) */
);

CREATE TABLE TAB_CATEGORIA (
    ID           INTEGER NOT NULL,
    DESCRICAO    VARCHAR_100 /* VARCHAR_100 = VARCHAR(100) */,
    IND_ATIVO    CHAR_1 /* CHAR_1 = CHAR(1) */,
    WORD_PHRASE  CHAR_1 DEFAULT 'W' NOT NULL /* CHAR_1 = CHAR(1) */
);

CREATE TABLE TAB_SUBCATEGORIA (
    ID                INTEGER NOT NULL,
    CATEG_ENGLISH     VARCHAR_100 /* VARCHAR_100 = VARCHAR(100) */,
    CATEG_SPANISH     VARCHAR_100 /* VARCHAR_100 = VARCHAR(100) */,
    CATEG_FRENCH      VARCHAR_100 /* VARCHAR_100 = VARCHAR(100) */,
    CATEG_ITALIAN     VARCHAR_100 /* VARCHAR_100 = VARCHAR(100) */,
    CATEG_PORTUGUESE  VARCHAR_100 /* VARCHAR_100 = VARCHAR(100) */,
    IND_ATIVO         CHAR_1 /* CHAR_1 = CHAR(1) */,
    ORDEM             INTEGER,
    ID_CATEGORIA      INTEGER,
    ICONE             VARCHAR_15 /* VARCHAR_15 = VARCHAR(15) */
);

CREATE TABLE TAB_USUARIO (
    ID_USUARIO          "INTEGER" NOT NULL /* "INTEGER" = INTEGER */,
    NOME                VARCHAR_100 /* VARCHAR_100 = VARCHAR(100) */,
    EMAIL               VARCHAR_100 NOT NULL /* VARCHAR_100 = VARCHAR(100) */,
    SENHA               VARCHAR_100 NOT NULL /* VARCHAR_100 = VARCHAR(100) */,
    FOTO                BLOB SUB_TYPE 0 SEGMENT SIZE 80,
    TELEFONE            VARCHAR_30 /* VARCHAR_30 = VARCHAR(30) */,
    COD_RESET_PASSWORD  VARCHAR_15 /* VARCHAR_15 = VARCHAR(15) */,
    NATIVE_LANGUAGE     INTEGER DEFAULT 0,
    COUNTRY             "INTEGER" /* "INTEGER" = INTEGER */,
    FOTO_BKP            BLOB SUB_TYPE 0 SEGMENT SIZE 80,
    ACTIVED             "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */
);


CREATE TABLE WORDS (
    ID                   INTEGER NOT NULL,
    ENGLISH              VARCHAR_500 /* VARCHAR_500 = VARCHAR(500) */,
    SPANISH              VARCHAR_500 /* VARCHAR_500 = VARCHAR(500) */,
    FRENCH               VARCHAR_500 /* VARCHAR_500 = VARCHAR(500) */,
    ITALIAN              VARCHAR_500 /* VARCHAR_500 = VARCHAR(500) */,
    PORTUGUESE           VARCHAR_500 /* VARCHAR_500 = VARCHAR(500) */,
    AUDIO_ENGLISH        VARCHAR_100 /* VARCHAR_100 = VARCHAR(100) */,
    AUDIO_SPANISH        VARCHAR_100 /* VARCHAR_100 = VARCHAR(100) */,
    AUDIO_FRENCH         VARCHAR_100 /* VARCHAR_100 = VARCHAR(100) */,
    AUDIO_ITALIAN        VARCHAR_100 /* VARCHAR_100 = VARCHAR(100) */,
    AUDIO_PORTUGUESE     VARCHAR_100 /* VARCHAR_100 = VARCHAR(100) */,
    ID_SUBCATEGORIA_ENG  INTEGER,
    ID_SUBCATEGORIA_SPN  INTEGER,
    ID_SUBCATEGORIA_FRN  INTEGER,
    ID_SUBCATEGORIA_ITA  INTEGER,
    ID_SUBCATEGORIA_PTB  INTEGER
);

CREATE TABLE WORDS_COMPLETE (
    ID_USUARIO           INTEGER NOT NULL,
    ID_WORD              INTEGER NOT NULL,
    COMPL_ENGLISH        "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    COMPL_SPANISH        "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    COMPL_FRENCH         "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    COMPL_ITALIAN        "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    COMPL_PORTUGUESE     "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    MEMORIZE_ENGLISH     "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    MEMORIZE_SPANISH     "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    MEMORIZE_FRENCH      "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    MEMORIZE_ITALIAN     "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    MEMORIZE_PORTUGUESE  "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    SELECT_ENGLISH       "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    SELECT_SPANISH       "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    SELECT_FRENCH        "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    SELECT_ITALIAN       "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */,
    SELECT_PORTUGUESE    "INTEGER" DEFAULT 0 NOT NULL /* "INTEGER" = INTEGER */
);

CREATE SEQUENCE GEN_CATEGORIA_ID;

CREATE SEQUENCE GEN_SUBCATEGORIA_ID;

CREATE SEQUENCE GEN_USUARIO_ID;

CREATE SEQUENCE GEN_WORDS_ID;

CREATE UNIQUE INDEX UNQ_WORDS_COMPLETE
  ON WORDS_COMPLETE (ID_WORD, ID_USUARIO);

ALTER TABLE TAB_CATEGORIA ADD PRIMARY KEY (ID) ;

ALTER TABLE TAB_SUBCATEGORIA ADD PRIMARY KEY (ID) ;

ALTER TABLE TAB_USUARIO ADD PRIMARY KEY (COD_USUARIO) ;

ALTER TABLE WORDS ADD PRIMARY KEY (ID) ;

ALTER TABLE WORDS ADD CONSTRAINT FK_WORDS_SUBCATEG_ENG FOREIGN KEY (ID_SUBCATEGORIA_ENG) REFERENCES TAB_SUBCATEGORIA (ID) ON UPDATE CASCADE;
ALTER TABLE WORDS ADD CONSTRAINT FK_WORDS_SUBCATEG_FRN FOREIGN KEY (ID_SUBCATEGORIA_FRN) REFERENCES TAB_SUBCATEGORIA (ID) ON UPDATE CASCADE;
ALTER TABLE WORDS ADD CONSTRAINT FK_WORDS_SUBCATEG_ITA FOREIGN KEY (ID_SUBCATEGORIA_ITA) REFERENCES TAB_SUBCATEGORIA (ID) ON UPDATE CASCADE;
ALTER TABLE WORDS ADD CONSTRAINT FK_WORDS_SUBCATEG_PTB FOREIGN KEY (ID_SUBCATEGORIA_PTB) REFERENCES TAB_SUBCATEGORIA (ID) ON UPDATE CASCADE;
ALTER TABLE WORDS ADD CONSTRAINT FK_WORDS_SUBCATEG_SPN FOREIGN KEY (ID_SUBCATEGORIA_SPN) REFERENCES TAB_SUBCATEGORIA (ID) ON UPDATE CASCADE;

ALTER TABLE TAB_SUBCATEGORIA ADD CONSTRAINT FK_TAB_SUBCATEGORIA FOREIGN KEY (ID_CATEGORIA) REFERENCES TAB_CATEGORIA (ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE WORDS_COMPLETE ADD CONSTRAINT FK_WORDS_COMPLETE FOREIGN KEY (ID_WORD) REFERENCES WORDS (ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE WORDS_COMPLETE ADD CONSTRAINT FK_WORDS_USUARIO FOREIGN KEY (ID_USUARIO) REFERENCES TAB_USUARIO (ID_USUARIO) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE OR ALTER TRIGGER TR_CATEGORIA FOR TAB_CATEGORIA
ACTIVE
BEFORE INSERT
POSITION 0 
AS
BEGIN
   if (new.ID is null) then
     new.ID = gen_id(GEN_CATEGORIA_ID, 1);
END;

CREATE OR ALTER TRIGGER TR_SUBCATEGORIA FOR TAB_SUBCATEGORIA
ACTIVE
BEFORE INSERT
POSITION 0 
AS
BEGIN
   if (new.ID is null) then
     new.ID = gen_id(GEN_SUBCATEGORIA_ID, 1);
END;

CREATE OR ALTER TRIGGER TR_USUARIO FOR TAB_USUARIO
ACTIVE
BEFORE INSERT
POSITION 0 
AS
BEGIN
   if (new.COD_USUARIO is null) then
     new.COD_USUARIO = gen_id(GEN_USUARIO_ID, 1);
END;

CREATE OR ALTER TRIGGER TR_WORDS FOR WORDS
ACTIVE
BEFORE INSERT
POSITION 0 
AS
BEGIN
   if (new.ID is null) then
     new.ID = gen_id(GEN_WORDS_ID, 1);
END;
