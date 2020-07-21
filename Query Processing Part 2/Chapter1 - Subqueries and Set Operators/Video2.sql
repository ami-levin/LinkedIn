--------------------------------------------
-- LinkedIn Learning -----------------------
-- Advanced SQL - Query Processing Part 2 --
-- Ami Levin 2020 --------------------------
-- .\Chapter1\Video2.sql -------------------
--------------------------------------------

-- GitHub
https://github.com/ami-levin/LinkedIn/tree/master/Query%20Processing%20Part%202/Chapter1%20-%20Subqueries%20and%20Set%20Operators/Video2.sql

-- DBFiddle UK 
/*SQL Server*/	https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=ccbe0f967b49f35ac4fcbac5c7142940&hide=3
/*PostgreSQL*/	https://dbfiddle.uk/?rdbms=postgres_12&fiddle=0a3c8a1dd8273b7cac0a2746710a9046&hide=1

/*
   _____      __     ____                        __                 
  / ___/___  / /_   / __ \____  ___  _________ _/ /_____  __________
  \__ \/ _ \/ __/  / / / / __ \/ _ \/ ___/ __ `/ __/ __ \/ ___/ ___/
 ___/ /  __/ /_   / /_/ / /_/ /  __/ /  / /_/ / /_/ /_/ / /  (__  ) 
/____/\___/\__/   \____/ .___/\___/_/   \__,_/\__/\____/_/  /____/  
                      /_/                                           
*/

-- Animals that were not adopted
-- Using OUTER JOIN
SELECT	DISTINCT AN.Name, AN.Species
FROM	Animals AS AN
		LEFT OUTER JOIN
		Adoptions AS AD
			ON AD.Name = AN.Name AND AD.Species = AN.Species
WHERE	AD.Name IS NULL;

-- Using NOT EXISTS
SELECT	AN.Name, AN.Species
FROM	Animals AS AN
WHERE	NOT EXISTS	(
						SELECT	NULL
						FROM	Adoptions AS AD
						WHERE	AD.Name = AN.Name
								AND 
								AD.Species = AN.Species
					);
-- Row expressions
/* PostgreSQL row expressions
SELECT	Name, Species
FROM	Animals 
WHERE	(Name, Species) NOT IN (SELECT Name, Species FROM Adoptions);
*/

-- SQL Server "mimic row expressions" - Don't try this at home!
SELECT	Name, Species
FROM	Animals 
WHERE	CONCAT(Name, '|||', Species) 
			NOT IN 
			(SELECT CONCAT(Name, '|||', Species) FROM Adoptions);

-- The right way - Set Operators
SELECT	Name, Species
FROM	Animals
EXCEPT	
SELECT	Name, Species
FROM	Adoptions;

-- Animals that were adopted and vaccinated at least twice
SELECT	Name, Species
FROM	Adoptions
INTERSECT
SELECT	Name, Species
FROM	Vaccinations
GROUP BY Name, Species
HAVING	COUNT(*) > 1;

/*
  ________  ________   _______   ______ 
 /_  __/ / / / ____/  / ____/ | / / __ \
  / / / /_/ / __/    / __/ /  |/ / / / /
 / / / __  / /___   / /___/ /|  / /_/ / 
/_/ /_/ /_/_____/  /_____/_/ |_/_____/  
                                        
*/