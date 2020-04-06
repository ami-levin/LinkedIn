--------------------------------------
-- LinkedIn Learning -----------------
-- Advanced SQL - Window Functions ---
-- Ami Levin 2020 --------------------
-- .\Code Demos\Chapter6\Video2.sql --
--------------------------------------

-- Row offset functions

SELECT	species, 
		name,
		checkup_time,
		weight
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;

SELECT	species, 
		name,
		checkup_time,
		weight,
		weight - LAG (weight) 
				 OVER (PARTITION BY species, name 
				 	   ORDER BY checkup_time ASC
				 	  ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;

SELECT	species, 
		name,
		checkup_time,
		weight,
		weight - LAG (weight,1 , 'N/A') 
				 OVER (PARTITION BY species, name 
				 	   ORDER BY checkup_time ASC
				 	  ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;

SELECT	species, 
		name,
		checkup_time,
		weight,
		COALESCE (weight - LAG(weight) 
						   OVER (PARTITION BY species, name 
						         ORDER BY checkup_time ASC
						        )
				 , 'N/A'
				 ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;

SELECT	species, 
		name,
		checkup_time,
		weight,
		COALESCE (CAST (100 * (weight - LAG (weight) 
										OVER (PARTITION BY species, name 
											  ORDER BY checkup_time ASC
											  )
							  ) 
						AS VARCHAR(10)
						)
				  , 'N/A'
				 ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC,
			weight_gain ASC;

SELECT	species, 
		name,
		checkup_time,
		weight,
		weight - LAG (weight, 1, 0) 
				 OVER (PARTITION BY species, name 
				       ORDER BY checkup_time ASC
				      ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;

SELECT	species, 
		name,
		checkup_time,
		weight,
		weight - LAG (weight, 1, 0.0) 
				 OVER (PARTITION BY species, name 
				 	   ORDER BY checkup_time ASC
				 	  ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;

SELECT	species, 
		name,
		checkup_time,
		weight,
		weight - LAG (weight, 1, weight) 
				 OVER (PARTITION BY species, name 
				 	   ORDER BY checkup_time ASC
				 	  ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;

SELECT	species, 
		name,
		checkup_time,
		weight,
		weight - LAG (weight)
				 OVER (PARTITION BY species, name 
				 	   ORDER BY checkup_time ASC
				 	  ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;

