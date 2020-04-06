-----------------------------------------
-- LinkedIn Learning --------------------
-- Advanced SQL - Window Functions ------
-- Ami Levin 2020 -----------------------
-- .\Code Files\Chapter6\Challenge.sql --
-----------------------------------------

/*
------------------------------------
-- Top improved adoption quarters --
------------------------------------

Write a query that returns the top 5 most improved quarters in terms of the number of adoptions, both per species, and overall.
Improvement means the increase in number of adoptions compared to the previous calendar quarter.
The first quarter in which animals were adopted for each species and for all species, does not constitute an improvement from zero, and should be treated as no improvement.
In case there are quarters that are tied in terms of adoption improvement, return the most recent ones.

Hint: Quarters can be identified by their first day.

Expected results sorted by species ASC, adoption_difference_from_previous_quarter DESC and quarter_start ASC:
---------------------------------------------------------------------------------------------------------------------
|	species			|	year	|	quarter	|	adoption_difference_from_previous_quarter	|	quarterly_adoptions	|
|-------------------|-----------|-----------|-----------------------------------------------|-----------------------|
|	All species		|	2019	|		3	|										7		|				11		|
|	All species		|	2018	|		2	|										4		|				8		|
|	All species		|	2019	|		4	|										3		|				14		|
|	All species		|	2017	|		3	|										2		|				3		|
|	All species		|	2018	|		1	|										2		|				4		|
|	Cat				|	2019	|		4	|										4		|				6		|
|	Cat				|	2018	|		3	|										2		|				3		|
|	Cat				|	2019	|		2	|										2		|				2		|
|	Cat				|	2018	|		1	|										1		|				2		|
|	Cat				|	2019	|		3	|										0		|				2		|
|	Dog				|	2019	|		3	|										7		|				8		|
|	Dog				|	2018	|		2	|										4		|				6		|
|	Dog				|	2017	|		3	|										2		|				2		|
|	Dog				|	2018	|		1	|										2		|				2		|
|	Dog				|	2019	|		1	|										1		|				4		|
|	Rabbit			|	2019	|		1	|										2		|				2		|
|	Rabbit			|	2017	|		4	|										1		|				1		|
|	Rabbit			|	2018	|		2	|										1		|				1		|
|	Rabbit			|	2019	|		4	|										1		|				2		|
|	Rabbit			|	2019	|		3	|										0		|				1		|
---------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
------------------------ Extra challenge: !BUG HUNT! -------------------------------
-- Check the alternative solution at the bottom of the solution file for details. --
------------------------------------------------------------------------------------

*/