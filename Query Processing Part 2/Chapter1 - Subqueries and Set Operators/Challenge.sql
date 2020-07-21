--------------------------------------------
-- LinkedIn Learning -----------------------
-- Advanced SQL - Query Processing Part 2 --
-- Ami Levin 2020 --------------------------
-- .\Chapter1\Challenge.sql ----------------
--------------------------------------------

-- GitHub
https://github.com/ami-levin/LinkedIn/tree/master/Query%20Processing%20Part%202/Chapter1%20-%20Subqueries%20and%20Set%20Operators/Challenge.sql

-- DBFiddle UK
/*SQL Server*/	https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=495930b53b038b6a79e527b4f5763118
/*PostgreSQL*/	https://dbfiddle.uk/?rdbms=postgres_12&fiddle=495930b53b038b6a79e527b4f5763118

/*
   ________          ____                    
  / ____/ /_  ____ _/ / /__  ____  ____ ____ 
 / /   / __ \/ __ `/ / / _ \/ __ \/ __ `/ _ \
/ /___/ / / / /_/ / / /  __/ / / / /_/ /  __/
\____/_/ /_/\__,_/_/_/\___/_/ /_/\__, /\___/ 
                                /____/       

Write a query to show which breeds were never adopted.

Expected results:

┌───────────┬───────────────┐
│Species	│Breed			│
├───────────┼───────────────┤
│Cat		│Turkish Angora	│
└───────────┴───────────────┘

Guidelines:

🢂 	Breeds that were never adopted are not the same logical question as animals that were never adopted.
	Breed is not an identifier of an animal.
	Breed may be NULL.
🢂	We have non-breed dogs and non-breed cats so remember to consider species. Breed alone isn’t enough.
🢂	Try the techniques we used to find animals that were never adopted: OUTER JOIN, NOT IN, and NOT EXISTS. 
	See if they work or not and why.
	You will find these queries in \Chapter1\Video2.sql

   ______                __   __               __   __
  / ____/___  ____  ____/ /  / /   __  _______/ /__/ /
 / / __/ __ \/ __ \/ __  /  / /   / / / / ___/ //_/ / 
/ /_/ / /_/ / /_/ / /_/ /  / /___/ /_/ / /__/ ,< /_/  
\____/\____/\____/\__,_/  /_____/\__,_/\___/_/|_(_)   
                                                      
*/