---------------------------------------------------
-- LinkedIn Learning ------------------------------
-- Advanced SQL: Conquering Relational Division ---
-- Ami Levin 2021 ---------------------------------
-- Chapter 5 - Video 4 - Exact Division Solution --
---------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%205%20-%20Multidivisors%20and%20zero%20divisions/Video%204%20-%20Multiple%20Divisors%20Exact%20Relational%20Division%20Solution.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=faada7cb5413950597b2c387dd15d03d&hide=1

-- Aggregations
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
CandidateSkillCount AS
(
	SELECT 	C.Candidate, 
			COUNT(CS.Skill) AS CandidateSkillCount
	FROM 	Candidates AS C 
			LEFT OUTER JOIN 
			CandidateSkills AS CS 
			ON C.Candidate = CS.Candidate
	GROUP BY C.Candidate
)
SELECT	C.Candidate, R.Role -- , COUNT(*) AS CountStar, COUNT(CS.Skill) AS CandidateSkillCount, MAX(RSC.RoleSkillCount) AS RoleSkillCount
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
HAVING	COUNT(CS.Skill) = MAX(RSC.RoleSkillCount) -- Dummy MAX aggregate, sorry...
        AND
        COUNT(CS.Skill) = MAX(CSC.CandidateSkillCount);-- Dummy MAX aggregate, sorry...

-- Set operators
SELECT	C.Candidate, R.Role
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
					)
		AND 
		NOT EXISTS	(
						SELECT	CS1.Skill
						FROM	CandidateSkills AS CS1
						WHERE	CS1.Candidate = C.Candidate
						EXCEPT
						SELECT	RS1.Skill
						FROM	RoleSkills AS RS1
						WHERE	RS1.Role = R.Role
					);


-- Nested subqueries
SELECT 	C.Candidate, R.Role
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
					)
		AND 
        NOT EXISTS (
                        SELECT  NULL 
                        FROM    CandidateSkills AS CS2
                        WHERE   CS2.Candidate = C.Candidate
                                AND 
                                NOT EXISTS  (
                                                SELECT 	NULL 
                                                FROM 	RoleSkills AS RS 
                                                WHERE 	RS.Role = R.Role
                                                        AND 
                                                        CS2.Skill = RS.Skill
                                            )
                    );
							 
---------
-- EOF --
---------