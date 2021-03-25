----------------------------------------
-- LinkedIn Learning -------------------
-- Advanced SQL - Relational Division --
-- Ami Levin 2021 ----------------------
-- .\Chapter3\Video2.sql ---------------
----------------------------------------

USE HR;
GO

-- Simplifaction: Does Praveena have all skills?

SELECT	S.Skill
FROM	Skills AS S
EXCEPT
SELECT	CS.Skill
FROM	CandidateSkills AS CS
WHERE	CS.Candidate = 'Praveena';

-- All candidates

SELECT	C.Candidate
FROM	Candidates AS C;

-- Candidates that have all skills 

SELECT	C.Candidate
FROM	Candidates AS C
WHERE	NOT EXISTS	(
						SELECT	S.Skill
						FROM	Skills AS S
						EXCEPT
						SELECT	CS.Skill
						FROM	CandidateSkills AS CS
						WHERE	CS.Candidate = C.Candidate
					);

-- Candidates that fit the DB Architect Role

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
