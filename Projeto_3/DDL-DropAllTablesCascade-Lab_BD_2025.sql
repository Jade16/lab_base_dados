-- Databricks notebook source
-- Remover todas as tabelas do esquema F1 (ordem correta para evitar erros de FK)

SET search_path TO 'LabBD25-Grupo7'; --Mudando o Schema do public para o criado para o grupo

DROP TABLE IF EXISTS 
    Results,
    Qualifying,
    PitStops,
    LapTimes,
    DriverStandings,
    Races,
    Drivers,
    Constructors,
    Circuits,
    Seasons,
    Status,
    Airports,
    Countries,
    Geocities5k
CASCADE; --para garantir que mesmo se houver alguma dependência residual, a tabela será removida. 