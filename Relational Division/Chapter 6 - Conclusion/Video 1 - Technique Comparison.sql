----------------------------------------
-- LinkedIn Learning -------------------
-- Advanced SQL - Relational Division --
-- Ami Levin 2021 ----------------------
-- .\Chapter6\Video1.sql ---------------
----------------------------------------

-- Find candidates that qualify or 'nearly qualify' for the DB Architect role
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
HAVING COUNT(*) >= (SELECT COUNT(*) - 1 FROM DBArchitectSkills);

-- Find candidates who are an exact match, or just 'slightly over-qualified' for any role
WITH RoleSkillCounts AS
(
	SELECT	R.Role, 
			COUNT(RS.Skill) AS RoleSkillCount
	FROM	Roles AS R 
			LEFT OUTER JOIN 
			RoleSkills AS RS
			ON R.Role = RS.Role
	GROUP BY R.Role
),
CandidateSkillCount
AS
(
	SELECT 	C.Candidate, 
			COUNT(CS.Skill) AS CandidateSkillCount
	FROM 	Candidates AS C 
			LEFT OUTER JOIN 
			CandidateSkills AS CS 
			ON C.Candidate = CS.Candidate
	GROUP BY C.Candidate
)
SELECT	C.Candidate, R.Role
FROM	(	
			Candidates AS C
			CROSS JOIN 
			Roles AS R
			INNER JOIN
			RoleSkillCounts AS RSC
				ON RSC.Role = R.Role
			INNER JOIN 
			CandidateSkillCount AS CSC 
			ON CSC.Candidate = C.Candidate
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
HAVING	COUNT(CS.Skill) = MAX(RSC.RoleSkillCount) -- Dummy MAX aggregate
        AND
        COUNT(CS.Skill) + 1 >= MAX(CSC.CandidateSkillCount);
