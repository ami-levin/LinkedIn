-------------------------------------
-- LinkedIn Learning ----------------
-- Advanced SQL - Query Processing --
-- Ami Levin 2020 -------------------
-- .\Chapter3\Video2.sql ------------
-------------------------------------

-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=5ca46a769961da38fb0324133f57bfea&hide=3

USE Animal_Shelter; -- For SQL Server

SELECT	*
FROM	Animals 
WHERE	Species = 'Dog'	
		AND 
		Breed <> 'Bullmastiff';

SELECT	*
FROM	Persons
WHERE	Birth_Date <> '20000101';
