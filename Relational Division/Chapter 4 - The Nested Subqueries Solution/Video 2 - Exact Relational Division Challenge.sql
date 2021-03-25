----------------------------------------------------
-- LinkedIn Learning -------------------------------
-- Advanced SQL: Conquering Relational Division ----
-- Ami Levin 2021 ----------------------------------
-- Chapter 4 - Video 2 - Exact Division Challenge --
----------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%204%20-%20The%20Nested%20Subqueries%20Solution/Video%202%20-%20Exact%20Relational%20Division%20Challenge.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=a8eaf669d1318ce5eab7933a1e08bc5d&hide=1

-- This query finds candidates that fit the DB Architect Role:
SELECT 	C.Candidate
FROM 	Candidates AS C
WHERE 	NOT EXISTS	(
						SELECT 	NULL 
						FROM 	RoleSkills AS RS 
						WHERE 	RS.Role = 'DB Architect'
								AND 
								NOT EXISTS (
												SELECT 	NULL
												FROM 	CandidateSkills AS CS
												WHERE 	CS.Candidate = C.Candidate
														AND 
														CS.Skill = RS.Skill
											)
					);
/*
Your challenge is to modify this query so that candidates with a remainder will be eliminated. 
To put it nicely, I don’t want to see Darrin, or any other candidate who has more than the required skills.
#EliminateDarrin
You are not allowed to use aggregates or set operators. Only nested subqueries this time.

Hints:
🢂 An exact relational division is just a standard relational division, with an additional constraint on top.
🢂 A simplification may help; First try to figure out if Praveens has any 'redundant' skills, and then generalize for all candidates.

Expected Result:
┌───────────┐
│Candidate	│
├───────────┤
│Chen 		│
└───────────┘
*/

---------
-- EOF --
---------