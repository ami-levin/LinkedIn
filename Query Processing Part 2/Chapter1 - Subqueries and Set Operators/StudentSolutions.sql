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
