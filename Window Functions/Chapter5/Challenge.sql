-----------------------------------------
-- LinkedIn Learning --------------------
-- Advanced SQL - Window Functions ------
-- Ami Levin 2020 -----------------------
-- .\Code Files\Chapter5\Challenge.sql --
-----------------------------------------

/*
------------------------------------------
-- Animals temperature exception report --
------------------------------------------

Write a query that returns the top 25% of animals per species that had the fewest “temperature exceptions”.
Ignore animals that had no routine checkups.
A “temperature exception” is a checkup temperature measurement that is either equal to or exceeds +/- 0.5% from the specie's average.
If two or more animals of the same species have the same number of temperature exceptions, those with the more recent exceptions should be returned.
There is no need to return additional tied animals over the 25% mark.
If the number of animals for a species does not divide by 4 without remainder, you may return 1 more animal, but not less.

Hint: CAST averages to DECIMAL (5, 2).

Expected results sorted by species ASC, number_of_exceptions DESC, latest_exception DESC:
---------------------------------------------------------------------------------
|	species	|	name		|	number_of_exceptions	|	latest_exception	|
|-----------|---------------|---------------------------|-----------------------|
|	Cat		|	Cleo		|					1		|	2019-09-20 09:45:00	|
|	Cat		|	Cosmo		|					0		|				[NULL]	|
|	Cat		|	Kiki		|					0		|				[NULL]	|
|	Cat		|	Penny		|					0		|				[NULL]	|
|	Cat		|	Patches		|					0		|				[NULL]	|
|	Dog		|	Gizmo		|					1		|	2019-10-07 08:51:00	|
|	Dog		|	Riley		|					1		|	2019-07-25 10:48:00	|
|	Dog		|	Mocha		|					1		|	2019-05-14 11:10:00	|
|	Dog		|	Emma		|					1		|	2019-05-07 11:09:00	|
|	Dog		|	Samson		|					1		|	2019-03-27 09:04:00	|
|	Dog		|	Bailey		|					0		|				[NULL]	|
|	Dog		|	Luke		|					0		|				[NULL]	|
|	Dog		|	Benny		|					0		|				[NULL]	|
|	Dog		|	Boomer		|					0		|				[NULL]	|
|	Dog		|	Rusty		|					0		|				[NULL]	|
|	Dog		|	Millie		|					0		|				[NULL]	|
|	Dog		|	Beau		|					0		|				[NULL]	|
|	Rabbit	|	Humphrey	|					1		|	2018-12-19 08:32:00	|
|	Rabbit	|	April		|					0		|				[NULL]	|
---------------------------------------------------------------------------------
*/