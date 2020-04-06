--------------------------------------
-- LinkedIn Learning -----------------
-- Advanced SQL - Window Functions ---
-- Ami Levin 2020 --------------------
-- .\Code Demos\Chapter2\Video3.sql --
--------------------------------------

SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		(	SELECT COUNT (*) 
			FROM animals
		) AS number_of_animals
FROM 	animals
ORDER BY 	species ASC, 
			admission_date ASC;

SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		COUNT (*) 
		OVER () AS number_of_animals
FROM 	animals
ORDER BY 	species ASC, 
			admission_date ASC;

-- PARTITION BY

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
		OVER (PARTITION BY species) AS number_of_species_animals
FROM 	animals
ORDER BY 	species ASC, 
			admission_date ASC;

-- Optimized subquery solution

SELECT 	a.species, 
		a.name, 
		a.primary_color, 
		a.admission_date,
		species_counts.number_of_species_animals
FROM 	animals AS a
		INNER JOIN 
		(	SELECT 	species,
					COUNT(*) AS number_of_species_animals
			FROM 	animals
			GROUP BY species
		) AS species_counts
		ON a.species = species_counts.species
ORDER BY 	a.species ASC,
			a.admission_date ASC;
