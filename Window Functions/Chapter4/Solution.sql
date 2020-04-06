----------------------------------------
-- LinkedIn Learning -------------------
-- Advanced SQL - Window Functions -----
-- Ami Levin 2020 ----------------------
-- .\Code Files\Chapter4\Solution.sql --
----------------------------------------

WITH annual_vaccinations
AS
(
SELECT	CAST (DATE_PART ('year', vaccination_time) AS INT) AS year,
		COUNT (*) AS number_of_vaccinations
FROM 	vaccinations
GROUP BY DATE_PART ('year', vaccination_time)
)
-- SELECT * FROM annual_vaccinations ORDER BY year; -- Uncomment to execute preceding CTE
,annual_vaccinations_with_previous_2_year_average
AS
(
SELECT 	*,
		CAST (AVG (number_of_vaccinations) 
			   OVER (ORDER BY year ASC
					 RANGE BETWEEN 2 PRECEDING AND 1 PRECEDING 
					 -- Watch out for frame type...
					) 
			AS DECIMAL (5, 2)
			 )
		AS previous_2_years_average
FROM 	annual_vaccinations
-- WHERE year <> 2018 -- remove comment to check difference between ROWS and RANGE above
)
-- SELECT * FROM annual_vaccinations_with_previous_2_year_average ORDER BY year;
SELECT 	*,
		CAST ((100 * number_of_vaccinations / previous_2_years_average) 
			 AS DECIMAL (5, 2)
			 ) AS percent_change
FROM 	annual_vaccinations_with_previous_2_year_average
ORDER BY year ASC;

--------------------------------------------------------------------------------------------------------------
-- Extra challenge: Try to find an alternative solution and post it in the Q&A section. ----------------------
-- Solutions that either perform better, are simpler, or highly creative, will receive an honorary mention. --
--------------------------------------------------------------------------------------------------------------