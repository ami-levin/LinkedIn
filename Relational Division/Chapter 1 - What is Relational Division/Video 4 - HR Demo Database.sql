----------------------------------------
-- LinkedIn Learning -------------------
-- Advanced SQL - Relational Division --
-- Ami Levin 2021 ----------------------
----------------------------------------

-- SQL Server
-- Scroll down for a PostgreSQL version.

-------------------------------------------------
-- HR Demo Database Setup -----------------------
-------------------------------------------------

USE master
GO
DROP DATABASE IF EXISTS HR;
CREATE DATABASE HR;
GO

USE HR;
GO

CREATE TABLE Candidates (
						Candidate 
							VARCHAR(30) NOT NULL 
							PRIMARY KEY
						);

CREATE TABLE Roles	(
					Role 
						VARCHAR(30) NOT NULL
						PRIMARY KEY
					);

CREATE TABLE SkillCategories	(
								Category
									VARCHAR(30) NOT NULL
									PRIMARY KEY
								);

CREATE TABLE Skills	(
					Skill
						VARCHAR(30) NOT NULL
						PRIMARY KEY,
					Category
						VARCHAR(30) NOT NULL
						REFERENCES SkillCategories(Category)
					);

CREATE TABLE CandidateSkills	(
								Candidate
									VARCHAR(30) NOT NULL
									REFERENCES Candidates(Candidate),
								Skill
									VARCHAR(30) NOT NULL
									REFERENCES Skills(Skill),
								PRIMARY KEY (Candidate, Skill)
								);

CREATE TABLE RoleSkills	(
						Role
							VARCHAR(30) NOT NULL
							REFERENCES Roles(Role),
						Skill
							VARCHAR(30) NOT NULL
							REFERENCES Skills(Skill),
						PRIMARY KEY (Role, Skill)
						);

INSERT INTO Candidates(Candidate)
VALUES ('Natasha'),('Chen'),('Praveena'),('Kelly'), ('Darrin');

INSERT INTO Roles(Role)
VALUES ('DB Architect'), ('Front End Developer'), ('Office Manager');

INSERT INTO SkillCategories(Category)
VALUES ('Professional'), ('Personal');

INSERT INTO Skills(Skill, Category)
VALUES	('SQL','Professional'), ('DB Design','Professional'), ('C#','Professional'), ('Python','Professional'), ('Java','Professional'), ('Office','Professional'),
		('Team Player','Personal'), ('Leader','Personal'), ('Passionate','Personal');

INSERT INTO RoleSkills(Role, Skill)
VALUES	('DB Architect','SQL'), ('DB Architect','DB Design'), ('DB Architect','Python'), ('DB Architect','Team Player'), ('DB Architect','Passionate'),
		('Front End Developer','Java'), ('Front End Developer','C#'), ('Front End Developer','Team Player'), ('Front End Developer','Passionate'),
		('Office Manager','Passionate'), ('Office Manager','Team Player'), ('Office Manager','Office');
		-- Team player skill required for all roles

INSERT INTO CandidateSkills(Candidate, Skill)
VALUES	('Natasha','SQL'), ('Natasha','DB Design'), ('Natasha','Team Player'), ('Natasha','Passionate'), 
		-- Partial match for DB Architect professional, match for personal skills
		('Chen','SQL'), ('Chen','DB Design'), ('Chen','Python'), ('Chen','Team Player'), ('Chen','Passionate'), 
		-- Perfect match for DB Architect
		('Praveena','Java'), ('Praveena','C#'), ('Praveena','Team Player'), ('Praveena','Passionate'), ('Praveena','Python'), 
		-- Over qualified for Front End Developer (has extra skills)
		('Kelly','Passionate'), ('Kelly','Leader'), 
		-- No professional skills
		('Darrin','SQL'), ('Darrin','DB Design'), ('Darrin','C#'), ('Darrin','Python'), ('Darrin','Java'), ('Darrin','Office'), ('Darrin','Team Player'), ('Darrin','Leader'), ('Darrin','Passionate'); 
		-- Darrin Has it all
		-- And of course, all candidates are passionate...

SELECT	*
FROM	Skills;

SELECT	*
FROM	CandidateSkills;

SELECT	* 
FROM	RoleSkills;


/*  ------ Cleanup -----
DROP TABLE CandidateSkills, RoleSkills;
DROP TABLE Skills, Roles;
DROP TABLE SkillCategories, Candidates;
GO
*/