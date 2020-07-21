--------------------------------------------
-- LinkedIn Learning -----------------------
-- Advanced SQL - Query Processing Part 2 --
-- Ami Levin 2020 --------------------------
-- .\Chapter1\Video1.sql -------------------
--------------------------------------------

-- GitHub
https://github.com/ami-levin/LinkedIn/tree/master/Query%20Processing%20Part%202/Chapter1%20-%20Subqueries%20and%20Set%20Operators/Video1.sql

-- DBFiddle UK
/*SQL Server*/	https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=61cff09e3fc8ec691a6700ab221aeeeb&hide=3
/*PostgreSQL*/	https://dbfiddle.uk/?rdbms=postgres_12&fiddle=6e89d50ca69b75aa138aa36ccfa6b08d&hide=1

/*
   _____       __                          _          
  / ___/__  __/ /_  ____ ___  _____  _____(_)__  _____
  \__ \/ / / / __ \/ __ `/ / / / _ \/ ___/ / _ \/ ___/
 ___/ / /_/ / /_/ / /_/ / /_/ /  __/ /  / /  __(__  ) 
/____/\__,_/_.___/\__, /\__,_/\___/_/  /_/\___/____/  
                    /_/                               
*/

-- Get MAX adoption fee
SELECT	MAX(Adoption_Fee)
FROM	Adoptions;

-- Non correlated expression subquery
SELECT	*,
		(	SELECT	MAX(Adoption_Fee)
			FROM	Adoptions
		) AS Max_Fee
FROM	Adoptions;

-- Must repeat entire subquery for each instance
SELECT	*,
		(SELECT MAX(Adoption_Fee) FROM Adoptions) AS Max_Fee,
		(((SELECT MAX(Adoption_Fee) FROM Adoptions) - Adoption_Fee) * 100)
			/ (SELECT MAX(Adoption_Fee) FROM Adoptions) AS Discount_Percent
FROM	Adoptions;

-- Shorten with WITH clause
WITH Adoptions_and_Max_Fee
AS
(
SELECT	*,
		(SELECT MAX(Adoption_Fee) FROM Adoptions) AS Max_Fee
FROM	Adoptions
)
SELECT	*, 
		Max_Fee,
		(((Max_Fee - Adoption_Fee) * 100) / Max_Fee) AS Discount_Percent
FROM	Adoptions_and_Max_Fee;

-- Use variables
DECLARE @Max_Fee INT = (SELECT MAX(Adoption_Fee) FROM Adoptions);

SELECT	*,
		@Max_Fee,
		(((@Max_Fee - Adoption_Fee) * 100) / @Max_Fee) AS Discount_Percent
FROM Adoptions;

/* PostgreSQL variables...
DROP FUNCTION demo();
CREATE FUNCTION demo() 
RETURNS TABLE	(	
					Name VARCHAR(20), 
					Species VARCHAR(10), 
					Adoption_Date DATE, 
					Adoption_Fee SMALLINT, 
					Max_Adoption_Fee INT, 
					Discount_Percent INT
				)
AS $$
DECLARE Max_Fee INT;
BEGIN
	SELECT MAX(adoptions.Adoption_Fee) INTO Max_Fee FROM adoptions;
	RETURN QUERY 
	SELECT 	a.Name, 
			a.Species, 
			a.Adoption_Date, 
			a.Adoption_Fee, 
			Max_Fee, 
			(((Max_Fee - a.Adoption_Fee) * 100) / Max_Fee)
	FROM adoptions AS a;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM Demo();

*/

-- Get MAX adoption fee per species
SELECT	Species, 
		MAX(Adoption_Fee) AS Max_Species_Fee 
FROM	Adoptions 
GROUP BY Species;

-- Don't try this at home!
SELECT	*,
		(	SELECT	MAX(Adoption_Fee) 
			FROM	Adoptions
			WHERE	Species = 'Dog'
		) AS Max_Dog_Fee,
		(	SELECT	MAX(Adoption_Fee) 
			FROM	Adoptions
			WHERE	Species = 'Cat'
		) AS Max_Cat_Fee,
		(	SELECT	MAX(Adoption_Fee) 
			FROM	Adoptions
			WHERE	Species = 'Rabbit'
		) AS Max_Rabbit_Fee
FROM	Adoptions;

-- Correlated expression subquery
SELECT	*,
		(	SELECT	MAX(Adoption_Fee) 
			FROM	Adoptions AS A2 
			WHERE	A1.species = A2.Species
		) AS Max_Fee
FROM	Adoptions AS A1;

-- Better solution, get MAX fee only once per species...
SELECT	A.*,
		M.Max_Species_Fee
FROM	Adoptions AS A
		INNER JOIN
		(
			SELECT	Species, 
					MAX(Adoption_Fee) AS Max_Species_Fee
			FROM	Adoptions 
			GROUP BY Species
		) AS M
			ON A.Species = M.Species;

-- Number of Persons and adoptions
SELECT	COUNT(*)
FROM	Persons;

SELECT	COUNT(*)
FROM	Adoptions;

-- Use JOIN
SELECT	DISTINCT P.*
FROM	Persons AS P
		INNER JOIN
		Adoptions AS A
			ON A.Adopter_Email = P.Email;

-- Use IN = where is the bug?
SELECT	*
FROM	Persons
WHERE	Email IN (SELECT Email FROM Adoptions);

-- Be careful with subquery aliases!
SELECT	*
FROM	Persons
WHERE	Email IN (SELECT Adopter_Email FROM Adoptions);

-- True row expression
/* PostgreSQL
SELECT	*
FROM	Animals
WHERE	(Name, Species) = ROW('Abby', 'Dog');
*/

-- Non correlated EXISTS - Don't try this at home!
SELECT	*
FROM	Persons
WHERE	EXISTS	(	
				SELECT	NULL
				FROM	Adoptions
				WHERE	species = 'Dog' -- 'Elephant'
				);

-- Correlated EXISTS is the way to go!
SELECT	*
FROM	Persons AS P
WHERE	EXISTS	(
				SELECT	NULL
				FROM	Adoptions AS A
				WHERE	A.Adopter_Email = P.Email
				);

/*
  ________  ________   _______   ______ 
 /_  __/ / / / ____/  / ____/ | / / __ \
  / / / /_/ / __/    / __/ /  |/ / / / /
 / / / __  / /___   / /___/ /|  / /_/ / 
/_/ /_/ /_/_____/  /_____/_/ |_/_____/  
                                        
*/