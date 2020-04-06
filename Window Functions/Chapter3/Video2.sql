--------------------------------------
-- LinkedIn Learning -----------------
-- Advanced SQL - Window Functions ---
-- Ami Levin 2020 --------------------
-- .\Code Demos\Chapter3\Video2.sql --
--------------------------------------

-- Queries from the previous chapter
SELECT 	a1.species,
		a1.name, 
		a1.primary_color, 
		a1.admission_date,
		(	SELECT 	COUNT (*) 
			FROM 	animals AS a2
			WHERE 	a2.species = a1.species
		) AS number_of_species_animals
FROM 	animals AS a1
ORDER BY 	a1.species ASC,
			a1.admission_date ASC;

SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		COUNT (*) 
		OVER (PARTITION BY species) 
			AS number_of_species_animals
FROM 	animals
ORDER BY 	species ASC,
			admission_date ASC;

-------------
-- Framing --
-------------
-- Count up-to-previous day number of animals of the same species
SELECT 	a1.species, 
		a1.name, 
		a1.primary_color, 
		a1.admission_date,
		(	SELECT 	COUNT (*) 
			FROM 	animals AS a2
			WHERE 	a2.species = a1.species
					AND
					a2.admission_date < a1.admission_date
		) AS up_to_previous_day_species_animals
FROM 	animals AS a1
ORDER BY 	a1.species ASC,
			a1.admission_date ASC;

SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		COUNT (*) 
		OVER (	PARTITION BY 	species
				ORDER BY 		admission_date ASC
				ROWS BETWEEN 	UNBOUNDED PRECEDING 
								AND 
								CURRENT ROW
			 ) AS up_to_previous_day_species_animals
FROM 	animals
ORDER BY 	species ASC,
			admission_date ASC;

-- Same as above, but the wrong answer
SELECT 	a1.species, 
		a1.name, 
		a1.primary_color, 
		a1.admission_date,
		(	SELECT 	COUNT (*) 
			FROM 	animals AS a2
			WHERE 	a2.species = a1.species
					AND
					a2.admission_date <= a1.admission_date
		) AS up_to_today_species_animals
FROM 	animals AS a1
ORDER BY 	a1.species ASC,
			a1.admission_date ASC;

SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		COUNT (*) 
		OVER (	PARTITION BY 	species
				ORDER BY 		admission_date ASC
				ROWS BETWEEN 	UNBOUNDED PRECEDING 
								AND 
								1 PRECEDING
			 ) AS up_to_previous_day_species_animals
FROM 	animals
ORDER BY 	species ASC, 
			admission_date ASC;

-- Animals of the same species admitted on the same day
SELECT 	species, 
		admission_date, 
		COUNT (*)
FROM 	animals
GROUP BY 	species, 
			admission_date 
HAVING 	COUNT (*) > 1;

-- Which animals are they?
SELECT 	*
FROM 	animals
WHERE 	admission_date = '2017-08-29';

-- Focus on King and Prince
SELECT 	a1.species, 
		a1.name, 
		a1.primary_color, 
		a1.admission_date,
		(	SELECT 	COUNT (*) 
			FROM 	animals AS a2
			WHERE 	a2.species = a1.species
					AND
					a2.admission_date < a1.admission_date
					AND
					a2.species = 'Dog' 
					AND 
					a2.admission_date > '2017-08-01'
		) AS up_to_previous_day_species_animals
FROM 	animals AS a1
WHERE 	a1.species = 'Dog' 
		AND 
		a1.admission_date > '2017-08-01'
ORDER BY 	a1.species ASC, 
			a1.admission_date ASC;

-- CTEs save the day
WITH filtered_animals AS
( 	SELECT 	*
	FROM 	animals
	WHERE 	species = 'Dog' 
			AND 
			admission_date > '2017-08-01')
SELECT 	fa1.species, fa1.name, 
		fa1.primary_color, fa1.admission_date,
		(	SELECT 	COUNT (*) 
			FROM 	filtered_animals AS fa2
			WHERE 	fa2.species = fa1.species
					AND
					fa2.admission_date < fa1.admission_date
		) AS up_to_previous_day_species_animals
FROM 	filtered_animals AS fa1
ORDER BY 	fa1.species ASC, fa1.admission_date ASC;

-- ROWS 1 PRECEDING
SELECT 	species,
		name,
		primary_color, 
		admission_date,
		COUNT (*) 
		OVER (	PARTITION BY 	species
				ORDER BY 		admission_date ASC
				ROWS BETWEEN 	UNBOUNDED PRECEDING 
								AND 
								1 PRECEDING
			 ) AS up_to_yesterday_species_animals
FROM 	animals
WHERE 	species = 'Dog' 
		AND 
		admission_date > '2017-08-01'
ORDER BY 	species ASC, 
			admission_date ASC;

-- RANGE 1 day PRECEDING
SELECT 	species,
		name, 
		primary_color, 
		admission_date,
		COUNT (*) 
		OVER (	PARTITION BY 	species
				ORDER BY 		admission_date ASC
				RANGE BETWEEN 	UNBOUNDED PRECEDING 
								AND 
								1 PRECEDING
			 ) AS up_to_previous_day_species_animals
FROM 	animals
WHERE 	species = 'Dog' 
		AND 
		admission_date > '2017-08-01'
ORDER BY 	species ASC, 
			admission_date ASC;
			
SELECT 	species,
		name, 
		primary_color, 
		admission_date,
		COUNT (*) 
		OVER (	PARTITION BY 	species
				ORDER BY 		admission_date ASC
				RANGE BETWEEN 	UNBOUNDED PRECEDING 
								AND 
								'1 day' PRECEDING
			 ) AS up_to_previous_day_species_animals
FROM 	animals
WHERE 	species = 'Dog' 
		AND 
		admission_date > '2017-08-01'
ORDER BY 	species ASC, 
			admission_date ASC;

