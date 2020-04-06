--------------------------------------
-- LinkedIn Learning -----------------
-- Advanced SQL - Window Functions ---
-- Ami Levin 2020 --------------------
-- .\Code Demos\Chapter2\Video2.sql --
--------------------------------------

-- OVER ()

SELECT 	species, 
		name, 
		primary_color, 
		admission_date
FROM 	animals
ORDER BY admission_date ASC;

SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		(	SELECT COUNT (*) 
			FROM animals
		) AS number_of_animals
FROM 	animals
ORDER BY admission_date ASC;

SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		COUNT (*) 
		OVER () AS number_of_animals
FROM 	animals
ORDER BY admission_date ASC;

-- FILTER

SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		(	SELECT 	COUNT (*) 
			FROM 	animals
			WHERE 	admission_date >= '2017-01-01'
		) AS number_of_animals
FROM 	animals
ORDER BY admission_date ASC;

SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		(	SELECT 	COUNT (*) 
			FROM 	animals
			WHERE 	admission_date >= '2017-01-01'
		) AS number_of_animals
FROM 	animals
WHERE 	admission_date >= '2017-01-01'
ORDER BY admission_date ASC;

SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		COUNT (*)
		FILTER (WHERE admission_date >= '2017-01-01')
		OVER () AS number_of_animals
FROM 	animals
ORDER BY admission_date ASC;

SELECT 	species,
		name, 
		primary_color, 
		admission_date,
		COUNT (*)
		OVER () AS number_of_animals
FROM 	animals	
WHERE 	admission_date >= '2017-01-01'
ORDER BY admission_date ASC;