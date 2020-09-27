--------------------------------------------
-- LinkedIn Learning -----------------------
-- Advanced SQL - Query Processing Part 2 --
-- Ami Levin 2020 --------------------------
-- .\Chapter3\Video1.sql -------------------
--------------------------------------------

-- GitHub
https://github.com/ami-levin/LinkedIn/tree/master/Query%20Processing%20Part%202/Chapter4%20-%20Recursions%20and%20Cursors/Video1.sql

-- DBFiddle UK
/*SQL Server*/		https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=f9843048f7c533c95d3b1accda60c88c&hide=3
/*PostgreSQL*/	https://dbfiddle.uk/?rdbms=postgres_12&fiddle=6e4189e143ecf4fa6820beb05057c191&hide=1

-- Additional Resources
https://www.itprotoday.com/sql-server/ordered-set-functions
https://www.itprotoday.com/sql-server/inverse-distribution-functions
https://docs.microsoft.com/en-us/sql/t-sql/functions/percentile-disc-transact-sql
https://docs.microsoft.com/en-us/sql/t-sql/functions/percentile-cont-transact-sql

/*
   ____           __                   __   _____      __     ______                 __  _                 
  / __ \_________/ /__  ________  ____/ /  / ___/___  / /_   / ____/_  ______  _____/ /_(_)___  ____  _____
 / / / / ___/ __  / _ \/ ___/ _ \/ __  /   \__ \/ _ \/ __/  / /_  / / / / __ \/ ___/ __/ / __ \/ __ \/ ___/
/ /_/ / /  / /_/ /  __/ /  /  __/ /_/ /   ___/ /  __/ /_   / __/ / /_/ / / / / /__/ /_/ / /_/ / / / (__  ) 
\____/_/   \__,_/\___/_/   \___/\__,_/   /____/\___/\__/  /_/    \__,_/_/ /_/\___/\__/_/\____/_/ /_/____/  
                                                                                                           
*/

-- String aggregate
SELECT	Adoption_Date,
		SUM(Adoption_Fee) AS Total_Fee,
		STRING_AGG(CONCAT(Name, ' the ',  Species), ', ') 
		WITHIN GROUP (ORDER BY Species, Name) AS Adopted_Animals
FROM	Adoptions
GROUP BY Adoption_Date
HAVING	COUNT(*) > 1;

/* PostgreSQL STRING_AGG is not an ordered set function as there is no order...
SELECT	Adoption_Date,
		SUM(Adoption_Fee) AS Total_Fee,
		STRING_AGG(CONCAT(Name, ' the ',  Species), ', ') AS Adopted_Animals
FROM	Adoptions
GROUP BY Adoption_Date
HAVING	COUNT(*) > 1;
*/

-- Beware of NULL concatenation
SELECT	'X' + NULL, 
		CONCAT('X', NULL);

/* PotgreSQL
-- Beware of NULL concatenation
SELECT	'X' || NULL, 
		CONCAT('X', NULL);
*/

-- Add breed to animal's string description
SELECT	Adoption_Date,
		SUM(Adoption_Fee) AS Total_Fee,
		STRING_AGG(CONCAT(AN.Name, ' the ',  AN.Breed, ' ', AN.Species), ', ')
		WITHIN GROUP (ORDER BY AN.Species, AN.Breed, AN.Name) AS Using_CONCAT,
		STRING_AGG(AN.Name + ' the ' +  AN.Breed + ' ' + AN.Species, ', ')
		WITHIN GROUP (ORDER BY AN.Species, AN.Breed, AN.Name) AS Using_Plus
FROM	Adoptions AS AD
		INNER JOIN
		Animals AS AN
			ON 	AN.Name = AD.Name 
				AND 
				AN.Species = AD.Species
GROUP BY Adoption_Date
HAVING	COUNT(*) > 1;

-- Hypothetical set and inverse distribution functions
/* PostgreSQL
WITH Vaccination_Ranking
AS
(
SELECT	Name, 
		Species,
		COUNT(*) AS Number_Of_Vaccinations
FROM	Vaccinations
GROUP BY Name, Species
)
SELECT  Species,
        MAX(Number_Of_Vaccinations) AS MAX_Vaccinations,
        MIN(Number_Of_Vaccinations) AS MIN_Vaccinations,
        CAST(AVG(Number_Of_Vaccinations) AS DECIMAL(9,2)) AS AVG_Vaccinations,
        DENSE_RANK(5)	
		WITHIN GROUP (ORDER BY Number_Of_Vaccinations DESC) AS How_Would_X_Rank,
        PERCENT_RANK(5) 
		WITHIN GROUP (ORDER BY Number_Of_Vaccinations DESC) AS How_Would_X_Rank_Percent_Wise,
        PERCENTILE_CONT(0.333) 
		WITHIN GROUP (ORDER BY Number_Of_Vaccinations DESC) AS Inverse_Continous,
        PERCENTILE_DISC(0.333) 
		WITHIN GROUP (ORDER BY Number_Of_Vaccinations DESC) AS Inverse_Discrete
FROM    Vaccination_Ranking
GROUP BY Species;
*/

/*
  ________  ________   _______   ______ 
 /_  __/ / / / ____/  / ____/ | / / __ \
  / / / /_/ / __/    / __/ /  |/ / / / /
 / / / __  / /___   / /___/ /|  / /_/ / 
/_/ /_/ /_/_____/  /_____/_/ |_/_____/  
                                        
*/
