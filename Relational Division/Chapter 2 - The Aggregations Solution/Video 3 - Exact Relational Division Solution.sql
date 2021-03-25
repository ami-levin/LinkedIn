----------------------------------------
-- LinkedIn Learning -------------------
-- Advanced SQL - Relational Division --
-- Ami Levin 2021 ----------------------
-- .\Chapter2\Video4.sql ---------------
----------------------------------------

-- Exact relational division
USE HR;

WITH DBArchitectSkills
AS
(
	SELECT	RS.Skill
	FROM	RoleSkills AS RS
	WHERE	RS.Role = 'DB Architect'
)
SELECT	CS.Candidate -- , COUNT(*) AS TotalSkills, COUNT(DBS.Skill) AS RequiredSkills
FROM	CandidateSkills AS CS
		LEFT OUTER JOIN
		DBArchitectSkills AS DBS
		ON DBS.Skill = CS.Skill
GROUP BY CS.Candidate
HAVING	COUNT(DBS.Skill) = (SELECT COUNT(*) FROM DBArchitectSkills)
		AND
		COUNT(*) = COUNT(DBS.Skill);
