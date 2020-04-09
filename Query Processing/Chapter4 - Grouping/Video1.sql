-------------------------------------
-- LinkedIn Learning ----------------
-- Advanced SQL - Query Processing --
-- Ami Levin 2020 -------------------
-- .\Chapter4\Video1.sql ------------
-------------------------------------

-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=071222409d0edd292a436cf9decd6a11&hide=3

USE Animal_Shelter; -- For SQL Server

-- Granular detail rows
SELECT	*
FROM	Adoptions;

-- How many were adopted?
SELECT	COUNT(*)	AS Number_Of_Adoptions
FROM	Adoptions;

-- But - beware!
SELECT	Name,
		COUNT(*) AS Number_Of_Adoptions
FROM	Adoptions;

-- Granular detail rows
SELECT	*
FROM	Vaccinations;

SELECT		Species,
			COUNT(*)	AS Number_Of_Vaccinations
FROM		Vaccinations
GROUP BY	Species;

-- Number of vaccinations per animal
SELECT		Name,
			Species,
			COUNT(*)	AS Number_Of_Vaccinations
FROM		Vaccinations
GROUP BY	Name,
			Species;

-- Beware!
SELECT		Name,
			Species,
			Vaccine,
			COUNT(*)	AS Number_Of_Vaccinations
FROM		Vaccinations
GROUP BY	Name,
			Species;
