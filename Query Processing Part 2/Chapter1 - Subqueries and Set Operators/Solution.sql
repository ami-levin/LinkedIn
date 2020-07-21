--------------------------------------------
-- LinkedIn Learning -----------------------
-- Advanced SQL - Query Processing Part 2 --
-- Ami Levin 2020 --------------------------
-- .\Chapter1\Solution.sql -----------------
--------------------------------------------

-- GitHub
https://github.com/ami-levin/LinkedIn/tree/master/Query%20Processing%20Part%202/Chapter1%20-%20Subqueries%20and%20Set%20Operators/Solution.sql

-- DBFiddle UK
/*SQL Server*/	https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=aed3a3262dfc64d609afe2737b63fd22&hide=3
/*PostgreSQL*/	https://dbfiddle.uk/?rdbms=postgres_12&fiddle=1d90985b4b945b050f8f4c071f56bb88&hide=1

/*
   _____	   __	   __  _		   
  / ___/____  / /_	__/ /_(_)___  ____ 
  \__ \/ __ \/ / / / / __/ / __ \/ __ \
 ___/ / /_/ / / /_/ / /_/ / /_/ / / / /
/____/\____/_/\__,_/\__/_/\____/_/ /_/ 
									   
*/

-- Breeds that were never adopted

-- Try the OUTER JOIN approach (doesn't work...)
SELECT	DISTINCT --	AN.Name,
					AN.Species, 
					AN.Breed 
FROM	Animals AS AN
		LEFT OUTER JOIN
		Adoptions AS AD
		ON	AN.Species = AD.Species
			AND
			AN.Name = AD.Name
WHERE	AD.Species IS NULL;

-- Do we have non breed animals that were adopted?
SELECT	*
FROM	Animals AS AN
		INNER JOIN 
		Adoptions AS AD
		ON	AD.Name = AN.Name 
			AND
			AD.Species = AN.Species
WHERE	AN.Breed IS NULL;

-- Try the NOT EXISTS approach (doesn't work...)
SELECT	DISTINCT Species, Breed
FROM	Animals AS AN
WHERE	NOT EXISTS	(
						SELECT	NULL
						FROM	Adoptions AS AD
						WHERE	AD.Name = AN.Name
								AND 
								AD.Species = AN.Species
					);

/* PostgreSQL
-- The NOT IN approach (doesn't work...)
SELECT	DISTINCT Species, Breed 
FROM	Animals AS AN1
WHERE	(Species, Breed) NOT IN (	SELECT	AN2.Species, AN2.Breed 
									FROM	Animals AS AN2
											INNER JOIN
											Adoptions AS AD
											ON	AN2.Species = AD.Species
												AND
												AN2.Name = AD.Name
								);

-- Remove NULLs from subquery (Does it work?)
SELECT	DISTINCT Species, Breed 
FROM	Animals AS AN1
WHERE	(Species, Breed) NOT IN (	SELECT	AN2.Species, AN2.Breed 
									FROM	Animals AS AN2
											INNER JOIN
											Adoptions AS AD
											ON	AN2.Species = AD.Species
												AND
												AN2.Name = AD.Name
									WHERE	AN2.Breed IS NOT NULL 
								);

-- Add Ferris, the non breed ferret that wasn't adopted
INSERT INTO Animals
(Name, Species, Primary_Color, Implant_Chip_ID, Breed, Gender, Birth_Date, Pattern, Admission_Date)
VALUES ('Ferris', 'Ferret', 'White', 'A0EEBC99-9C0B-4EF8-BB6D-6BB9BD380A11', NULL, 'F', '20161122', 'Solid', '20171221');

-- Try again
SELECT	DISTINCT Species, Breed 
FROM	Animals AS AN1
WHERE	(Species, Breed) NOT IN (	SELECT	AN2.Species, AN2.Breed 
									FROM	Animals AS AN2
											INNER JOIN
											Adoptions AS AD
											ON	AN2.Species = AD.Species
												AND
												AN2.Name = AD.Name
									WHERE	AN2.Breed IS NOT NULL 
								);

-- Check what happens for NOT IN and an empty set subquery
SELECT	'Works'
WHERE	1 NOT IN (SELECT 1 WHERE FALSE);

-- Cleanup
DELETE FROM Animals WHERE name = 'Ferris' AND Species = 'Ferret';								
*/

-- The elegant solution
SELECT	Species, Breed
FROM	Animals
EXCEPT	
SELECT	AN.Species, AN.Breed 
FROM	Animals AS AN
		INNER JOIN
		Adoptions AS AD
		ON	AN.Species = AD.Species
			AND
			AN.Name = AD.Name;

/* PostgreSQL
-- Bonus solution using a different approach.
SELECT	DISTINCT Species, Breed
FROM	Animals AS AN1
WHERE	NOT EXISTS (
						SELECT	NULL
						FROM	Animals AS AN2
						WHERE	EXISTS (
											SELECT	NULL
											FROM	Adoptions AS AD
											WHERE	AD.Name = AN2.Name
													AND
													AD.Species = AN2.Species
													AND	
													AD.Species = AN1.Species
													AND
													AN1.Breed IS NOT DISTINCT FROM AN2.Breed
													)
					);										
*/

/*
  ________  ________   _______   ______ 
 /_  __/ / / / ____/  / ____/ | / / __ \
  / / / /_/ / __/    / __/ /  |/ / / / /
 / / / __  / /___   / /___/ /|  / /_/ / 
/_/ /_/ /_/_____/  /_____/_/ |_/_____/  
                                        
*/