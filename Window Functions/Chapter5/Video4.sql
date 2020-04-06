--------------------------------------
-- LinkedIn Learning -----------------
-- Advanced SQL - Window Functions ---
-- Ami Levin 2020 --------------------
-- .\Code Demos\Chapter5\Video4.sql --
--------------------------------------

SELECT	species, 
		name, 
		CAST (AVG (weight) AS DECIMAL (5, 2)) AS average_weight
FROM 	routine_checkups
GROUP BY 	species, 
			name
ORDER BY 	species DESC, 
			average_weight DESC;

WITH average_weights
AS
(
SELECT	species, 
		name, 
		CAST (AVG (weight) AS DECIMAL (5, 2)) AS average_weight
FROM 	routine_checkups
GROUP BY 	species, 
			name
)
SELECT 	*,
		PERCENT_RANK () 
		OVER (PARTITION BY species 
			  ORDER BY average_weight
			 ) AS percent_rank,
		CUME_DIST () 
		OVER (PARTITION BY species 
			  ORDER BY average_weight
			 ) AS cumulative_distribtuion
FROM 	average_weights
ORDER BY 	species DESC, 
			average_weight DESC;

