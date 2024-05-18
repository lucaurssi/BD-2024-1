
-- Entidades:

DROP TABLE IF EXISTS Usuario CASCADE;
CREATE TABLE Usuario(
    ID          DECIMAL(8)  not NULL PRIMARY KEY,
    Nome        VARCHAR(40) not NULL,
    Sobrenome   VARCHAR(80) not NULL,
    Telefone    CHAR(10)    not NULL,
    Data_Nascimento DATE,
    Sexo        CHAR(1),
    Endereço    VARCHAR(80),
    Email       VARCHAR(50) not NULL,
    Senha       VARCHAR(20) not NULL
    );

DROP TABLE IF EXISTS ContaBancaria CASCADE;
CREATE TABLE ContaBancaria(
    ID          DECIMAL(8)  not NULL PRIMARY KEY,
    Roteamento  DECIMAL(8)  not NULL,
    Tipo        VARCHAR(20) not NULL,
    Dono        DECIMAL(8)  not NULL,
        FOREIGN KEY (Dono) REFERENCES Usuario (ID)
            ON DELETE CASCADE ON UPDATE CASCADE
    );
    
DROP TABLE IF EXISTS Propriedade CASCADE;
CREATE TABLE Propriedade(
    ID          DECIMAL(8)  not NULL PRIMARY KEY,
    Classificacao DECIMAL(1)  not NULL,
    Endereço    VARCHAR(100) not NULL,
    NroBanheiros DECIMAL(2)  DEFAULT 0,
    NroQuartos  DECIMAL(2)  DEFAULT 0,
    MaxHospedes  DECIMAL(3),
    Diaria      NUMERIC DEFAULT 0,
    Limpeza     NUMERIC DEFAULT 0,
    Min_Noite   Decimal(3) DEFAULT 1,
    Max_Noite   Decimal(3),
    hr_checkin  TIME not NULL,
    hr_checkout TIME not NULL,
    Disponibilidade_inicio DATE not NULL,  
    Disponibilidade_fim DATE not NULL,  
    NroTipoCamas VARCHAR(50),
    Comodidades  VARCHAR(50), 
    Regras       VARCHAR(50),
    Interesses   VARCHAR(50),
    Dono        DECIMAL(8)  not NULL,
        FOREIGN KEY (DONO) REFERENCES Usuario (ID)
            ON DELETE CASCADE ON UPDATE CASCADE
    );

-- Relacoes:
    
DROP TABLE IF EXISTS TrocaMensagem CASCADE;
CREATE TABLE TrocaMensagem(
    Timestamp TIMESTAMP NOT NULL,
    User1     DECIMAL(8) NOT NULL,
    User2     DECIMAL(8) NOT NULL,
    Mensagem  VARCHAR(100) NOT NULL,
        PRIMARY KEY (TimeStamp, User1, User2),
        FOREIGN KEY (User1) REFERENCES Usuario (ID)
            ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (User2) REFERENCES Usuario (ID)
            ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Fotos CASCADE;
CREATE TABLE Fotos(
    Timestamp TIMESTAMP NOT NULL,
    User1     DECIMAL(8) NOT NULL,
    User2     DECIMAL(8) NOT NULL,
    Foto      VARCHAR(100) NOT NULL,
        PRIMARY KEY (TimeStamp, User1, User2, Foto),
        FOREIGN KEY (TimeStamp, User1, User2) 
            REFERENCES TrocaMensagem (TimeStamp, User1, User2)
            ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Avalia CASCADE;
CREATE TABLE Avalia(
    Timestamp   TIMESTAMP NOT NULL,
    Propriedade DECIMAL(8) NOT NULL,
    Mensagem    VARCHAR(100) NOT NULL,
    Limpeza     Decimal(2) DEFAULT 0,
    Comunicacao Decimal(2) DEFAULT 0,
    Localizacao Decimal(2) DEFAULT 0,
    valor       Decimal(2) DEFAULT 0,
    Hospede DECIMAL(8) NOT NULL,
        PRIMARY KEY (TimeStamp, Hospede, Propriedade),
        FOREIGN KEY (Hospede) REFERENCES Usuario (ID)
            ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Propriedade) REFERENCES Propriedade (ID)
            ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS FotosAvaliacao CASCADE;
CREATE TABLE FotosAvaliacao(
    Timestamp TIMESTAMP NOT NULL,
    Hospede      Decimal(8) NOT NULL,
    Propriedade DECIMAL(8) NOT NULL,
    Foto      VARCHAR(100) NOT NULL,
        PRIMARY KEY (TimeStamp, Hospede, Propriedade, Foto),
        FOREIGN KEY (TimeStamp, Hospede, Propriedade) 
            REFERENCES Avalia (TimeStamp, Hospede, Propriedade)
            ON DELETE CASCADE ON UPDATE CASCADE
);


DROP TABLE IF EXISTS Locacao CASCADE;
CREATE TABLE Locacao(
    DataReserva  TIMESTAMP NOT NULL,
    Hospede      DECIMAL(8) NOT NULL,
    Propriedade  DECIMAL(8) NOT NULL,
    Checkin      DATE,
    Checkout     DATE,
    NroHospedes  DECIMAL(3),
    imposto      NUMERIC,
    DESCONTO     NUMERIC,
    COD_PROMO    NUMERIC,
        PRIMARY KEY (DataReserva, Hospede, Propriedade),
        FOREIGN KEY (Hospede) REFERENCES Usuario (ID)
            ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Propriedade) REFERENCES Propriedade (ID)
            ON DELETE CASCADE ON UPDATE CASCADE
);