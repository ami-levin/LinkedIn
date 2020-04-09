-------------------------------------
-- LinkedIn Learning ----------------
-- Advanced SQL - Query Processing --
-- Ami Levin 2020 -------------------
-- .\Chapter4\Video2.sql ------------
-------------------------------------

-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=2ce45e2207221c2a6383495592459760&hide=3

USE Animal_Shelter; -- For SQL Server

-- Dealing with NULLs
SELECT	Species, 
		Breed, 
		COUNT(*) AS Number_Of_Animals
FROM	Animals
GROUP BY Species, Breed;

SELECT	YEAR(Birth_Date) AS Year_Born, 
		COUNT(*) AS Number_Of_Persons
FROM	Persons
GROUP BY YEAR(Birth_Date);

SELECT	YEAR(CURRENT_TIMESTAMP) - YEAR(Birth_Date) AS Age, 
		COUNT(*) AS Number_Of_Persons
FROM	Persons
GROUP BY YEAR(Birth_Date);

SELECT	City,
		MIN(YEAR(CURRENT_TIMESTAMP) - YEAR(Birth_Date)) AS Oldest_Person,
		MAX(YEAR(CURRENT_TIMESTAMP) - YEAR(Birth_Date)) AS Youngest_Person,
		COUNT(*) AS Number_Of_Persons
FROM	Persons
GROUP BY City;

-- Eliminating duplicates
SELECT	Species, 
		Name
FROM	Vaccinations;

SELECT	Species, 
		Name
FROM	Vaccinations
GROUP BY Species, Name;

SELECT	DISTINCT 
		Species, 
		Name
FROM	Vaccinations;

SELECT	DISTINCT Species, 
		Name,
		COUNT(*) AS  Number_Of_Vaccines
FROM	Vaccinations;

SELECT	Species,
		--Name,
		COUNT(*) AS Number_Of_Vaccines
FROM	Vaccinations
GROUP BY Species, Name
ORDER BY Species, Number_Of_Vaccines;

SELECT	DISTINCT 
		Species, 
		--Name,
		COUNT(*) AS Number_Of_Vaccines
FROM	Vaccinations
GROUP BY Species, Name
ORDER BY Species, Number_Of_Vaccines;
