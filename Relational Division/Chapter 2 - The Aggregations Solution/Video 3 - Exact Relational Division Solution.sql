---------------------------------------------------
-- LinkedIn Learning ------------------------------
-- Advanced SQL: Conquering Relational Division ---
-- Ami Levin 2021 ---------------------------------
-- Chapter 2 - Video 3 - Exact Division Solution --
---------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%202%20-%20The%20Aggregations%20Solution/Video%203%20-%20Exact%20Relational%20Division%20Solution.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=1346eebc91288d3a23efdc8a09800e3e&hide=1

-- Exact relational division Solution
WITH DBArchitectSkills
AS
(
	SELECT	RS.Skill
	FROM	RoleSkills AS RS
	WHERE	RS.Role = 'DB Architect'
)
SELECT	CS.Candidate --, COUNT(*) AS TotalSkills, COUNT(DBS.Skill) AS RequiredSkills
FROM	CandidateSkills AS CS
		LEFT OUTER JOIN
		DBArchitectSkills AS DBS
		ON DBS.Skill = CS.Skill
GROUP BY CS.Candidate
HAVING	COUNT(DBS.Skill) = (SELECT COUNT(*) FROM DBArchitectSkills)
		AND
		COUNT(*) = COUNT(DBS.Skill);
		
---------
-- EOF --
---------