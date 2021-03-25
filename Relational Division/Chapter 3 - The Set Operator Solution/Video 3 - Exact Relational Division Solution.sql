---------------------------------------------------
-- LinkedIn Learning ------------------------------
-- Advanced SQL: Conquering Relational Division ---
-- Ami Levin 2021 ---------------------------------
-- Chapter 3 - Video 3 - Exact Division Solution --
---------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%203%20-%20The%20Set%20Operator%20Solution/Video%203%20-%20Exact%20Relational%20Division%20Solution.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=8d82ad5d337fca5ce2203c6a1d9cd1f7&hide=1

-- Simplifaction: Does Praveena have any additional skills not required for the DB Architect role?
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
