  
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
-- Name: Hui Shao (Shawn)
-- Twitter: 
-- LinkedIn: https://www.linkedin.com/in/huishaocn/
-- Facebook:
-- Website:
-- Date: Jan 14, 2021

--------------
-- Mandatory --
--------------
-- Solution + explanation
WITH yearly_vaccination_count AS -- This CTE summarizes yearly vaccination
(
SELECT  CAST ( DATE_PART ('year', vaccination_time) AS INT) AS year,
        count (*) AS number_of_vaccinations
FROM    vaccinations
GROUP BY    DATE_PART ('year', vaccination_time)
)
SELECT  *,
        CAST(AVG (number_of_vaccinations) OVER W AS DECIMAL (5, 2)) AS previous_2_years_average, -- Use window function to calculate previous 2 year average number of vaccinations
        CAST(100 * number_of_vaccinations / (AVG (number_of_vaccinations) OVER W ) AS DECIMAL (5, 2)) AS percent_change  -- Use window function to calculate percentage change
FROM    yearly_vaccination_count
WINDOW W AS (   ORDER BY year ASC
                RANGE BETWEEN   2 PRECEDING
                                AND
                                1 PRECEDING
            )
ORDER BY year ASC;
