----------------------------------------
-- LinkedIn Learning -------------------
-- Advanced SQL - Relational Division --
-- Ami Levin 2021 ----------------------
-- .\Chapter4\Video2.sql ---------------
----------------------------------------

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
