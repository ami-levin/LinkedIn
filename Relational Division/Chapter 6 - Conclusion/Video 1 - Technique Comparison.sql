--------------------------------------------------
-- LinkedIn Learning -----------------------------
-- Advanced SQL: Conquering Relational Division --
-- Ami Levin 2021 --------------------------------
-- Chapter 6 - Video 1 - Tecnique Comparison -----
--------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%206%20-%20Conclusion/Video%201%20-%20Technique%20Comparison.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=897d706832f68014e27e002c22305976&hide=1

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

---------
-- EOF --
---------