----------------------------------------
-- LinkedIn Learning -------------------
-- Advanced SQL - Window Functions -----
-- Ami Levin 2020 ----------------------
-- .\Code Files\Chapter5\Solution.sql --
----------------------------------------

WITH checkups_with_temperature_differences
AS
(
SELECT 	species,
		name,
		temperature,
		checkup_time,
		CAST ( 	AVG (temperature) 
				OVER (PARTITION BY species) 
			 	AS DECIMAL (5,2)
			 ) AS species_average_temperature,
		CAST (	temperature - 	AVG (temperature) 
								OVER (PARTITION BY species)
			 	AS DECIMAL (5, 2) 
			 ) AS difference_from_average
FROM 	routine_checkups
)
-- SELECT * FROM checkups_with_temperature_differences ORDER BY species, difference_from_average;
,temperature_differences_with_exception_indicator
AS
(
SELECT	*,
		CASE 
		WHEN ABS (difference_from_average / species_average_temperature) >= 0.005
			THEN 1
		ELSE 0
		END AS is_temperature_exception
FROM 	checkups_with_temperature_differences
)
-- SELECT * FROM temperature_differences_with_exception_indicator ORDER BY species, difference_from_average;
,grouped_animals_with_exceptions
AS 
(
SELECT	species,
		name,
		SUM (is_temperature_exception) AS number_of_exceptions,
		MAX (	CASE 
				WHEN is_temperature_exception = 1 
					THEN checkup_time
				ELSE NULL
				END
			) AS latest_exception
FROM 	temperature_differences_with_exception_indicator
GROUP BY 	species,
			name
)
-- SELECT * FROM grouped_animals_with_exceptions ORDER BY species, number_of_exceptions;
,animal_exceptions_with_ntile
AS
(
SELECT 	*,
		NTILE (4)
		OVER (	PARTITION BY species 
				ORDER BY number_of_exceptions ASC, -- try DESC,
						 latest_exception DESC -- try ASC
			 ) AS ntile
FROM 	grouped_animals_with_exceptions
)
-- SELECT * FROM animal_exceptions_with_ntile ORDER BY species, number_of_exceptions, latest_exception DESC;
SELECT 	species,
		name,
		number_of_exceptions,
		latest_exception
FROM 	animal_exceptions_with_ntile
WHERE 	ntile = 1 -- try 4
ORDER BY 	species ASC,
			number_of_exceptions DESC,
			latest_exception DESC;


-----------------		
-- Alternative --
-----------------
-- Using a grouped derived table instead of an aggregate window function
WITH checkups_with_temperature_differences
AS
(
SELECT 	rc.species,
		name,
		temperature,
		checkup_time,
		species_average_temperature,
		(temperature - species_average_temperature) AS difference_from_average
FROM 	routine_checkups AS rc
		INNER JOIN
		(	SELECT	species,
					CAST ( AVG (temperature) AS DECIMAL (5, 2)) AS species_average_temperature
			FROM 	routine_checkups
			GROUP BY species
		) AS at -- Average Temperatures
			ON rc.species = at.species
)	
-- SELECT * FROM checkups_with_temperature_differences ORDER BY species, difference_from_average;
-- Using CROSS JOIN LATERAL instead of a SELECT expression.
-- Very useful in many cases, remember this one.
,temperature_differences_with_exception_indicator
AS
(
SELECT	*
FROM 	checkups_with_temperature_differences AS cw
		CROSS JOIN LATERAL
		(	VALUES (	CASE 
						WHEN ABS (cw.difference_from_average / cw.species_average_temperature) >= 0.005
							THEN TRUE
						ELSE NULL
						END
					)
		) AS exceptions (is_temperature_exception)
)
-- SELECT * FROM temperature_differences_with_exception_indicator ORDER BY species, difference_from_average;
,grouped_animals_with_exceptions
AS 
(
SELECT	species,
		name,
		COUNT (is_temperature_exception) AS number_of_exceptions,
		-- Count of Booleans - remember this trick too.
		MAX (	CASE 
				WHEN is_temperature_exception
					THEN checkup_time
				ELSE NULL
				END
			) AS latest_exception
FROM 	temperature_differences_with_exception_indicator
GROUP BY 	species,
			name
)
-- SELECT * FROM grouped_animals_with_exceptions ORDER BY species, number_of_exceptions;
,animal_exceptions_with_ranking
AS
(
SELECT 	*,
		PERCENT_RANK()
		OVER (	PARTITION BY species 
				ORDER BY number_of_exceptions ASC,
						 latest_exception DESC
			 ) AS rank
FROM 	grouped_animals_with_exceptions
)
-- SELECT * FROM animal_exceptions_with_ntile ORDER BY species, number_of_exceptions, latest_exception DESC;
SELECT 	species,
		name,
		number_of_exceptions,
		latest_exception
FROM 	animal_exceptions_with_ranking
WHERE 	rank <= 0.25
		-- Do you think this solution complies with the challenge requirements?
		-- If not, can you think of a situation where it will fail?
ORDER BY 	species ASC,
			number_of_exceptions DESC,
			latest_exception DESC;
