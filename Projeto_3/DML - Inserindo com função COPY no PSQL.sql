-- Databricks notebook source
-- Inserções das tabelas do projeto Fórmula 1 com tratamento de aspas simples

SET search_path TO 'LabBD25-Grupo7'; --Mudando o Schema do public para o criado para o grupo

SET client_encoding to 'UTF8'; --Mudando a codifiação de dados do cliente para UTF8 para ter match com o servidor

\COPY Circuits(CircuitID, CircuitRef, Name, Location, Country, Lat, Lng, Alt, URL) FROM 'C:/Users/mathe/Desktop/LAB BD 25/DADOS LAB BD 25 - F1/circuits.csv' DELIMITER ',' CSV HEADER QUOTE '"' NULL '\N';

\COPY Constructors(ConstructorID, ConstructorRef, Name, Nationality, URL) FROM 'C:/Users/mathe/Desktop/LAB BD 25/DADOS LAB BD 25 - F1/constructors.csv' DELIMITER ',' CSV HEADER QUOTE '"' NULL '\N';

\COPY Drivers(DriverId, DriverRef, Number, Code, Forename, Surname, DateOfBirth, Nationality, URL) FROM 'C:/Users/mathe/Desktop/LAB BD 25/DADOS LAB BD 25 - F1/drivers.csv' DELIMITER ',' CSV HEADER QUOTE '"' NULL '\N';

\COPY Seasons(Year, URL) FROM 'C:/Users/mathe/Desktop/LAB BD 25/DADOS LAB BD 25 - F1/seasons.csv' DELIMITER ',' CSV HEADER QUOTE '"' NULL '\N';

\COPY Races(RaceId, Year, Round, CircuitId, Name, Date, Time, URL, fp1_date, fp1_time, fp2_date, fp2_time, fp3_date, fp3_time, quali_date, quali_time, sprint_date, sprint_time) FROM 'C:/Users/mathe/Desktop/LAB BD 25/DADOS LAB BD 25 - F1/races.csv' DELIMITER ',' CSV HEADER QUOTE '"' NULL '\N';

\COPY DriverStandings(DriverStandingsId, RaceID, DriverId, Points, Position, PositionText, Wins) FROM 'C:/Users/mathe/Desktop/LAB BD 25/DADOS LAB BD 25 - F1/driver_Standings.csv' DELIMITER ',' CSV HEADER QUOTE '"' NULL '\N';

\COPY LapTimes(RaceId, DriverId, Lap, Position, Time, Milliseconds) FROM 'C:/Users/mathe/Desktop/LAB BD 25/DADOS LAB BD 25 - F1/lap_Times.csv' DELIMITER ',' CSV HEADER QUOTE '"' NULL '\N';

\COPY PitStops(RaceId, DriverId, Stop, Lap, Time, Duration, Milliseconds) FROM 'C:/Users/mathe/Desktop/LAB BD 25/DADOS LAB BD 25 - F1/pit_Stops.csv' DELIMITER ',' CSV HEADER QUOTE '"'NULL '\N';

\COPY Qualifying(QualifyId, RaceId, DriverId, ConstructorId, Number, Position, Q1, Q2, Q3) FROM 'C:/Users/mathe/Desktop/LAB BD 25/DADOS LAB BD 25 - F1/qualifying.csv' DELIMITER ',' CSV HEADER QUOTE '"' NULL '\N';

\COPY Status(StatusId, Status) FROM 'C:/Users/mathe/Desktop/LAB BD 25/DADOS LAB BD 25 - F1/status.csv' DELIMITER ',' CSV HEADER QUOTE '"' NULL '\N';

\COPY Results(ResultId, RaceId, DriverId, ConstructorId, Number, Grid, Position, PositionText, PositionOrder, Points, Laps, Time, Milliseconds, FastestLap, Rank, FastestLapTime, FastestLapSpeed, StatusID) FROM 'C:/Users/mathe/Desktop/LAB BD 25/DADOS LAB BD 25 - F1/results.csv' DELIMITER ',' CSV HEADER QUOTE '"' NULL '\N';

\COPY Countries(Id, Code, Name, Continent, WikipediaLink, Keywords) FROM 'C:/Users/mathe/Desktop/LAB BD 25/DADOS LAB BD 25 - F1/countries.csv' DELIMITER ',' CSV HEADER QUOTE '"' NULL '\N';

\COPY Airports(Id, Ident, Type, Name, LatDeg, LongDeg, ElevFt, Continent, ISOCountry, ISORegion, City, Scheduled_service, ICAOCode, IATACode, GPSCode, LocalCode, HomeLink, WikipediaLink, Keywords) FROM 'C:/Users/mathe/Desktop/LAB BD 25/DADOS LAB BD 25 - F1/airports.csv' DELIMITER ',' CSV HEADER QUOTE '"'; --AQUI FOI PRECISO REMOVER O "NULL '\N'" porque o arquivo esta interpretando nulo como vazio!

\COPY Geocities5k(GeonameID, Name, AsciiName, AlternateNames, Lat, Long, FeatureClass, FeatureCode, Country, CC2, Admin1Code, Admin2Code, Admin3Code, Admin4Code, Population, Elevation, Dem, TimeZone, Modification) FROM '/Cities15000.tsv' DELIMITER '    ' CSV QUOTE '"'; --AQUI FOI PRECISO REMOVER O "NULL '\N'" porque o arquivo esta interpretando nulo como vazio! Também foi preciso mudar o delimitador para TAB '	' já que o arquivo é .TSV

