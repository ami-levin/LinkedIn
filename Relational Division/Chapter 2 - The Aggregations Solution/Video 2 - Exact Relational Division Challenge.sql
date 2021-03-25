----------------------------------------------------
-- LinkedIn Learning -------------------------------
-- Advanced SQL: Conquering Relational Division ----
-- Ami Levin 2021 ----------------------------------
-- Chapter 2 - Video 2 - Exact Division Challenge --
----------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%202%20-%20The%20Aggregations%20Solution/Video%202%20-%20Exact%20Relational%20Division%20Challenge.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=e3c2d988396091e4fe37307f0c787880&hide=1

-- This query matches candidates for the DB Architect role:
WITH DBArchitectSkills 
AS
(
	SELECT	RS.Skill
	FROM	RoleSkills AS RS
	WHERE	RS.Role = 'DB Architect'
)
SELECT	CS.Candidate
FROM	CandidateSkills AS CS
		INNER JOIN
		DBArchitectSkills AS DBS
			ON DBS.Skill = CS.Skill
GROUP BY CS.Candidate
HAVING COUNT(*) = (SELECT COUNT(*) FROM DBArchitectSkills);

/* 
You need to modify it so that dividends with remainders are eliminated.
To put it nicely, I don’t want to see Darrin in the result. 
He has more skills than what the role requires.
#EliminateDarrin

Hints:
🢂 An exact relational division is just a standard relational division, with an additional constraint sprinkled on top.
🢂 There was a good reason that I used a JOIN instead an IN predicate.

Expected Result:
┌───────────┐
│Candidate	│
├───────────┤
│Chen 		│
└───────────┘

Good luck!
*/

---------
-- EOF --
---------