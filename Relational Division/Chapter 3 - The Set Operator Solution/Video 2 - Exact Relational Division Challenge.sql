----------------------------------------------------
-- LinkedIn Learning -------------------------------
-- Advanced SQL: Conquering Relational Division ----
-- Ami Levin 2021 ----------------------------------
-- Chapter 3 - Video 2 - Exact Division Challenge --
----------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%203%20-%20The%20Set%20Operator%20Solution/Video%202%20-%20Exact%20Relational%20Division%20Challenge.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=df1698e5f5b62db7a555102560dab3e0&hide=1

-- This query finds candidates that fit the DB Architect Role:
SELECT	C.Candidate
FROM	Candidates AS C
WHERE	NOT EXISTS	(
						SELECT	RS.Skill 
						FROM	RoleSkills AS RS
						WHERE	RS.Role = 'DB Architect'
						EXCEPT
						SELECT	CS.Skill
						FROM	CandidateSkills AS CS
						WHERE	CS.Candidate = C.Candidate
					);
/*
Your challenge is to modify this query so that candidates with a remainder will be eliminated. 
To put it nicely, I don’t want to see Darrin, or any other candidate who has more than the required skills.
#EliminateDarrin
You are not allowed to use aggregates. Only set operators this time.

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