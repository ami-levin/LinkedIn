-----------------------------------------
-- LinkedIn Learning --------------------
-- Advanced SQL - Window Functions ------
-- Ami Levin 2020 -----------------------
-- .\Code Files\Chapter7\Challenge.sql --
-----------------------------------------

/* 
---------------------------------------------------------------------------------------
-- Triple bonus points challenge - Annual average animal species vaccinations report --
---------------------------------------------------------------------------------------
-- !!! DISCLAIMER !!! This one is far from trivial, so be patient and careful. --------
---------------------------------------------------------------------------------------
Write a query that returns all years in which animals were vaccinated, and the total number of vaccinations given that year, per species.
In addition, the following three columns should be included in the results:
1. The average number of vaccinations per shelter animal of that species in that year.
2. The average number of vaccinations per shelter animal of that species in the previous 2 years.
3. The percent difference between columns 1 and 2 above.

----------------
-- Guidelines --
----------------

1. The average number of animals in any given year should take into account when animals were admitted, and when they were adopted.
To simplify the solution, it should be done on a yearly resolution.
This means that you should consider an animal that was admitted on any date as if it was admitted on January 1st of that year.
Similarly, consider an animal that was adopted on any date as if it was adopted on January 1st of that year.
For example - If in 2016, the first year, 10 cats and 5 dogs were admitted, and 2 cats and 2 dogs were adopted, consider the number of shelter animals for 2016 to be 8 cats, 3 dogs and 0 rabbits.
This carries over to the next year for which you will need to add admissions, subtract adoptions, and so on.
Of course, if you want to calculate this on a daily basis and only then average it out for the year, you are welcome to do so for extra bonus points.
My suggested solution does not.

2. Consider that there may be years without adoptions or without admissions for any species.
You may assume that there are no years without both adoptions and admissions for a species.
For my suggested solution it does not matter, but it may for others.

3. There may also be years without vaccinations for any species, but you are not required to show them.

Recommendation: Cast averages and expressions with division operators to DECIMAL (5, 2)
Expected result sorted by species ASC, year ASC:

--------------------------------------------------------------------------------------------------------------------------------------------
|	species	|	year	|	number_of_vaccinations	|	average_vaccinations_per_animal	|	previous_2_years_average	|	percent_change |
|-----------|-----------|---------------------------|-------------------------------------------------------------------|------------------|
|	Cat		|	2016	|					2		|							0.50	|					[NULL]		|		[NULL]     |
|	Cat		|	2017	|					7		|							0.78	|					0.5			|		156.00     |
|	Cat		|	2018	|					9		|							1.29	|					0.64		|		201.56     |
|	Cat		|	2019	|					10		|							1.25	|					1.04		|		120.19     |
|	Dog		|	2016	|					7		|							0.44	|					[NULL]		|		[NULL]     |
|	Dog		|	2017	|					15		|							0.56	|					0.44		|		127.27     |
|	Dog		|	2018	|					18		|							0.60	|					0.5			|		120.00     |
|	Dog		|	2019	|					17		|							0.85	|					0.58		|		146.55     |
|	Rabbit	|	2016	|					2		|							1.00	|					[NULL]		|		[NULL]     |
|	Rabbit	|	2017	|					1		|							0.20	|					1			|		20.00      |
|	Rabbit	|	2018	|					5		|							1.00	|					0.6			|		166.67     |
|	Rabbit	|	2019	|					2		|							1.00	|					0.6			|		166.67     |
--------------------------------------------------------------------------------------------------------------------------------------------

*/
-- Exploration
SELECT * FROM vaccinations v;
SELECT * FROM animals a;
SELECT * FROM adoptions a2;

-- SOLUTION STEPS --

-- STEP 1 
-- Calculate the vaccinations per year per species
-- STEP 2
-- Calculate the animals per year.
	-- a. Calculate the number of admisions per year
	-- b. Calculate number of adoptions per year
	-- c. Combine the tables with a FULL OUTER JOIN and calculate tha animal variations per year
-- STEP 3
-- Join animals in shelters with vaccinations and calculate the average vaccinations/animal
-- STEP 4 
-- Calculate the rolling average and the percentage variation

-- EXECUTION --

-- STEP 1 
-- Calculate the vaccinations per year per species

WITH vaccinations_per_year AS (
	SELECT
		species,
		DATE_PART('year',vaccination_time) AS year,
		COUNT(*) AS number_of_vaccinations
	FROM
		vaccinations v
	GROUP BY
		species,
		DATE_PART('year',vaccination_time)
	ORDER BY 
		species
	)
-- SELECT * FROM vaccinations_per_year; -- Test
	
-- STEP 2
-- Calculate the animals per year.
	-- a. Calculate the number of admisions per year
	-- b. Calculate number of adoptions per year
	-- c. Combine the tables with a FULL OUTER JOIN and calculate tha animal variations per year


-- 2a. Admisions per year

, admisions_per_year AS (
	SELECT
		species,
		DATE_PART('year',admission_date) AS year,
		COUNT(*) AS number_of_admisions
	FROM
		animals a1 
	GROUP BY
		species,
		DATE_PART('year',admission_date)
	ORDER BY 
		species
	)
--SELECT * FROM admisions_per_year; -- Test

-- 2b. Adoptions per year

, adoptions_per_year AS (
	SELECT
		species,
		DATE_PART('year',adoption_date) AS year,
		COUNT(*) AS number_of_adoptions
	FROM
		adoptions a2 
	GROUP BY
		species,
		DATE_PART('year',adoption_date)
	ORDER BY 
		species
	)
--SELECT * FROM adoptions_per_year; -- Test
	
-- 2c. Combine the tables with a FULL OUTER JOIN and calculate tha animal variations per year
-- Here I wrapped the fields in COALESCE. This way, if there are no admisions or adoptions in one year, the field still appears

, animals_in_shelters AS (
SELECT
	COALESCE(adm.species,adp.species) AS species,
	COALESCE (adm.year,adp.year) AS year,
	COALESCE(adm.number_of_admisions,0) as number_of_admissions,
	COALESCE (adp.number_of_adoptions, 0) AS number_of_adoptions,
	(adm.number_of_admisions - COALESCE (adp.number_of_adoptions, 0)) AS animals_in_shelter_variation,
	SUM((adm.number_of_admisions - COALESCE (adp.number_of_adoptions, 0))) 
		OVER ( PARTITION BY adm.species
		ORDER BY COALESCE (adm.year,adp.year)
		ROWS BETWEEN 
		UNBOUNDED PRECEDING 
		AND
		CURRENT ROW
		) AS animals_in_shelter
FROM admisions_per_year AS adm
	FULL OUTER JOIN adoptions_per_year AS adp 
		ON adm.species = adp.species
		AND adm.year = adp.year
)
-- SELECT * FROM  animals_in_shelters ; -- Test

-- STEP 3
-- Join animals in shelters with vaccinations and calculate the average vaccinations/animal

, average_vaccinations_per_animal AS (
	SELECT
		ais.species,
		ais."year",
		vpy.number_of_vaccinations,
		ais.animals_in_shelter,
		CAST( (vpy.number_of_vaccinations / ais.animals_in_shelter) AS DECIMAL (5,2) ) AS average_vaccinations_per_animal
	FROM animals_in_shelters AS ais
		LEFT JOIN vaccinations_per_year AS vpy
			ON ais.species = vpy.species
			AND ais.year = vpy.year
	)

--SELECT * FROM average_vaccinations_per_animal; -- Test
	
-- STEP 4 
-- Calculate the rolling average and the percentage variation

SELECT 
	species,
	"year",
	number_of_vaccinations,
--	animals_in_shelter,
	average_vaccinations_per_animal,
	CAST( AVG(average_vaccinations_per_animal) OVER w AS DECIMAL (5,2) ) AS previous_2_years_average,
	CAST( (average_vaccinations_per_animal / AVG(average_vaccinations_per_animal) OVER w) *100 AS DECIMAL (5,2) ) AS percent_change
FROM average_vaccinations_per_animal
WINDOW w AS (
		PARTITION BY species 
		ORDER BY year
		RANGE BETWEEN 
		2 PRECEDING 
		AND 
		1 PRECEDING 
		)
;