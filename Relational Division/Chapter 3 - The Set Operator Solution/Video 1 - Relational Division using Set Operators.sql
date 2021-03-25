--------------------------------------------------
-- LinkedIn Learning -----------------------------
-- Advanced SQL: Conquering Relational Division --
-- Ami Levin 2021 --------------------------------
-- Chapter 3 - Video 1 - Set Operators -----------
--------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%203%20-%20The%20Set%20Operator%20Solution/Video%201%20-%20Relational%20Division%20using%20Set%20Operators.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=e53098635c902de85ad6e369e078a67d&hide=1

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

---------
-- EOF --
---------