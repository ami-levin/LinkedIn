--WINDOWS FUNCTIONS
--Section 4
--Aggregate window functions

/*
Hi Ami

In my attempt to solve the problem in the "Aggregate window function" section (Section 4, video 2)  by myself first, I succeeded with one of the classical ways (using a join after a CTE for the averages) and also with a CTE and a windows function.

In both cases, I get 147 animals with a TRUE for when the heart rate is higher than the average for their species.

However, in the query included in the solutions, the results shows only 13 animals with the avg higher than the average for their species.

The difference between your methods and mine is that I used a CASE function to get the indicator (I didn't know the EVERY function), running the windows function inside it again.

I have tried to analyze the EVERY function in your query but I still don't understand it very well, so I can't tell why we are getting such a difference. Could you take a look at your solution and correct me if I am wrong? I think the result should be 147 animals with a heart rate higher than the averages for their species

These are my two queries. The first one  with a join, the second one with Window Functions. 

Thanks

*/


--Return an animal'species, name, checkup time, heart rate and Boolean columns that is TRUE only for animals which all of their heart rate measurementes
-- were either equal to or above the average rate for their species

-- It can be solved by subqueries, derived tables or window funtions

-- Exploration
/*
SELECT * FROM routine_checkups rc ORDER BY species ASC, checkup_time ASC;
*/

-- METHOD 1 -- Using a join

WITH avg_hr AS (
-- This calculates the AVG heart rate by species
		SELECT
			species,
			ROUND(AVG(heart_rate),2) AS Rounded_AVG_hr_species, -- to get rouned results
			CAST( AVG(heart_rate) AS DECIMAL (5,2) ) AS Cast_AVG_hr_species -- We can also use CAST
		FROM
			routine_checkups rc
		GROUP BY
			species 
			)
-- SELECT * FROM avg_hr ; -- Test
SELECT
	rc.species,
	rc."name",
	rc.checkup_time,
	rc.heart_rate,
	ahr.Cast_AVG_hr_species, -- just for comparison purposes
	ahr.Rounded_AVG_hr_species,
	CASE
		WHEN rc.heart_rate >= ahr.Rounded_AVG_hr_species THEN TRUE
		ELSE FALSE
	END AS higher_than_average 
FROM
	routine_checkups rc
INNER JOIN avg_hr ahr
	-- The join brings the table with the avg hr per species
 ON
	rc.species = ahr.species
WHERE 
	CASE
		WHEN rc.heart_rate >= ahr.Rounded_AVG_hr_species THEN TRUE
		ELSE FALSE
	END = TRUE
ORDER BY
	rc.species ASC,
	rc.checkup_time ASC
;

-- METHOD 2 -- Using Window funtion. 
-- Window function and filtering only animals whose heart rate is higher than the average for it's species

WITH all_values AS (
		SELECT
			rc.species,
			rc."name",
			rc.checkup_time,
			rc.heart_rate,
			CAST( AVG(rc.heart_rate) OVER (PARTITION BY species) AS DECIMAL (5,2) ) AS AVG_hr_species,
			CASE
				WHEN rc.heart_rate >= CAST( AVG(rc.heart_rate) OVER (PARTITION BY species) AS DECIMAL (5,2) ) THEN TRUE
				ELSE FALSE
			END AS higher_than_average
		FROM
			routine_checkups rc
		ORDER BY
			rc.species ASC,
			rc.checkup_time ASC
		)
--SELECT * FROM all_values ; -- Test
SELECT
	*
FROM all_values 
WHERE 
	higher_than_average = TRUE
ORDER BY
	species ASC,
	checkup_time ASC
;
