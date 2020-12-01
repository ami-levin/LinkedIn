/*
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@ Copy the template headers below.          @@
@@ Modify content for your solution.         @@
@@ Paste below the last solution.            @@
@@ Submit a PR.                              @@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
*/

--------------
-- OPTIONAL --
--------------
-- Name: Anonymous
-- Twitter handle:
-- Facebook page:
-- Website:
-- Date: 2020-10-16

--------------
-- Mandatory --
--------------
-- Solution
WITH Adoption_count AS
(
SELECT a.species AS species,
breed,
CASE WHEN adoption_date IS NULL
THEN 0 ELSE 1 END AS no_of_adoptions
FROM animals a
LEFT JOIN adoptions ad
ON a.name = ad.name
AND
a.species = ad.species

)

SELECT
species,
breed
FROM
(
SELECT DISTINCT
species,
breed,
sum(no_of_adoptions) OVER (PARTITION BY species,breed) AS Adopted
FROM adoption_count
ORDER BY species
) T1

WHERE Adopted = 0

-- Explanation

-- <Your brief explanation here>
Adding my solution for the Challenge : Find breeds that were never adopted


--------------
--------------
-- Name: Prabin Kayastha
-- Twitter handle:
-- Facebook page:
-- Website: www.linkedin.com/in/prabin-kayastha
-- Date: 2020-12-01

--------------
-- Solution
--------------

USE Animal_Shelter 
GO

SELECT Adopter_Email
	,Adoption_Date
	,Name_A
	,Species_A
	,Name_B
	,Species_B
FROM (
	SELECT A.Adopter_Email
		,A.Adoption_Date
		,A.Name Name_A
		,A.Species Species_A
		,B.Name Name_B
		,B.Species Species_B
		,Rnk
	FROM dbo.Adoptions A
	JOIN (
		SELECT *
			,COUNT(1) OVER (
				PARTITION BY Adopter_Email
				,Adoption_Date
				) AS [Adoptions Per Day Count]
			,ROW_NUMBER() OVER (
				PARTITION BY Adopter_Email
				,Adoption_Date ORDER BY Name
				) Rnk
		FROM dbo.Adoptions
		) B ON A.Adopter_Email = B.Adopter_Email
		AND A.Adoption_Date = B.Adoption_Date
		AND B.[Adoptions Per Day Count] = 2
		AND NOT (
			A.Name = B.Name
			AND A.Species = B.Species
			)
	) ABC
WHERE Rnk = 1

-- Explanation
-- Adding my solution for the Challenge : Find Adopters who adopt two animals on the same day
-- I have used window function(count) for finding the exact two adoptions per day and row_number to eliminae the records for which the info a and info b are swapped.