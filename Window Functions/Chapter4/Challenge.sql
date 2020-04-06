-----------------------------------------
-- LinkedIn Learning --------------------
-- Advanced SQL - Window Functions ------
-- Ami Levin 2020 -----------------------
-- .\Code Files\Chapter4\Challenge.sql --
-----------------------------------------

/* 
----------------------------------------------------
-- Warm up challenge - Annual vaccinations report --
----------------------------------------------------

Write a query that returns all years in which animals were vaccinated, and the total number of vaccinations given that year.
In addition, the following two columns should be included in the results:
1. The average number of vaccinations given in the previous two years.
2. The percent difference between the current year's number of vaccinations, and the average of the previous two years.
For the first year, return a NULL for both additional columns.

Hint: Cast averages and division expressions to DECIMAL (5, 2)

Expected result sorted by year ASC:
---------------------------------------------------------------------------------------------
|	year	|	number_of_vaccinations	|	previous_2_years_average	|	percent_change	|
|-----------|---------------------------|-------------------------------|-------------------|
|	2,016	|					11		|					[NULL]		|		[NULL]		|
|	2,017	|					23		|					11.00		|		209.09		|
|	2,018	|					32		|					17.00		|		188.24		|
|	2,019	|					29		|					27.50		|		105.45		|
---------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------
-- Extra challenge: Try to find an alternative solution and post it in the Q&A section. ----------------------
-- Solutions that either perform better, are simpler, or highly creative, will receive an honorary mention. --
--------------------------------------------------------------------------------------------------------------
*/