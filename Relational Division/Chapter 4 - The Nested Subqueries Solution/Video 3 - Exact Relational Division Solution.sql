---------------------------------------------------
-- LinkedIn Learning ------------------------------
-- Advanced SQL: Conquering Relational Division ---
-- Ami Levin 2021 ---------------------------------
-- Chapter 4 - Video 2 - Exact Division Solution --
---------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%204%20-%20The%20Nested%20Subqueries%20Solution/Video%203%20-%20Exact%20Relational%20Division%20Solution.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=ad920e71a2556574b411b552c64e3831&hide=1

-- Exact Division #EliminateDarrin
SELECT 	C.Candidate
FROM 	Candidates AS C
WHERE 	NOT EXISTS	(
						SELECT 	NULL 
						FROM 	RoleSkills AS RS 
						WHERE 	RS.Role = 'DB Architect'
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
                                                FROM 	RoleSkills AS RS2 
                                                WHERE 	RS2.Role = 'DB Architect'
                                                        AND 
                                                        RS2.Skill = CS2.Skill 
                                            )
                    );

-- Prettifacation
WITH DBArchitectSkill AS 
(
	SELECT 	RS.SKill
	FROM 	RoleSkills AS RS 
	WHERE 	Role = 'DB Architect'
)
SELECT 	C.Candidate
FROM 	Candidates AS C
WHERE 	NOT EXISTS	(
						SELECT 	NULL 
						FROM 	DBArchitectSkill as DBS
						WHERE 	
								NOT EXISTS (
												SELECT 	NULL
												FROM 	CandidateSkills AS CS
												WHERE 	CS.Skill = DBS.Skill
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
                                                FROM 	DBArchitectSkill AS DBS2 
                                                WHERE   CS2.Skill = DBS2.Skill
                                            )
                    );


----------------------------------------------------------
-- Bonus Challenge: Who has the same skills as Natasha? --
----------------------------------------------------------
-- SPOILER ALERT: Solution below! ------------------------
----------------------------------------------------------
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
--
-- "Find all candidates (except for Natasha), for which there isn't a skill that Natasha has, that they don't have as well."
SELECT	C.Candidate
FROM	Candidates AS C
WHERE	Candidate <> 'Natasha'
		AND
		NOT EXISTS	(
						SELECT	NULL
						FROM	CandidateSkills AS NS -- NS for "Natasha's Skills"
						WHERE	Candidate = 'Natasha'
								AND	
								NOT EXISTS	(
												SELECT	NULL
												FROM	CandidateSkills AS CS
												WHERE	CS.Skill = NS.Skill		
														AND
														CS.Candidate = C.Candidate
											)	
					);
					
---------
-- EOF --
---------