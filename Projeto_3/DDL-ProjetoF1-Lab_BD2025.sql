-- Databricks notebook source
-- Criação das tabelas para o projeto Fórmula 1 no PostgreSQL 17

SET search_path TO 'LabBD25-Grupo7'; --Mudando o Schema do public para o criado para o grupo

CREATE TABLE Circuits ( 
    CircuitID INT NOT NULL, 
    CircuitRef TEXT NOT NULL,
    Name TEXT NOT NULL,
    Location TEXT,
    Country VARCHAR(60),
    Lat DECIMAL(9,6),
    Lng DECIMAL(9,6), 
    Alt INT,
    URL TEXT,

    CONSTRAINT PK_Circuits PRIMARY KEY (CircuitID)
);

CREATE TABLE Constructors ( 
    ConstructorID INT NOT NULL,
    ConstructorRef TEXT NOT NULL,
    Name VARCHAR(150) NOT NULL,
    Nationality TEXT,
    URL TEXT,

    CONSTRAINT PK_Constructors PRIMARY KEY (ConstructorID)
);

CREATE TABLE Drivers ( 
    DriverId INT NOT NULL,
    DriverRef TEXT NOT NULL,
    Number TEXT,
    Code VARCHAR(10),
    Forename TEXT,
    Surname TEXT,
    DateOfBirth DATE,
    Nationality VARCHAR(80),
    URL TEXT,

    CONSTRAINT PK_Drivers PRIMARY KEY (DriverId)
);

CREATE TABLE Seasons ( 
    Year INT NOT NULL,
    URL TEXT,

    CONSTRAINT PK_Seasons PRIMARY KEY (Year)
);

CREATE TABLE Races ( 
    RaceId INT NOT NULL,
    Year INT NOT NULL,
    Round INT,
    CircuitId INT,
    Name TEXT NOT NULL,
    Date DATE NOT NULL,
    Time TIME,
    URL TEXT,
    fp1_date DATE,
    fp1_time TIME,
    fp2_date DATE,
    fp2_time TIME,
    fp3_date DATE,
    fp3_time TIME,
    quali_date DATE,
    quali_time TIME,
    sprint_date DATE,
    sprint_time TIME,
    
    CONSTRAINT PK_Races PRIMARY KEY (RaceId),
    CONSTRAINT FK_Races_Circuit FOREIGN KEY (CircuitId) REFERENCES Circuits(CircuitID) ON DELETE CASCADE,
    CONSTRAINT FK_Races_Season FOREIGN KEY (Year) REFERENCES Seasons(Year) ON DELETE CASCADE
);

CREATE TABLE DriverStandings ( 
    DriverStandingsId INT NOT NULL,
    RaceID INT,
    DriverId INT,
    Points DECIMAL(6,2), 
    Position INT,
    PositionText TEXT,
    Wins INT,

    CONSTRAINT PK_DriverStandings PRIMARY KEY (DriverStandingsId),
    CONSTRAINT FK_DriverStandings_Race FOREIGN KEY (RaceID) REFERENCES Races(RaceID) ON DELETE CASCADE,
    CONSTRAINT FK_DriverStandings_Driver FOREIGN KEY (DriverId) REFERENCES Drivers(DriverId) ON DELETE CASCADE
);

CREATE TABLE LapTimes ( 
    RaceId INT,
    DriverId INT,
    Lap INT,
    Position INT,
    Time VARCHAR(50),
    Milliseconds INT,

    CONSTRAINT PK_LapTimes PRIMARY KEY (RaceId, DriverId, Lap),
    CONSTRAINT FK_LapTimes_Race FOREIGN KEY (RaceId) REFERENCES Races(RaceID) ON DELETE CASCADE,
    CONSTRAINT FK_LapTimes_Driver FOREIGN KEY (DriverId) REFERENCES Drivers(DriverId) ON DELETE CASCADE
);

CREATE TABLE PitStops ( 
    RaceId INT,
    DriverId INT,
    Stop INT, 
    Lap INT, 
    Time TIME,
    Duration TEXT,-- Tiramos DECIMAL(6,3) pois nessa coluna nos inserts há os dois padrões HH:MM:SS & MM:SS.MS,
    Milliseconds INT,

    CONSTRAINT PK_PitStops PRIMARY KEY (RaceId, DriverId, Stop),
    CONSTRAINT FK_PitStops_Race FOREIGN KEY (RaceId) REFERENCES Races(RaceID) ON DELETE CASCADE,
    CONSTRAINT FK_PitStops_Driver FOREIGN KEY (DriverId) REFERENCES Drivers(DriverId) ON DELETE CASCADE
);

CREATE TABLE Qualifying ( 
    QualifyId INT NOT NULL,
    RaceId INT,
    DriverId INT,
    ConstructorId INT,
    Number INT,
    Position INT,
    Q1 VARCHAR(50), --Utilizamos VARCHAR porque os inserts para Qualifying estão no formato MM:SS.MS e o tipo de dado TIME aceita somente HH:MM:SS.MS
    Q2 VARCHAR(50), 
    Q3 VARCHAR(50), 

    CONSTRAINT PK_Qualifying PRIMARY KEY (QualifyId),
    CONSTRAINT FK_Qualifying_Race FOREIGN KEY (RaceId) REFERENCES Races(RaceId) ON DELETE CASCADE,
    CONSTRAINT FK_Qualifying_Driver FOREIGN KEY (DriverId) REFERENCES Drivers(DriverId) ON DELETE CASCADE,
    CONSTRAINT FK_Qualifying_Constructor FOREIGN KEY (ConstructorId) REFERENCES Constructors(ConstructorID) ON DELETE CASCADE
);

CREATE TABLE Status ( 
    StatusId INT NOT NULL,
    Status TEXT,

    CONSTRAINT PK_Status PRIMARY KEY (StatusId)
);

CREATE TABLE Results (
    ResultId INT NOT NULL,
    RaceId INT,
    DriverId INT,
    ConstructorId INT,
    Number INT,
    Grid INT,
    Position INT,
    PositionText TEXT,
    PositionOrder INT,
    Points DECIMAL(6,2),
    Laps INT,
    Time VARCHAR(50),
    Milliseconds INT,
    FastestLap INT,
    Rank INT,
    FastestLapTime VARCHAR(50), --Aqui usamos VARCHAR porque no CSV de inserts está no formato MM:SS.MS, e o formato TIME do Postgre é HH:MM:SS.MS
    FastestLapSpeed DECIMAL(6,3),
    StatusID INT,

    CONSTRAINT PK_Results PRIMARY KEY (ResultId),
    CONSTRAINT FK_Results_Race FOREIGN KEY (RaceId) REFERENCES Races(RaceId) ON DELETE CASCADE,
    CONSTRAINT FK_Results_Driver FOREIGN KEY (DriverId) REFERENCES Drivers(DriverId) ON DELETE CASCADE,
    CONSTRAINT FK_Results_Constructor FOREIGN KEY (ConstructorId) REFERENCES Constructors(ConstructorID) ON DELETE CASCADE,
    CONSTRAINT FK_Results_Status FOREIGN KEY (StatusId) REFERENCES Status(StatusID) ON DELETE SET NULL --Decidimos manter os registros de Results caso algum Status seja deletado, por isso ON DELETE SET NULL
);


CREATE TABLE Countries (
    Id INT NOT NULL,
    Code CHAR(2) NOT NULL, --O padrão ISO 3166-1 alpha-2 (Ex: BR, US) usa 2 caracteres, que é o que temos no CSV de inserções de Countries
    Name TEXT NOT NULL,
    Continent CHAR(2),
    WikipediaLink TEXT,
    Keywords TEXT,

    CONSTRAINT PK_Countries PRIMARY KEY (Id),
    CONSTRAINT UQ_Countries_Code UNIQUE (Code) --Como Code também não se repete na tabela, utilizamos o UNIQUE para definir este atributo como chave secundária
);

CREATE TABLE Airports (
    Id INT NOT NULL,
    Ident TEXT NOT NULL,
    Type TEXT,
    Name TEXT NOT NULL,
    LatDeg DECIMAL(9,6),
    LongDeg DECIMAL(9,6),
    ElevFt INT,
    Continent CHAR(2), 
    ISOCountry CHAR(2), -- Código do país conforme o padrão ISO 3166-1 alpha-2 (Ex: BR, US, GB).
    ISORegion CHAR(7),  -- Código da subdivisão administrativa conforme o padrão ISO 3166-2 (Ex: BR-SP, US-CA, GB-ENG).
    City TEXT,
    Scheduled_service BOOLEAN DEFAULT FALSE, --Tipo de variável que não existe em Oracle mas decidimos utilizar já que o PostgreSQL oferece
    ICAOCode VARCHAR(4),
	IATACode VARCHAR(4), --O código IATA dos aeroportos (ex: GRU, JFK, LHR) tem sempre 3 caracteres.
    GPSCode TEXT,
    LocalCode TEXT,
    HomeLink TEXT,
    WikipediaLink TEXT,
    Keywords TEXT,

    CONSTRAINT PK_Airports PRIMARY KEY (Id)
);

CREATE TABLE Geocities5k (
    GeonameID INT NOT NULL,
    Name TEXT NOT NULL,
    AsciiName TEXT,
    AlternateNames TEXT, --Como imaginamos que possam existir vários nomes separados por virgulas nesse atributo, utilizamos o tipo de dado TEXT. Como ele não exige um limite fixo, evitamos problemas de espaço.
    Lat DECIMAL(9,6),
    Long DECIMAL(9,6), 
    FeatureClass TEXT,
    FeatureCode TEXT,
    Country TEXT,
    CC2 TEXT,
    Admin1Code TEXT,
    Admin2Code TEXT,
    Admin3Code TEXT,
    Admin4Code TEXT,
    Population BIGINT, --Utilizamos BIGINT levando em conta que uma população pode um dia ultrapassar 2B de habitantes que seria o limite do tipo de dado INT
    Elevation INT,
    Dem INT,
    TimeZone TEXT,
    Modification TIMESTAMP,

    CONSTRAINT PK_Geocities5k PRIMARY KEY (GeonameID)
);


-- COMMAND ----------

