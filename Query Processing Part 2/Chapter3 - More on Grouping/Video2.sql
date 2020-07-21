--------------------------------------------
-- LinkedIn Learning -----------------------
-- Advanced SQL - Query Processing Part 2 --
-- Ami Levin 2020 --------------------------
-- .\Chapter3\Video2.sql -------------------
--------------------------------------------

-- GitHub
https://github.com/ami-levin/LinkedIn/tree/master/Query%20Processing%20Part%202/Chapter3%20-%20More%20on%20Grouping/Video2.sql

-- DBFiddle UK
/*SQL Server*/	https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=04376649f89222ea605600103e5f01e4&hide=3
/*PostgreSQL*/	https://dbfiddle.uk/?rdbms=postgres_12&fiddle=58f53dadfba0b8ef1624a40776636155&hide=1

/*
   ______                       _                _____      __      
  / ____/________  __  ______  (_)___  ____ _   / ___/___  / /______
 / / __/ ___/ __ \/ / / / __ \/ / __ \/ __ `/   \__ \/ _ \/ __/ ___/
/ /_/ / /  / /_/ / /_/ / /_/ / / / / / /_/ /   ___/ /  __/ /_(__  ) 
\____/_/   \____/\__,_/ .___/_/_/ /_/\__, /   /____/\___/\__/____/  
                     /_/            /____/                          
*/

-- Multi level aggregates
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date), MONTH(Adoption_Date);

SELECT	YEAR(Adoption_Date) AS Year,
		COUNT(*) AS Annual_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date);

SELECT	COUNT(*) AS Total_Adoptions
FROM	Adoptions
GROUP BY ();

-- Add UNION ALL... no good
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Number_Of_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date), MONTH(Adoption_Date)
UNION ALL
SELECT	YEAR(Adoption_Date) AS Year,
		COUNT(*) AS Annual_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date)
UNION ALL
SELECT	COUNT(*) AS Total_Adoptions
FROM	Adoptions
GROUP BY ();

-- Try string placeholders... no good
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Number_Of_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date), MONTH(Adoption_Date)
UNION ALL
SELECT	YEAR(Adoption_Date) AS Year,
		'All Months' AS Month,
		COUNT(*) AS Annual_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date)
UNION ALL
SELECT	'All Years' AS Year,	
		'All Months' AS Month,
		COUNT(*) AS Total_Adoptions
FROM	Adoptions
GROUP BY ()
ORDER BY Year, Month;

-- Use NULL placeholders... very good!
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date), MONTH(Adoption_Date)
UNION ALL
SELECT	YEAR(Adoption_Date) AS Year,
		NULL AS Month,
		COUNT(*) AS Annual_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date)
UNION ALL
SELECT	NULL AS Year,	
		NULL AS Month,
		COUNT(*) AS Total_Adoptions
FROM	Adoptions
GROUP BY ()
ORDER BY Year, Month;

-- Reuse lowest granularity aggregate in WITH clause
WITH Aggregated_Adoptions
AS
(
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date), MONTH(Adoption_Date)
)
SELECT	*
FROM	Aggregated_Adoptions
UNION ALL
SELECT	Year,
		NULL,
		COUNT(*)
FROM	Aggregated_Adoptions
GROUP BY Year
UNION ALL
SELECT	NULL,
		NULL,
		COUNT(*)
FROM	Aggregated_Adoptions
GROUP BY ();


/* PostgreSQL
-- Reuse lowest granularity aggregate in WITH clause
WITH Aggregated_Adoptions
AS
(
SELECT	EXTRACT(year FROM Adoption_Date) AS Year,
		EXTRACT(month FROM Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY EXTRACT(year FROM Adoption_Date) , EXTRACT(month FROM Adoption_Date)
)
SELECT	*
FROM	Aggregated_Adoptions
UNION ALL
SELECT	Year,
		NULL,
		COUNT(*)
FROM	Aggregated_Adoptions
GROUP BY Year
UNION ALL
SELECT	NULL,
		NULL,
		COUNT(*)
FROM	Aggregated_Adoptions
GROUP BY ();
*/

-- GROUPING SETS
-- Equivalent to no GROUP BY
SELECT	COUNT(*) AS Total_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			()
		);

-- Equivalent to GROUP BY YEAR(Adoption_Date)
SELECT	YEAR(Adoption_Date) AS Year,
		COUNT(*) AS Annual_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			YEAR(Adoption_Date)
		)
ORDER BY Year;

-- Equivalent to GROUP BY YEAR(Adoption_Date), MONTH(Adoption_Date)
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			(
				YEAR(Adoption_Date), MONTH(Adoption_Date)
			)
		)
ORDER BY Year, Month;

-- Be careful with the parentheses!
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			YEAR(Adoption_Date), MONTH(Adoption_Date)
		)
ORDER BY Year, Month;

-- All in one...
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			(YEAR(Adoption_Date), MONTH(Adoption_Date)),
			YEAR(Adoption_Date),
			()
		)
ORDER BY Year, Month;

/* PostgreSQL
-- All in one...
SELECT	EXTRACT(year FROM Adoption_Date) AS Year,
		EXTRACT(month FROM Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			(EXTRACT(year FROM Adoption_Date), extract(month FROM Adoption_Date)),
			EXTRACT(year FROM Adoption_Date),
			()
		)
ORDER BY Year, Month;
*/

-- Non hierarchical grouping sets
SELECT	YEAR(Adoption_Date) AS Year,
		Adopter_Email,
		COUNT(*) AS Annual_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			YEAR(Adoption_Date),
			Adopter_Email
		);

-- Handling NULLs
SELECT	COALESCE(Species, 'All') AS Species,
		CASE 
			WHEN GROUPING(Breed) = 1
			THEN 'All'
			ELSE Breed
		END AS Breed,
		GROUPING(Breed) AS Is_This_All_Breeds,
		COUNT(*) AS Number_Of_Animals
FROM	Animals
GROUP BY GROUPING SETS 
		(
			Species,
			Breed,
			()
		)
ORDER BY Species, Breed;

/*
  ________  ________   _______   ______ 
 /_  __/ / / / ____/  / ____/ | / / __ \
  / / / /_/ / __/    / __/ /  |/ / / / /
 / / / __  / /___   / /___/ /|  / /_/ / 
/_/ /_/ /_/_____/  /_____/_/ |_/_____/  
                                        
*/