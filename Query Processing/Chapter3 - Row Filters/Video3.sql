-------------------------------------
-- LinkedIn Learning ----------------
-- Advanced SQL - Query Processing --
-- Ami Levin 2020 -------------------
-- .\Chapter3\Video3.sql ------------
-------------------------------------

-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=79efadcf4cf6141815636c5b1acc81ca&hide=3

USE Animal_Shelter; -- For SQL Server

SELECT	*
FROM	Animals
WHERE	Breed = NULL;

SELECT	*
FROM	Animals
WHERE	Breed != NULL;

SELECT	*
FROM	Animals
WHERE	Breed = NULL 
		OR 
		Breed != NULL;

SELECT	*
FROM	Animals
WHERE	Breed = 'Bullmastiff' 
		OR 
		Breed != 'Bullmastiff';

SELECT	*
FROM	Animals
WHERE	Breed IS NULL;

SELECT	*
FROM	Animals
WHERE	Breed IS NOT NULL;

SELECT	*
FROM	Animals
WHERE	Breed != 'Bullmastiff';

SELECT	*
FROM	Animals
WHERE	Breed != 'Bullmastiff'
		OR 
		Breed IS NULL;
		
SELECT 	*
FROM 	Animals
WHERE 	ISNULL(Breed, 'Some value') != 'Bullmastiff';

/* PostgreSQL

-- https://dbfiddle.uk/?rdbms=postgres_12&fiddle=604141955f380c713f4ffce0bcdda1a7&hide=2

SELECT	*
FROM	Animals
WHERE	Breed IS DISTINCT FROM 'Bullmastiff';

SELECT	*
FROM	Animals
WHERE	(Breed = 'Bullmastiff') IS NOT TRUE;
*/
