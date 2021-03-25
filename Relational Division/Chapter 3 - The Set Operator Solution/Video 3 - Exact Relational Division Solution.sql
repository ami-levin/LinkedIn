----------------------------------------
-- LinkedIn Learning -------------------
-- Advanced SQL - Relational Division --
-- Ami Levin 2021 ----------------------
-- .\Chapter3\Video4.sql ---------------
----------------------------------------

USE HR;
GO

-- Does Praveena have any additional skills not required for the DB Architect role?

SELECT	CS.Skill
FROM	CandidateSkills AS CS
WHERE	CS.Candidate = 'Praveena'
EXCEPT
SELECT	RS.Skill
FROM	RoleSkills AS RS
WHERE	RS.Role = 'DB Architect';

-- Exact relational division

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
					)
		AND 
		NOT EXISTS	(
						SELECT	CS1.Skill
						FROM	CandidateSkills AS CS1
						WHERE	CS1.Candidate = C.Candidate
						EXCEPT
						SELECT	RS1.Skill
						FROM	RoleSkills AS RS1
						WHERE	RS1.Role = 'DB Architect'
						);
