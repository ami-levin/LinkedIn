--------------------------------------
-- LinkedIn Learning -----------------
-- Advanced SQL - Window Functions ---
-- Ami Levin 2020 --------------------
-- .\Code Demos\Chapter5\Video2.sql --
--------------------------------------

-- Number of checkups per animal
SELECT 	species, 
		name, 
		COUNT (*) AS number_of_checkups
FROM	routine_checkups
GROUP BY 	species, 
			name
ORDER BY 	species, 
			number_of_checkups DESC;

-- Reference.species table
SELECT 	*
FROM 	reference.species;

-- Include species with no checkups (or no animals for that matter...)
SELECT 	s.species, 
		rc.name, 
		COUNT (rc.checkup_time) AS number_of_checkups 
		-- Can't use * in order to return 0 for species with no checkups
FROM	reference.species AS s 
		LEFT OUTER JOIN -- Include species with no checkups...
		routine_checkups AS rc
		ON s.species = rc.species
GROUP BY 	s.species, 
			rc.name
ORDER BY 	s.species, 
			number_of_checkups DESC;

-- Subquery solution
WITH animal_checkups
AS
(
SELECT 	s.species, 
		rc.name, -- For species with no checkups
		COUNT (checkup_time) AS number_of_checkups 
FROM	reference.species AS s 
		LEFT OUTER JOIN
		routine_checkups AS rc
		ON s.species = rc.species
GROUP BY 	s.species, 
			rc.name
)
-- SELECT * FROM animal_checkups ORDER BY species, number_of_checkups DESC;
, add_count_of_more_checked_animalss
AS
(
SELECT 	*,
		(	SELECT 	COUNT (*) 
			FROM	animal_checkups AS ac2
			WHERE	ac2.species = ac1.species
					AND
					ac2.number_of_checkups > ac1.number_of_checkups
		) AS number_of_more_checked_animals
FROM 	animal_checkups AS ac1
)
-- SELECT * FROM add_count_of_more_checked_animalss ORDER BY species, number_of_checkups DESC; 
SELECT 	species,
		name,
		number_of_checkups
FROM 	add_count_of_more_checked_animalss
WHERE 	number_of_more_checked_animals < 3 
ORDER BY 	species, 
			number_of_checkups DESC;

-- Corrected for ties
WITH animal_checkups
AS
(
SELECT 	s.species, 
		rc.name, -- For species with no checkups
		COUNT (checkup_time) AS number_of_checkups
FROM	reference.species AS s 
		LEFT OUTER JOIN
		routine_checkups AS rc
		ON s.species = rc.species
GROUP BY 	s.species, 
			rc.name
)
-- SELECT * FROM animal_checkups ORDER BY species, number_of_checkups DESC;
, add_count_of_more_checked_animalss
AS
(
SELECT 	*,
		(	SELECT 	COUNT (*) 
			FROM	animal_checkups AS ac2
			WHERE	ac2.species = ac1.species
					AND
					(
						ac2.number_of_checkups > ac1.number_of_checkups
						OR
							(
								ac2.number_of_checkups = ac1.number_of_checkups -- Tie breaker
								AND 
								ac2.name < ac1.name -- Unique per species, guarantees no ties
							)
					)
		) AS number_of_more_checked_animals
FROM 	animal_checkups AS ac1
)
-- SELECT * FROM add_count_of_more_checked_animalss ORDER BY species, number_of_checkups DESC; 
SELECT 	species,
		name, 
		number_of_checkups
FROM 	add_count_of_more_checked_animalss
WHERE 	number_of_more_checked_animals < 3
ORDER BY 	species, 
			number_of_checkups DESC;

-- Solution with ROW_NUMBER
WITH animal_checkups
AS
(
SELECT 	s.species, 
		rc.name, -- For species with no checkups
		COUNT (checkup_time) AS number_of_checkups
FROM	reference.species AS s 
		LEFT OUTER JOIN 
		routine_checkups AS rc
		ON s.species = rc.species
GROUP BY 	s.species, 
			rc.name
)
, include_row_number_by_number_of_chekcups
AS 
(
SELECT 	*,
		ROW_NUMBER () 
		OVER (	PARTITION BY Species 
				ORDER BY 	number_of_checkups DESC, 
							name
			 ) AS row_number
FROM	animal_checkups
)
-- SELECT * FROM include_row_number_by_number_of_chekcups ORDER BY species, number_of_checkups DESC;
SELECT 	species,
		name,
		number_of_checkups
FROM 	include_row_number_by_number_of_chekcups
WHERE 	row_number <= 3
ORDER BY 	species, 
			number_of_checkups DESC;

-- NTILE
SELECT 	species, 
		name, 
		admission_date,
		NTILE (10) 
		OVER (ORDER BY admission_date) AS ten_segments,
		NTILE (30) 
		OVER (ORDER BY admission_date) AS thirty_segments,
		NTILE (30) 
		OVER (PARTITION BY Species 
			  ORDER BY admission_date) AS thirty_segments_per_species
FROM 	Animals
ORDER BY 	species, 
			admission_date;

--------------------------
-- Alternative solution --
--------------------------
SELECT 	s.species,
		animal_checkups.name,
		COALESCE (animal_checkups.number_of_checkups, 0) AS number_of_checkups
FROM 	reference.species AS s
		LEFT OUTER JOIN LATERAL 
		(
			SELECT 	rc.species,
					rc.name,
					COUNT (*) AS number_of_checkups
			FROM 	routine_checkups AS rc
			WHERE 	s.species = rc.species
			GROUP BY 	rc.species, 
						rc.name
			ORDER BY 	rc.species,
						number_of_checkups DESC,
						name
			LIMIT 3 OFFSET 0
		) AS animal_checkups
		ON TRUE;

