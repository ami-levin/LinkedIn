--------------------------------------------------
-- LinkedIn Learning -----------------------------
-- Advanced SQL: Conquering Relational Division --
-- Ami Levin 2021 --------------------------------
-- Chapter 5 - Video 2 - Zero Divisions ----------
--------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%205%20-%20Multidivisors%20and%20zero%20divisions/Video%202%20-%20Zero%20Divisions.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=47a6f3af8839422e6416c4af92679476&hide=1

-- DB Fiddle preloaded with the original set operators and nested subqueries multidivisor solutions:
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=b2d137754475dd37465755ea992c3e7f&hide=1

USE HR;
GO

-- Add a role with no skill requirements
INSERT INTO Roles (Role) VALUES ('Mischief Officer');

-- Add a candidate with no skills
INSERT INTO Candidates(Candidate) VALUES ('Incompetent');

-- Using aggregates
/* Original query for multiple divisors

WITH RoleSkillCounts AS
(
	SELECT	RS.Role, 
			COUNT(*) AS RoleSkillCount
	FROM	RoleSkills AS RS
	GROUP BY RS.Role
)
SELECT	CS.Candidate, RS.Role
FROM	CandidateSkills AS CS
		INNER JOIN 
		RoleSkills AS RS 
		ON RS.skill = CS.Skill
		INNER JOIN 
		RoleSkillCounts AS RSC 
		ON RS.Role = RSC.Role
GROUP BY CS.Candidate, RS.Role
HAVING COUNT(*) = (MAX(RoleSkillCount)); -- Dummy MAX aggregate, sorry...
*/

-- Step 1
WITH RoleSkillCounts AS
(
	SELECT	RS.Role, 
			COUNT(*) AS RoleSkillCount
	FROM	RoleSkills AS RS
	GROUP BY RS.Role
)
SELECT	CS.Candidate, RS.Role
FROM	(
			Candidates AS C 
			CROSS JOIN 
			Roles AS R
		)
		LEFT OUTER JOIN
		(
			CandidateSkills AS CS
			INNER JOIN 
			RoleSkills AS RS 
			ON RS.skill = CS.Skill
			INNER JOIN 
			RoleSkillCounts AS RSC 
			ON RS.Role = RSC.Role
		) 
		ON 	C.Candidate = CS.Candidate
			AND 
			R.Role = RS.Role;

-- GROUP BY CS.Candidate, RS.Role
-- HAVING COUNT(*) = (MAX(RoleSkillCount)); -- Dummy MAX aggregate, sorry...

-- Step 2
WITH RoleSkillCounts AS
(
	SELECT	RS.Role, 
			COUNT(*) AS RoleSkillCount
	FROM	RoleSkills AS RS
	GROUP BY RS.Role
)
SELECT	C.Candidate, R.Role
FROM	(
			Candidates AS C 
			CROSS JOIN 
			Roles AS R
		)
		LEFT OUTER JOIN
		(
			CandidateSkills AS CS
			INNER JOIN 
			RoleSkills AS RS 
			ON RS.skill = CS.Skill
			INNER JOIN 
			RoleSkillCounts AS RSC 
			ON RS.Role = RSC.Role
		) 
		ON 	C.Candidate = CS.Candidate
			AND 
			R.Role = RS.Role
GROUP BY C.Candidate, R.Role;
-- HAVING COUNT(*) = (MAX(RoleSkillCount)); -- Dummy MAX aggregate, sorry...

-- Step 3
WITH RoleSkillCounts AS
(
	SELECT	R.Role, 
			COUNT(RS.Skill) AS RoleSkillCount
	FROM	Roles AS R 
			LEFT OUTER JOIN 
			RoleSkills AS RS
			ON R.Role = RS.Role
	GROUP BY R.Role
)
SELECT	C.Candidate, R.Role, COUNT(*) AS CountStar, MAX(RoleSkillCount) AS RoleSkillCount
FROM	(
			Candidates AS C 
			CROSS JOIN 
			Roles AS R
			INNER JOIN 
			RoleSkillCounts AS RSC 
			ON R.Role = RSC.Role
		)
		LEFT OUTER JOIN
		(
			CandidateSkills AS CS
			INNER JOIN 
			RoleSkills AS RS 
			ON RS.skill = CS.Skill
		) 
		ON 	C.Candidate = CS.Candidate
			AND 
			R.Role = RS.Role
GROUP BY C.Candidate, R.Role;
-- HAVING COUNT(*) = (MAX(RoleSkillCount)); -- Dummy MAX aggregate, sorry...

-- Step 4
WITH RoleSkillCounts AS
(
	SELECT	R.Role, 
			COUNT(RS.Skill) AS RoleSkillCount
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
SELECT	C.Candidate, 
		R.Role
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
SELECT 	C.Candidate, 
		R.Role
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

---------
-- EOF --
---------