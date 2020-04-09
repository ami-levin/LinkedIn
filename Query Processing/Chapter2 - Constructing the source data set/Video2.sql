-------------------------------------
-- LinkedIn Learning ----------------
-- Advanced SQL - Query Processing --
-- Ami Levin 2020 -------------------
-- .\Chapter 2\Video2.sql -----------
-------------------------------------

-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=bea6387f51f5e89180b2613829be5901&hide=3

USE Animal_Shelter; -- For SQL Server

-- CROSS JOIN
SELECT	* 
FROM	Staff 
		CROSS JOIN 
		Staff_Roles; 

-- INNER JOIN
SELECT	* 
FROM	Staff 
		INNER JOIN 
		Staff_Roles
		ON 1 = 1;
		
SELECT	*
FROM	Animals AS A
		CROSS JOIN 
		Adoptions AS AD;

SELECT	AD.*, A.Breed, A.Implant_Chip_ID
FROM	Animals AS A
		INNER JOIN 
		Adoptions AS AD
		ON	AD.Name = A.Name 
			AND 
			AD.Species = A.Species;

SELECT	AD.*, A.Breed, A.Implant_Chip_ID
FROM	Animals AS A
		LEFT OUTER JOIN 
		Adoptions AS AD
		ON	AD.Name = A.Name 
			AND 
			AD.Species = A.Species;

SELECT	AD.Adopter_Email, AD.Adoption_Date, 
		A.*
FROM	Animals AS A
		LEFT OUTER JOIN 
		Adoptions AS AD
		ON	AD.Name = A.Name 
			AND 
			AD.Species = A.Species;
