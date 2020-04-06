-----------------------------------------
-- LinkedIn Learning --------------------
-- Advanced SQL - Window Functions ------
-- Ami Levin 2020 -----------------------
-- .\Code Files\Chapter7\Challenge.sql --
-----------------------------------------

/* 
---------------------------------------------------------------------------------------
-- Triple bonus points challenge - Annual average animal species vaccinations report --
---------------------------------------------------------------------------------------
-- !!! DISCLAIMER !!! This one is far from trivial, so be patient and careful. --------
---------------------------------------------------------------------------------------
Write a query that returns all years in which animals were vaccinated, and the total number of vaccinations given that year, per species.
In addition, the following three columns should be included in the results:
1. The average number of vaccinations per shelter animal of that species in that year.
2. The average number of vaccinations per shelter animal of that species in the previous 2 years.
3. The percent difference between columns 1 and 2 above.

----------------
-- Guidelines --
----------------

1. The average number of animals in any given year should take into account when animals were admitted, and when they were adopted.
To simplify the solution, it should be done on a yearly resolution.
This means that you should consider an animal that was admitted on any date as if it was admitted on January 1st of that year.
Similarly, consider an animal that was adopted on any date as if it was adopted on January 1st of that year.
For example - If in 2016, the first year, 10 cats and 5 dogs were admitted, and 2 cats and 2 dogs were adopted, consider the number of shelter animals for 2016 to be 8 cats, 3 dogs and 0 rabbits.
This carries over to the next year for which you will need to add admissions, subtract adoptions, and so on.
Of course, if you want to calculate this on a daily basis and only then average it out for the year, you are welcome to do so for extra bonus points.
My suggested solution does not.

2. Consider that there may be years without adoptions or without admissions for any species.
You may assume that there are no years without both adoptions and admissions for a species.
For my suggested solution it does not matter, but it may for others.

3. There may also be years without vaccinations for any species, but you are not required to show them.

Recommendation: Cast averages and expressions with division operators to DECIMAL (5, 2)
Expected result sorted by species ASC, year ASC:

--------------------------------------------------------------------------------------------------------------------------------------------
|	species	|	year	|	number_of_vaccinations	|	average_vaccinations_per_animal	|	previous_2_years_average	|	percent_change |
|-----------|-----------|---------------------------|-------------------------------------------------------------------|------------------|
|	Cat		|	2016	|					2		|							0.5		|					[NULL]		|		[NULL]     |
|	Cat		|	2017	|					7		|							0.78	|					0.5			|		156        |
|	Cat		|	2018	|					9		|							1.29	|					0.64		|		201.56     |
|	Cat		|	2019	|					10		|							1.25	|					1.04		|		120.19     |
|	Dog		|	2016	|					7		|							0.44	|					[NULL]		|		[NULL]     |
|	Dog		|	2017	|					15		|							0.56	|					0.44		|		127.27     |
|	Dog		|	2018	|					18		|							0.6		|					0.5			|		120        |
|	Dog		|	2019	|					17		|							0.85	|					0.58		|		146.55     |
|	Rabbit	|	2016	|					2		|							1		|					[NULL]		|		[NULL]     |
|	Rabbit	|	2017	|					1		|							0.2		|					1			|		20         |
|	Rabbit	|	2018	|					5		|							1		|					0.6			|		166.67     |
|	Rabbit	|	2019	|					2		|							1		|					0.6			|		166.67     |
--------------------------------------------------------------------------------------------------------------------------------------------

*/

