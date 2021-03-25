----------------------------------------
-- LinkedIn Learning -------------------
-- Advanced SQL - Relational Division --
-- Ami Levin 2021 ----------------------
-- .\Chapter5\Video4.sql ---------------
----------------------------------------

USE HR;
GO

-- Show all candidate and Roles, where the candidate meets the Role requirements and only those.
-- Using aggregation
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
HAVING	COUNT(CS.Skill) = MAX(RSC.RoleSkillCount) -- Dummy MAX aggregate
        AND
        COUNT(CS.Skill) = MAX(CSC.CandidateSkillCount);

-- Using SET operator
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


-- Using nested subqueries
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
 -- Exact division
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
							 
