----------------------------------------------------
-- LinkedIn Learning -------------------------------
-- Advanced SQL: Conquering Relational Division ----
-- Ami Levin 2021 ----------------------------------
-- Chapter 5 - Video 3 - Exact Division Challenge --
----------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%205%20-%20Multidivisors%20and%20zero%20divisions/Video%203%20-%20Multiple%20Divisors%20Exact%20Relational%20Division%20Challenge.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=365c1c3f801562631696c915568890b5&hide=1

-- These queries find candidates that are a fit any role, including zero divisions, using all 3 techniques:
-- Aggregation
WITH RoleSkillCounts AS
(
	SELECT	R.Role, COUNT(RS.Skill) AS RoleSkillCount
	FROM	Roles AS R 
			LEFT OUTER JOIN 
			RoleSkills AS RS
				ON R.Role = RS.Role
	GROUP BY R.Role
)
SELECT	C.Candidate, R.Role --, COUNT(*) AS CountStar, COUNT(CS.Skill) AS CandidateSkillCount, MAX(RSC.RoleSkillCount) AS RoleSkillCount
FROM	(	
			Candidates AS C
			CROSS JOIN 
			Roles AS R
			INNER JOIN
			RoleSkillCounts AS RSC
				ON RSC.Role = R.Role
		)
		LEFT OUTER JOIN
		(
			CandidateSkills AS CS
			INNER JOIN 
			RoleSkills AS RS
				ON 	RS.Skill = CS.Skill
		)
			ON 	C.Candidate = CS.Candidate
				AND 
				R.Role = RS.Role 
GROUP BY C.Candidate, R.Role
HAVING	COUNT(CS.Skill) = MAX(RSC.RoleSkillCount) -- Dummy MAX aggregate, sorry...
ORDER BY C.Candidate, R.Role;

-- Set operators
SELECT	C.Candidate, R.Role
FROM	Candidates AS C
		CROSS JOIN		
		Roles AS R
WHERE	NOT EXISTS	(
						SELECT	RS.Skill
						FROM	RoleSkills AS RS
						WHERE	RS.Role = R.Role
						EXCEPT
						SELECT	CS.Skill
						FROM	CandidateSkills AS CS
						WHERE	C.Candidate = CS.Candidate
					);

-- Nested subqueries
SELECT 	C.Candidate, R.Role
FROM 	Candidates AS C
        CROSS JOIN 
        Roles AS R
WHERE 	NOT EXISTS	(
						SELECT 	NULL 
						FROM 	RoleSkills AS RS 
						WHERE 	RS.Role = R.Role
								AND 
								NOT EXISTS (
												SELECT 	NULL
												FROM 	CandidateSkills AS CS
												WHERE 	CS.Skill = RS.Skill
														AND 
														CS.Candidate = C.Candidate
											)
					);


/*
Your challenge is to modify these queries so that candidates with a remainder will be eliminated. 
#EliminateDarrin #EliminateAllOverqualified

For each query, use only the same technique as the existing relational division one.

Hints:
🢂 An exact relational division is just a standard relational division, with an additional constraint on top.
🢂 Copy the exact division solutions from previous chapters, and use them as your starting point.
🢂 Identify the divisor...

Expected Result:
┌───────────┬───────────────────────┐
│Candidate	│	Role				│
├───────────┼───────────────────────┤
│Chen		│	DB Architect		│
├───────────┼───────────────────────┤
│Incompetent│	Mischief Officer	│
└───────────┴───────────────────────┘
*/

---------
-- EOF --
---------