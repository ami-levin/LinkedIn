--------------------------------------------------
-- LinkedIn Learning -----------------------------
-- Advanced SQL: Conquering Relational Division --
-- Ami Levin 2021 --------------------------------
-- Chapter 4 - Video 1 - Nested Subqueries -------
--------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%204%20-%20The%20Nested%20Subqueries%20Solution/Video%201%20-%20Relational%20Division%20Using%20Nested%20Subqueries.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=e3c8989748a46ae886b6c36b159c29f6&hide=1

USE HR;
GO

-- Candidats that have all skills
SELECT 	C.Candidate
FROM 	Candidates AS C
WHERE 	NOT EXISTS (
						SELECT 	NULL
						FROM 	Skills AS S
						WHERE 	NOT EXISTS 	(
												SELECT 	NULL
                                                FROM    CandidateSkills AS CS
                                                WHERE   CS.Candidate = C.Candidate	
												        AND						
                                                        CS.Skill = S.Skill	
                                            )
                    );		

-- Candidates that fit the DB Architect role
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
												WHERE 	CS.Candidate = C.Candidate
														AND 
														CS.Skill = RS.Skill
											)
					);

-- What skills do all candidates possess?
SELECT 	S.Skill
FROM 	Skills AS S
WHERE 	NOT EXISTS 	(
						SELECT	NULL 
						FROM 	Candidates AS C
						WHERE 	NOT EXISTS	(
												SELECT	NULL 
												FROM 	CandidateSkills AS CS 
												WHERE 	CS.Candidate = C.Candidate
														AND 
														CS.Skill = S.Skill
											)
					);

-- What personal skills are required by all roles?
SELECT 	S.Skill 
FROM 	Skills AS S 
WHERE 	S.Category = 'Personal'
		AND 
		NOT EXISTS 	(
						SELECT 	NULL 
						FROM 	Roles AS R 
						WHERE 	NOT EXISTS 	(
												SELECT 	NULL 
												FROM 	RoleSkills AS RS 
												WHERE 	RS.Role = R.Role
														AND 
														RS.Skill = S.Skill
											)
					);

-- Which candidates have no professional skills?
SELECT 	C.Candidate
FROM 	Candidates AS C 
WHERE 	NOT EXISTS 	(
						SELECT 	NULL 
						FROM 	Skills AS S
						WHERE 	S.Category = 'Professional'
								AND 
								EXISTS 	(
											SELECT 	NULL 
											FROM 	CandidateSkills AS CS 
											WHERE 	CS.Candidate = C.Candidate
													AND 
													CS.Skill = S.Skill
										)
					);

---------
-- EOF --
---------