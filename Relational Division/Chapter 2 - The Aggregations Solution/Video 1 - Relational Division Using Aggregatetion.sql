--------------------------------------------------
-- LinkedIn Learning -----------------------------
-- Advanced SQL: Conquering Relational Division --
-- Ami Levin 2021 --------------------------------
-- Chapter 2 - Video 1 - Aggregations ------------
--------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%202%20-%20The%20Aggregations%20Solution/Video%201%20-%20Aggregations.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=7b99f7467c391b40cfef5f478ef421b2&hide=1

USE HR;
GO

-- Does Praveena have all skills?
SELECT	COUNT(*) AS TotalSkills
FROM	Skills AS S
GROUP BY ();

SELECT	COUNT(*) AS PraveenaSkills
FROM	CandidateSkills AS CS
WHERE	CS.Candidate = 'Praveena'
GROUP BY CS.Candidate;

-- Candidates that have all skills 
SELECT 	CS.Candidate -- ,COUNT(*)
FROM 	CandidateSkills AS CS
GROUP BY CS.Candidate
HAVING COUNT(*) = 	(	
						SELECT 	COUNT(*)
						FROM 	Skills
						GROUP BY ()
					);

-- Candidates that fit the DB Architect role.
SELECT 	CS.Candidate
FROM 	CandidateSkills AS CS
WHERE 	CS.Skill IN (SELECT RS.Skill FROM RoleSkills AS RS WHERE RS.Role = 'DB Architect')
GROUP BY CS.Candidate
HAVING 	COUNT(*)  = (	
						SELECT 	COUNT(*)
						FROM 	RoleSkills AS RS1
						WHERE 	RS1.Role = 'DB Architect'
						GROUP BY RS1.Role
					);

-- Encapsulate repeating subquery
WITH DBArchitectSkills 
AS
(
	SELECT	RS.Skill
	FROM	RoleSkills AS RS
	WHERE	RS.Role = 'DB Architect'
)
SELECT	CS.Candidate
FROM	CandidateSkills AS CS
WHERE 	CS.Skill IN (SELECT DBS.Skill FROM DBArchitectSkills AS DBS)
GROUP BY CS.Candidate
HAVING COUNT(*) = (SELECT COUNT(*) FROM DBArchitectSkills);

-- Use a JOIN instead of IN
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

---------
-- EOF --
---------