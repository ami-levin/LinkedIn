--------------------------------------------
-- LinkedIn Learning -----------------------
-- Advanced SQL - Query Processing Part 2 --
-- Ami Levin 2020 --------------------------
-- .\Chapter3\Challenge.sql ----------------
--------------------------------------------

-- GitHub
https://github.com/ami-levin/LinkedIn/tree/master/Query%20Processing%20Part%202/Chapter3%20-%20More%20on%20Grouping/Challenge.sql

-- DBFiddle UK
/*SQL Server*/	https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=ff5780541829f07ad26b4afd5fdc3a85
/*PostgreSQL*/	https://dbfiddle.uk/?rdbms=postgres_12&fiddle=a3bbb61d21adf12d24192d557a23ca30

/*
   ________          ____                    
  / ____/ /_  ____ _/ / /__  ____  ____ ____ 
 / /   / __ \/ __ `/ / / _ \/ __ \/ __ `/ _ \
/ /___/ / / / /_/ / / /  __/ / / / /_/ /  __/
\____/_/ /_/\__,_/_/_/\___/_/ /_/\__, /\___/ 
                                /____/       

Your last challenge is to write a query that returns a statistical report of vaccinations.
The report should include the total number of vaccinations for several dimensions:
🢂 Annual
🢂 Per species
🢂 For each species per year
🢂 By each staff member
🢂 By each staff member per species
And to make it interesting, let’s throw in the latest vaccination year for each of these groups.

Expected results:

┌───────────┬───────────────┬───────────────────────────────────┬───────────┬───────────┬───────────────────────┬───────────────────────┐
│Year		│Species		│Email								│First_Name	│Last_Name	│Number_Of_Vaccinations	│Latest_Vaccination_Year│
├───────────┼───────────────┼───────────────────────────────────┼───────────┼───────────┼───────────────────────┼───────────────────────┤
│2016		│All Species	│All Staff							│			│			│11						│2016					│
│2016		│Cat			│All Staff							│			│			│2						│2016					│
│2016		│Dog			│All Staff							│			│			│7						│2016					│
│2016		│Rabbit			│All Staff							│			│			│2						│2016					│
│2017		│All Species	│All Staff							│			│			│23						│2017					│
│2017		│Cat			│All Staff							│			│			│7						│2017					│
│2017		│Dog			│All Staff							│			│			│15						│2017					│
│2017		│Rabbit			│All Staff							│			│			│1						│2017					│
│2018		│All Species	│All Staff							│			│			│32						│2018					│
│2018		│Cat			│All Staff							│			│			│9						│2018					│
│2018		│Dog			│All Staff							│			│			│18						│2018					│
│2018		│Rabbit			│All Staff							│			│			│5						│2018					│
│2019		│All Species	│All Staff							│			│			│29						│2019					│
│2019		│Cat			│All Staff							│			│			│10						│2019					│
│2019		│Dog			│All Staff							│			│			│17						│2019					│
│2019		│Rabbit			│All Staff							│			│			│2						│2019					│
│All Years	│All Species	│All Staff							│			│			│95						│2019					│
│All Years	│All Species	│ashley.flores@animalshelter.com	│Ashley		│Flores		│34						│2019					│
│All Years	│All Species	│dennis.hill@animalshelter.com		│Dennis		│Hill		│5						│2019					│
│All Years	│All Species	│gerald.reyes@animalshelter.com		│Gerald		│Reyes		│10						│2019					│
│All Years	│All Species	│robin.murphy@animalshelter.com		│Robin		│Murphy		│11						│2019					│
│All Years	│All Species	│wanda.myers@animalshelter.com		│Wanda		│Myers		│28						│2019					│
│All Years	│All Species	│wayne.carter@animalshelter.com		│Wayne		│Carter		│7						│2019					│
│All Years	│Cat			│All Staff							│			│			│28						│2019					│
│All Years	│Cat			│ashley.flores@animalshelter.com	│Ashley		│Flores		│10						│2018					│
│All Years	│Cat			│dennis.hill@animalshelter.com		│Dennis		│Hill		│2						│2019					│
│All Years	│Cat			│gerald.reyes@animalshelter.com		│Gerald		│Reyes		│4						│2019					│
│All Years	│Cat			│robin.murphy@animalshelter.com		│Robin		│Murphy		│2						│2019					│
│All Years	│Cat			│wanda.myers@animalshelter.com		│Wanda		│Myers		│9						│2019					│
│All Years	│Cat			│wayne.carter@animalshelter.com		│Wayne		│Carter		│1						│2019					│
│All Years	│Dog			│All Staff							│			│			│57						│2019					│
│All Years	│Dog			│ashley.flores@animalshelter.com	│Ashley		│Flores		│23						│2019					│
│All Years	│Dog			│dennis.hill@animalshelter.com		│Dennis		│Hill		│2						│2019					│
│All Years	│Dog			│gerald.reyes@animalshelter.com		│Gerald		│Reyes		│3						│2019					│
│All Years	│Dog			│robin.murphy@animalshelter.com		│Robin		│Murphy		│7						│2019					│
│All Years	│Dog			│wanda.myers@animalshelter.com		│Wanda		│Myers		│16						│2019					│
│All Years	│Dog			│wayne.carter@animalshelter.com		│Wayne		│Carter		│6						│2019					│
│All Years	│Rabbit			│All Staff							│			│			│10						│2019					│
│All Years	│Rabbit			│ashley.flores@animalshelter.com	│Ashley		│Flores		│1						│2019					│
│All Years	│Rabbit			│dennis.hill@animalshelter.com		│Dennis		│Hill		│1						│2018					│
│All Years	│Rabbit			│gerald.reyes@animalshelter.com		│Gerald		│Reyes		│3						│2019					│
│All Years	│Rabbit			│robin.murphy@animalshelter.com		│Robin		│Murphy		│2						│2018					│
│All Years	│Rabbit			│wanda.myers@animalshelter.com		│Wanda		│Myers		│3						│2017					│
└───────────┴───────────────┴───────────────────────────────────┴───────────┴───────────┴───────────────────────┴───────────────────────┘

Guidelines:

🢂 	ORDER BY Year, Species, First_Name, Last_Name and be careful with the order by aliases...

   ______                __   __               __   __
  / ____/___  ____  ____/ /  / /   __  _______/ /__/ /
 / / __/ __ \/ __ \/ __  /  / /   / / / / ___/ //_/ / 
/ /_/ / /_/ / /_/ / /_/ /  / /___/ /_/ / /__/ ,< /_/  
\____/\____/\____/\__,_/  /_____/\__,_/\___/_/|_(_)   
                                                      
*/