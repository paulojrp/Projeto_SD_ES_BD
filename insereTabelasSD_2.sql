DELETE FROM TRANSACCOES;
DELETE FROM TOPICO_IDEIA;
DELETE FROM IDEIA_IDEIA;
DELETE FROM PENDING_TRANSACTION;
DELETE FROM OFFLINE_USERS;
DELETE FROM TOPICO;
DELETE FROM USER_SHARE;
DELETE FROM IDEIA;
DELETE FROM UTILIZADOR;
DELETE FROM CHAVES;


DROP TABLE TOPICO_IDEIA;
DROP TABLE IDEIA_IDEIA;
DROP TABLE PENDING_TRANSACTION;
DROP TABLE OFFLINE_USERS;
DROP TABLE TOPICO;
DROP TABLE USER_SHARE;
DROP TABLE IDEIA;
DROP TABLE CHAVES;
DROP TABLE TRANSACCOES;
DROP TABLE UTILIZADOR;

DROP TABLE TOPICO;
CREATE TABLE TOPICO
(IDTOPICO	         NUMERIC           PRIMARY KEY,   
 NOME              VARCHAR2(20)      NOT NULL
);

DROP TABLE IDEIA;
CREATE TABLE IDEIA
(IDIDEIA	         NUMERIC           PRIMARY KEY,
 MENSAGEM          VARCHAR2(350)     NOT NULL,
 TOTAL_SHARE			 NUMERIC           NOT NULL,
 IS_FIRST             NUMBER(1)           NOT NULL,
 ANEXO 				     VARCHAR2(20)           NULL	
);

DROP TABLE HALL_OF_FAME;
CREATE TABLE HALL_OF_FAME
(IDIDEIA	              NUMERIC           PRIMARY KEY,
 MENSAGEM               VARCHAR2(350)     NOT NULL,
 INIT_VALUATION         NUMERIC           NOT NULL,
 FINAL_VALUATION        NUMERIC           NOT NULL,
 ANEXO 				          VARCHAR2(20)      NULL	
);

DROP TABLE WATCHLIST;
CREATE TABLE WATCHLIST
(IDIDEIA	         NUMERIC           NOT NULL,
 IDUSER	           NUMERIC           NOT NULL,
 FOREIGN KEY (IDIDEIA) REFERENCES IDEIA(IDIDEIA),
 FOREIGN KEY (IDUSER) REFERENCES UTILIZADOR(IDUSER)
 ON DELETE CASCADE
);


DROP TABLE UTILIZADOR; 
CREATE TABLE UTILIZADOR
(IDUSER            NUMERIC          PRIMARY KEY,
 USERNAME          VARCHAR2(20)      NOT NULL,
 PASSWORD          VARCHAR2(32)      NOT NULL,
 DINHEIRO			     NUMERIC(20,5)          NOT NULL
);
INSERT INTO UTILIZADOR (IDUSER, USERNAME, PASSWORD, DINHEIRO)
VALUES (0,'ROOT','ROOT', 10000);


DROP TABLE USER_SHARE; 
CREATE TABLE USER_SHARE 
(IDUSER_SHARE	      NUMERIC          PRIMARY KEY,
 IDIDEIA            NUMERIC           NOT NULL,
 IDUSER             NUMERIC           NOT NULL,
 PRICE      	      NUMERIC(20,5)          NOT NULL,
 NR_SHARE           NUMERIC           NOT NULL,
 FOREIGN KEY (IDIDEIA) REFERENCES IDEIA(IDIDEIA),
 FOREIGN KEY (IDUSER) REFERENCES UTILIZADOR(IDUSER)
 ON DELETE CASCADE
);

DROP TABLE PENDING_TRANSACTION;
CREATE TABLE PENDING_TRANSACTION
(IDUSER           NUMERIC             NOT NULL,
IDIDEIA           NUMERIC             NOT NULL,
NEWPRICE          NUMERIC(20,5)       NOT NULL,
MAXPRICE		  NUMERIC(20,5)       NOT NULL,
NR_SHARE          NUMERIC             NOT NULL,
 FOREIGN KEY (IDIDEIA) REFERENCES IDEIA(IDIDEIA),
 FOREIGN KEY (IDUSER) REFERENCES UTILIZADOR(IDUSER)
  ON DELETE CASCADE
);

DROP TABLE OFFLINE_USERS;
CREATE TABLE OFFLINE_USERS
(IDUSER             NUMERIC           PRIMARY KEY,
 USERS_BUYERS        VARCHAR2(120)     NOT NULL,
 FOREIGN KEY (IDUSER) REFERENCES UTILIZADOR(IDUSER)
);

DROP TABLE TOPICO_IDEIA;
CREATE TABLE  TOPICO_IDEIA
(IDTOPICO           NUMERIC          PRIMARY KEY,
 IDIDEIA            NUMERIC          PRIMARY KEY,
 FOREIGN KEY(IDTOPICO) REFERENCES TOPICO(IDTOPICO),
 FOREIGN KEY(IDIDEIA) REFERENCES IDEIA(IDIDEIA)
  ON DELETE CASCADE
);

DROP TABLE TRANSACCOES;
CREATE TABLE TRANSACCOES
(IDUSER           NUMERIC           NOT NULL,
 DESCRIPTION      VARCHAR2(200)    NOT NULL,
 DATA             VARCHAR2(40)       NOT NULL,
 FOREIGN KEY (IDUSER) REFERENCES UTILIZADOR(IDUSER)
);

CREATE SEQUENCE CIDEIA
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE SEQUENCE CUTILIZADOR
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE SEQUENCE CUSER_SHARE
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE OR REPLACE TRIGGER USER_SHARE_REMOVAL
AFTER UPDATE
   OF NR_SHARE ON USER_SHARE
BEGIN
   DELETE FROM USER_SHARE 
   WHERE NR_SHARE = 0;
END;

/*  
DROP TABLE CHAVES;
CREATE TABLE CHAVES
(CTOPICO           NUMERIC          NOT NULL,
 CIDEIA            NUMERIC          NOT NULL,
 CUTILIZADOR       NUMERIC          NOT NULL,
 CUSER_SHARE       NUMERIC          NOT NULL
);

INSERT INTO CHAVES (CTOPICO, CIDEIA, CUTILIZADOR, CUSER_SHARE)
VALUES (1,1,1,1); 
  
DROP TABLE IDEIA_IDEIA;
CREATE TABLE IDEIA_IDEIA
(IDIDEIA            NUMERIC           NULL,
 IDIDEIADOWN        NUMERIC           NOT NULL,
 OPINIAO           VARCHAR2(7)       NOT NULL,
 FOREIGN KEY(IDIDEIADOWN) REFERENCES IDEIA (IDIDEIA)
 ON DELETE CASCADE
);*/