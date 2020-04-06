----------------------------------------
-- LinkedIn Learning -------------------
-- Advanced SQL - Window Functions -----
-- Ami Levin 2020 ----------------------
-- .\Code Files\Chapter7\Solution.sql --
----------------------------------------

WITH annual_admitted_animals
AS
(
SELECT	species,
		DATE_PART ('year', admission_date) AS year,
		COUNT(*) AS admitted_animals
FROM 	animals
GROUP BY 	species,
			DATE_PART ('year', admission_date)
)
-- SELECT * FROM annual_admitted_animals ORDER BY species, admission_year;
,annual_adopted_animals
AS
(
SELECT	species,
		DATE_PART ('year', adoption_date) AS year,
		COUNT(*) AS adopted_animals
FROM 	adoptions AS a
GROUP BY 	species,
			DATE_PART ('year', adoption_date)
)
-- SELECT * FROM annual_adopted_animals ORDER BY species, adoption_year;
,annual_number_of_shelter_species_animals
AS
(
SELECT 	COALESCE (adm.year, ado.year) AS year,
		COALESCE (adm.species, ado.species) AS species,
		adm.admitted_animals,
		ado.adopted_animals,
		-- Above 2 columns not needed for solution, leaving for clarity
		COALESCE (	SUM (admitted_animals)
					OVER W
				 , 0
				 )
		-
		COALESCE (	SUM (adopted_animals)
					OVER W
				 , 0
				 )
		AS number_of_animals_in_shelter
FROM 	annual_admitted_animals AS adm
		FULL OUTER JOIN 
		-- We need to accommodate years without adoptions and years without admissions
		-- If there was a year without either, then the number of animals remains the same
		annual_adopted_animals AS ado
			ON 	adm.species = ado.species
				AND
				adm.year = ado.year
WINDOW W AS ( PARTITION BY COALESCE (adm.species, ado.species)
			  ORDER BY COALESCE (adm.year, ado.year) ASC
			  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			  -- We can use either RANGE or ROWS since year is unique within a species partition, 
			  -- and the frame is unbounded preceding to current row
			 )
)
-- SELECT * FROM annual_number_of_shelter_species_animals ORDER BY species, year;
,annual_vaccinations
AS
(
SELECT	species,
		DATE_PART ('year', vaccination_time) AS year,
		COUNT (*) AS number_of_vaccinations
FROM 	vaccinations
GROUP BY 	species,
			DATE_PART ('year', vaccination_time)
)
-- SELECT * FROM annual_vaccinations ORDER BY species, year;
,annual_average_vaccinations_per_animal
AS
(
SELECT 	av.species,
		av.year,
		av.number_of_vaccinations,
		CAST ( 
				(number_of_vaccinations / number_of_animals_in_shelter) 
			 AS DECIMAL (5, 2)
			 ) AS average_vaccinations_per_animal
FROM 	annual_vaccinations AS av
		LEFT OUTER JOIN
		-- Requirements state we need to show only years where animals were vaccinated so a LEFT join is enough
		annual_number_of_shelter_species_animals AS an 
			ON 	an.species = av.species
				AND 
				an.YEAR = av.year
)
-- SELECT * FROM annual_average_vaccinations_per_animal ORDER BY species, year;
,annual_average_vaccinations_per_animal_with_previous_2_years_average
AS 
(
SELECT 	*,
		CAST ( AVG (average_vaccinations_per_animal) 
			   OVER ( PARTITION BY species
			   		  ORDER BY year ASC
					  RANGE BETWEEN 2 PRECEDING AND 1 PRECEDING 
						-- Watch out for frame type...
					 ) 
				AS DECIMAL (5, 2)
			)
		AS previous_2_years_average
FROM 	annual_average_vaccinations_per_animal
)
SELECT 	*,
		CAST ( (100 * average_vaccinations_per_animal / previous_2_years_average) 
			 AS DECIMAL (5, 2)
			 ) AS percent_change
FROM 	annual_average_vaccinations_per_animal_with_previous_2_years_average
ORDER BY 	species ASC,
			year ASC

