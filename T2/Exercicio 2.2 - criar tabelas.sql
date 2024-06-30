DROP TABLE IF EXISTS Localização CASCADE;
CREATE TABLE Localização(
    pais        varchar(50) not NULL,
    estado      varchar(50) not NULL,
    cidade      varchar(50) not NULL,
    bairro      varchar(50),
    PRIMARY KEY (pais, estado, cidade)
);

DROP TABLE IF EXISTS Usuario CASCADE;
CREATE TABLE Usuario(
    ID          DECIMAL(8)  not NULL PRIMARY KEY,
    Nome        VARCHAR(40) not NULL,
    Sobrenome   VARCHAR(80) not NULL,
    Telefone    CHAR(10)    not NULL,
    Data_Nascimento DATE,
    Sexo        CHAR(1),
    Email       VARCHAR(50),
    Senha       VARCHAR(20),
    numero      DECIMAL(5),
    rua         varchar(100),
    cidade      varchar(50),
    CEP         DECIMAL(8),
    pais        varchar(50),
    estado      varchar(50),
    cidade_Localização varchar(50),
    UNIQUE(Nome, Sobrenome, Telefone),
    FOREIGN KEY (pais, estado, cidade_Localização) 
        REFERENCES Localização (pais, estado, cidade)
        ON DELETE CASCADE ON UPDATE CASCADE
    );

DROP TABLE IF EXISTS Tipo_Usuario CASCADE;
CREATE TABLE Tipo_Usuario(
    Usuario     DECIMAL(8) not NULL PRIMARY KEY,
    hospede     bool DEFAULT FALSE,
    Dono        bool DEFAULT FALSE
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
    ID          DECIMAL(8)   not NULL PRIMARY KEY,
    Nome        VARCHAR(40)  not NULL,
    numero      DECIMAL(5)   not NULL,
    rua         varchar(100) not NULL,
    cidade      varchar(50)  not NULL,
    CEP         DECIMAL(8)   not NULL,
    pais        varchar(50),
    estado      varchar(50),
    cidade_Localização varchar(50),
    Classificacao DECIMAL(1)  not NULL,
    NroBanheiros DECIMAL(2)  DEFAULT 0,
    NroQuartos  DECIMAL(2)  DEFAULT 0,
    MaxHospedes  DECIMAL(3) not NULL,
    Diaria      NUMERIC DEFAULT 0,
    Limpeza     NUMERIC DEFAULT 0,
    Min_Noite   Decimal(3) DEFAULT 1,
    Max_Noite   Decimal(3),
    hr_checkin  TIME,
    hr_checkout TIME,
    Disponibilidade_inicio DATE,  
    Disponibilidade_fim DATE,  
    NroTipoCamas VARCHAR(50),
    Comodidades  VARCHAR(50), 
    Regras       VARCHAR(50),
    Dono        DECIMAL(8)  not NULL,
    
    UNIQUE (Nome, numero, rua, cidade, CEP),
    FOREIGN KEY (DONO) REFERENCES Usuario (ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (pais, estado, cidade_Localização) 
        REFERENCES Localização (pais, estado, cidade)
        ON DELETE CASCADE ON UPDATE CASCADE
    );

    
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





DROP TABLE IF EXISTS Interesses CASCADE;
CREATE TABLE Interesses(
    pais        varchar(50) not NULL,
    estado      varchar(50) not NULL,
    cidade      varchar(50) not NULL,
    interesse   varchar(50) not NULL,
    
    PRIMARY KEY (pais, estado, cidade, interesse),
    FOREIGN KEY (pais, estado, cidade) 
        REFERENCES Localização (pais, estado, cidade)
        ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Locacao CASCADE;
CREATE TABLE Locacao(
    DataReserva  TIMESTAMP NOT NULL,
    Hospede      DECIMAL(8) NOT NULL,
    Propriedade  DECIMAL(8) NOT NULL,
    confirmação  bool DEFAULT FALSE,
    Checkin      DATE,
    Checkout     DATE,
    NroHospedes  DECIMAL(3),
    imposto      NUMERIC,
    DESCONTO     NUMERIC,
    COD_PROMO    NUMERIC,
    custoEstadia NUMERIC,
    PreçoTotal   NUMERIC,
        PRIMARY KEY (DataReserva, Hospede, Propriedade),
        FOREIGN KEY (Hospede) REFERENCES Usuario (ID)
            ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Propriedade) REFERENCES Propriedade (ID)
            ON DELETE CASCADE ON UPDATE CASCADE
);