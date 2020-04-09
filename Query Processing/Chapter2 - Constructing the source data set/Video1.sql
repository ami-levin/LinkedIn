-------------------------------------
-- LinkedIn Learning ----------------
-- Advanced SQL - Query Processing --
-- Ami Levin 2020 -------------------
-- .\Chapter 2\Video1.sql -----------
-------------------------------------

-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=eeae089d7988b67bd6107c572f868837&hide=3

USE Animal_Shelter; -- For SQL Server

-- Single table source
SELECT	* 
FROM	Staff;

SELECT	'SQL is Fun!' AS fact
FROM	Staff;

SELECT	*, 'SQL is Fun!' AS fact
FROM	Staff;
