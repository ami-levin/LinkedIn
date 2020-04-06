----------------------------------------
-- LinkedIn Learning -------------------
-- Advanced SQL - Window Functions -----
-- Ami Levin 2020 ----------------------
-- .\Code Files\Chapter6\Solution.sql --
----------------------------------------

SELECT 	EXTRACT('quarter' FROM CURRENT_TIMESTAMP),
		EXTRACT('year' FROM CURRENT_TIMESTAMP);

WITH adoption_quarters
AS
(
SELECT 	Species,
		MAKE_DATE (	CAST (DATE_PART ('year', adoption_date) AS INT),
					CASE 
						WHEN DATE_PART ('month', adoption_date) < 4
							THEN 1
						WHEN DATE_PART ('month', adoption_date) BETWEEN 4 AND 6
							THEN 4
						WHEN DATE_PART ('month', adoption_date) BETWEEN 7 AND 9
							THEN 7
						WHEN DATE_PART ('month', adoption_date) > 9
							THEN 10
					END,
					1
				 ) AS quarter_start
FROM 	adoptions
)
-- SELECT * FROM adoption_quarters ORDER BY species, quarter_start;
,quarterly_adoptions
AS
(
SELECT 	COALESCE (species, 'All species') AS species,
		quarter_start,
		COUNT (*) AS quarterly_adoptions,
		COUNT (*) - COALESCE (
					-- For quarters with no previous adoptions use 0, not NULL 
							 	FIRST_VALUE (COUNT (*))
							 	OVER (PARTITION BY species
							 		  ORDER BY quarter_start ASC
								   	  RANGE BETWEEN 	INTERVAL '3 months' PRECEDING 
														AND 
														INTERVAL '3 months' PRECEDING
						 			 )
							, 0)
		AS adoption_difference_from_previous_quarter,
-- 		COUNT (*) OVER (PARTITION BY quarter_start) AS quarter_total_all_species, -- use with GROUP BY quarter_start, species
		CASE 	
			WHEN	quarter_start =	FIRST_VALUE (quarter_start) 
									OVER (PARTITION BY species
										  ORDER BY quarter_start ASC
										  RANGE BETWEEN 	UNBOUNDED PRECEDING
															AND
															UNBOUNDED FOLLOWING
										 )
			THEN 	0
			ELSE 	NULL
		END 	AS zero_for_first_quarter
FROM 	adoption_quarters
GROUP BY	GROUPING SETS 	((quarter_start, species), 
							 (quarter_start)
							)
)
-- SELECT * FROM quarterly_adoptions ORDER BY species, quarter_start;
,quarterly_adoptions_with_rank
AS
(
SELECT 	*,
		RANK ()
		OVER (	PARTITION BY species
				ORDER BY 	COALESCE (zero_for_first_quarter, adoption_difference_from_previous_quarter) DESC,
							-- First quarters are 0, all others NULL
							quarter_start DESC)
		AS quarter_rank
FROM 	quarterly_adoptions
)
-- SELECT * FROM quarterly_adoptions_with_rank ORDER BY species, quarter_rank, quarter_start;
SELECT 	species,
		CAST (DATE_PART ('year', quarter_start) AS INT) AS year,
		CAST (DATE_PART ('quarter', quarter_start) AS INT) AS quarter,
		adoption_difference_from_previous_quarter,
		quarterly_adoptions
FROM 	quarterly_adoptions_with_rank
WHERE 	quarter_rank <= 5
ORDER BY 	species ASC,
			adoption_difference_from_previous_quarter DESC,
			quarter_start ASC;

-----------------
-- Alternative --
-----------------

/*
██╗███╗   ███╗██████╗  ██████╗ ██████╗ ████████╗ █████╗ ███╗   ██╗████████╗██╗
██║████╗ ████║██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║╚══██╔══╝██║
██║██╔████╔██║██████╔╝██║   ██║██████╔╝   ██║   ███████║██╔██╗ ██║   ██║   ██║
██║██║╚██╔╝██║██╔═══╝ ██║   ██║██╔══██╗   ██║   ██╔══██║██║╚██╗██║   ██║   ╚═╝
██║██║ ╚═╝ ██║██║     ╚██████╔╝██║  ██║   ██║   ██║  ██║██║ ╚████║   ██║   ██╗
╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝
                                                                                                                                    */
----------------------------------------------------------------------------------
-- !!! The following solution contains an intentional bug !!! --------------------
-- Check the results carefully and compare with the previous solution. -----------
-- If you find the bug and know how to fix it, -----------------------------------
-- submit your solution on the chapter's GitHub repo at https://bit.ly/2wavOMH ---
----------------------------------------------------------------------------------
-- DO NOT post it on the Q&A section so you don't spoil the fun for others. ------
-- If you can't find it and want a hint, check this URL: https://bit.ly/3dVtFp6 --
----------------------------------------------------------------------------------

WITH adoption_quarters
AS
(
SELECT 	Species, 
		MAKE_DATE (	CAST( EXTRACT ('year' FROM adoption_date) AS INT),
					CASE 
						WHEN EXTRACT ('month' FROM adoption_date) < 4
							THEN 1
						WHEN EXTRACT ('month' FROM adoption_date) BETWEEN 4 AND 6
							THEN 4
						WHEN EXTRACT ('month' FROM adoption_date) BETWEEN 7 AND 9
							THEN 7
						WHEN EXTRACT ('month' FROM adoption_date) > 9
							THEN 10
					END,
					1
				 ) AS quarter_start
FROM 	adoptions
)
-- SELECT * FROM adoption_quarters ORDER BY species, quarter_start;
,quarterly_adoptions
AS
(
SELECT 	species,
		quarter_start,
		COUNT (*) AS quarterly_adoptions,
		COUNT (*) - COALESCE (
					-- NULL could mean no adoptions in previous quarter, or first quarter of shelter
							 FIRST_VALUE ( COUNT (*))
							 OVER (	PARTITION BY species
							 		ORDER BY quarter_start ASC
								   	RANGE BETWEEN 	INTERVAL '3 months' PRECEDING 
													AND 
													INTERVAL '3 months' PRECEDING
						 		  )
							, 0)
		AS adoption_difference_from_previous_quarter,
		CASE 	
			WHEN	LAG (quarter_start) 
					OVER (ORDER BY quarter_start ASC)
					IS NULL
			THEN 	TRUE
			ELSE 	FALSE
		END 	AS is_first_quarter
FROM 	adoption_quarters
GROUP BY	species,
			quarter_start
UNION ALL 
SELECT 	'All species' AS species,
		quarter_start,
		COUNT (*) AS quarterly_adoptions,
		COUNT (*) - COALESCE (
					-- NULL could mean no adoptions in previous quarter, or first quarter of shelter
							 FIRST_VALUE ( COUNT (*))
							 OVER (	ORDER BY quarter_start ASC
								   	RANGE BETWEEN 	INTERVAL '3 months' PRECEDING 
													AND 
													INTERVAL '3 months' PRECEDING
						 		  )
							, 0)
		AS adoption_difference_from_previous_quarter,
		CASE 	
			WHEN	LAG (quarter_start) 
					OVER (ORDER BY quarter_start ASC)
					IS NULL
			THEN 	TRUE
			ELSE 	FALSE
		END 	AS is_first_quarter
FROM 	adoption_quarters
GROUP BY	quarter_start
)
-- SELECT * FROM quarterly_adoptions ORDER BY species, quarter_start;
,quarterly_adoptions_with_row_number
AS
(
SELECT 	*,
		ROW_NUMBER ()
		-- ROW_NUMBER and RANK will return the same result since quarter_start per species is unique
		OVER (	PARTITION BY species
				ORDER BY 	CASE  
							WHEN is_first_quarter THEN 0
							-- First quarters should be considered as a 0
							ELSE adoption_difference_from_previous_quarter
			  				END DESC,
							quarter_start DESC)
		AS quarter_row_number
FROM 	quarterly_adoptions
)
-- SELECT * FROM quarterly_adoptions_with_row_number ORDER BY species, quarter_rank, quarter_start;
SELECT 	species,
		CAST (DATE_PART ('year', quarter_start) AS INT) AS year,
		CAST (DATE_PART ('quarter', quarter_start) AS INT) AS quarter,
		adoption_difference_from_previous_quarter,
		quarterly_adoptions
FROM 	quarterly_adoptions_with_row_number
WHERE 	quarter_row_number <= 5
ORDER BY 	species ASC,
			adoption_difference_from_previous_quarter DESC,
			quarter_start ASC;
		