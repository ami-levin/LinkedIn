--------------------------------------------
-- LinkedIn Learning -----------------------
-- Advanced SQL - Query Processing Part 2 --
-- Ami Levin 2020 --------------------------
-- .\Chapter2\Challenge.sql ----------------
--------------------------------------------

-- GitHub
https://github.com/ami-levin/LinkedIn/tree/master/Query%20Processing%20Part%202/Chapter2%20-%20Advanced%20Joins/Challenge.sql

-- DBFiddle UK
/*SQL Server*/	https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=4d80f929838df26945e4c706b02dbeab
/*PostgreSQL*/	https://dbfiddle.uk/?rdbms=postgres_12&fiddle=28ba0ec7a95fd1c0bf8013d0bb5c6cde

/*
   ________          ____                    
  / ____/ /_  ____ _/ / /__  ____  ____ ____ 
 / /   / __ \/ __ `/ / / _ \/ __ \/ __ `/ _ \
/ /___/ / / / /_/ / / /  __/ / / / /_/ /  __/
\____/_/ /_/\__,_/_/_/\___/_/ /_/\__, /\___/ 
                                /____/       

Our shelter has been experiencing financial difficulties.
!!! PLEASE consider donating to your local animal shelter !!!
The board of directors decided to explore additional revenue sources and came up with an idea.
Instead of spaying and neutering all animals, the shelter should consider responsible breeding of purebred animals.
!!!	This is a hypothetical question – ALWAYS spay and neuter your pets !!! 

Your challenge is to figure out which animals are breeding candidates.

Expected result:

┌───────────┬───────────────┬───────────┬───────────┐
│Species	│Breed			│Male		│Female		│
├───────────┼───────────────┼───────────┼───────────┤
│Cat		│Sphynx			│Salem		│Nova		│
│Cat		│Turkish Angora	│Tigger		│Ivy		│
│Dog		│Bullmastiff	│Toby		│Penelope	│
│Dog		│Bullmastiff	│Toby		│Skye		│
│Dog		│Bullmastiff	│Jake		│Penelope	│
│Dog		│Bullmastiff	│Jake		│Skye       │
│Dog		│English setter	│Frankie	│Callie     │
│Dog		│English setter	│Frankie	│Nala       │
│Dog		│English setter	│Gus		│Callie     │
│Dog		│English setter	│Gus		│Nala       │
│Dog		│English setter	│Benji		│Callie     │
│Dog		│English setter	│Benji		│Nala       │
│Dog		│English setter	│Mac		│Callie     │
│Dog		│English setter	│Mac		│Nala       │
│Dog		│Schnauzer		│Boomer		│Emma       │
│Dog		│Schnauzer		│Boomer		│Lily       │
│Dog		│Schnauzer		│Brody		│Emma       │
│Dog		│Schnauzer		│Brody		│Lily       │
│Dog		│Weimaraner		│Brutus		│Lucy       │
│Dog		│Weimaraner		│Brutus		│Poppy      │
│Dog		│Weimaraner		│Brutus		│Roxy       │
│Dog		│Weimaraner		│Jax		│Lucy       │
│Dog		│Weimaraner		│Jax		│Poppy      │
│Dog		│Weimaraner		│Jax		│Roxy       │
└───────────┴───────────────┴───────────┴───────────┘    

Guidelines:

🢂 	Candidates should be male and female of the same species and breed.
🢂 	You may use any database you wish.
🢂 	Results are ordered by species and breed

   ______                __   __               __   __
  / ____/___  ____  ____/ /  / /   __  _______/ /__/ /
 / / __/ __ \/ __ \/ __  /  / /   / / / / ___/ //_/ / 
/ /_/ / /_/ / /_/ / /_/ /  / /___/ /_/ / /__/ ,< /_/  
\____/\____/\____/\__,_/  /_____/\__,_/\___/_/|_(_)   
                                                      
*/