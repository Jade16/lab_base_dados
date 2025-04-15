-- Databricks notebook source
SET search_path TO 'LabBD25-Grupo7'; --Mudando o Schema do public para o criado para o grupo

SELECT * FROM (
SELECT 'Circuits' AS table_name, COUNT(*) AS total_rows FROM Circuits
UNION ALL
SELECT 'Constructors', COUNT(*) FROM Constructors
UNION ALL
SELECT 'Drivers', COUNT(*) FROM Drivers
UNION ALL
SELECT 'Seasons', COUNT(*) FROM Seasons
UNION ALL
SELECT 'Races', COUNT(*) FROM Races
UNION ALL
SELECT 'DriverStandings', COUNT(*) FROM DriverStandings
UNION ALL
SELECT 'LapTimes', COUNT(*) FROM LapTimes
UNION ALL
SELECT 'PitStops', COUNT(*) FROM PitStops
UNION ALL
SELECT 'Qualifying', COUNT(*) FROM Qualifying
UNION ALL
SELECT 'Status', COUNT(*) FROM Status
UNION ALL
SELECT 'Results', COUNT(*) FROM Results
UNION ALL
SELECT 'Countries', COUNT(*) FROM Countries
UNION ALL
SELECT 'Airports', COUNT(*) FROM Airports
UNION ALL
SELECT 'Geocities5k', COUNT(*) FROM Geocities5k) AS TODO ORDER BY 2 DESC;