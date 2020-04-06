--------------------------------------
-- LinkedIn Learning -----------------
-- Advanced SQL - Window Functions ---
-- Ami Levin 2020 --------------------
-- .\Code Demos\Chapter4\Video3.sql --
--------------------------------------

SELECT	*
FROM	adoptions;

SELECT	DATE_PART ('year', adoption_date) AS year,
		DATE_PART ('month', adoption_date) AS month,
		SUM (adoption_fee) AS month_total
FROM	adoptions
GROUP BY 	DATE_PART ('year', adoption_date), 
			DATE_PART ('month', adoption_date)
ORDER BY 	year ASC,
			month ASC;
		
SELECT 	DATE_PART ('year', adoption_date) AS year,
		DATE_PART ('month', adoption_date) AS month,
		SUM (adoption_fee) AS month_total,
		CAST (100 * SUM (adoption_fee) 
					/	SUM (adoption_fee) 
						OVER (PARTITION BY DATE_PART ('year', adoption_date))
			 AS DECIMAL (5, 2)
			 ) AS annual_percent
FROM 	adoptions
GROUP BY 	DATE_PART ('year', adoption_date), 
			DATE_PART ('month', adoption_date)
ORDER BY 	year ASC,
			month ASC;

SELECT 	DATE_PART ('year', adoption_date) AS year,
		DATE_PART ('month', adoption_date) AS month,
		SUM (adoption_fee) AS month_total,
		CAST	(100 *  SUM (adoption_fee) 
						/	SUM ( SUM (adoption_fee)) 
							OVER (PARTITION BY DATE_PART('year', adoption_date)) 
			AS DECIMAL (5, 2)
			) AS annual_percent
FROM 	adoptions
GROUP BY 	DATE_PART('year', adoption_date), 
			DATE_PART('month', adoption_date)
ORDER BY 	year ASC,
			month ASC;

WITH monthly_grouped_adoptions
AS
(
SELECT 	DATE_PART ('year', adoption_date) AS year,
		DATE_PART ('month', adoption_date) AS month,
		SUM (adoption_fee) AS month_total
FROM 	adoptions
GROUP BY 	DATE_PART ('year', adoption_date), 
			DATE_PART ('month', adoption_date)
)
SELECT 	*,
		CAST 	(100 * month_total 
				 / 	SUM (month_total) 
					OVER (PARTITION BY year) 
				AS DECIMAL (5, 2)
				) AS annual_percent
FROM 	monthly_grouped_adoptions
ORDER BY 	year ASC,
			month ASC;