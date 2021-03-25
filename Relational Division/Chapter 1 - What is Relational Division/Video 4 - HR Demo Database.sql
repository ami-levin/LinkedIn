--------------------------------------------------
-- LinkedIn Learning -----------------------------
-- Advanced SQL: Conquering Relational Division --
-- Ami Levin 2021 --------------------------------
-- Chapter 1 - Video 4 - HR Demo Database --------
--------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%201%20-%20What%20is%20Relational%20Division/Video%204%20-%20HR%20Demo%20Database.sql

-- DB Fiddle Preloaded with HR Demo Database: 
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=06f6f880236311c73861876be59dc087&hide=1

-- HR Demo Database GitHub Folder: 
-- https://github.com/ami-levin/LinkedIn/tree/master/Relational%20Division/HR%20Demo%20Database

-- Joe Celko on keys and identifiers:
-- https://www.informationweek.com/software/information-management/celko-on-sql-identifiers-and-the-properties-of-relational-keys/d/d-id/1058284?

-- Fabian Pascal on relational keys:
-- https://www.dbdebunk.com/2018/02/the-key-to-relational-keys-new.html

-----------------------------------------
-- HR Demo Database Setup (SQL Server) --
-----------------------------------------

USE master;
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
		-- Team player and passionate skills are required for all roles

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

-- Cleanup
/*
-- Drop Tables
DROP TABLE CandidateSkills, RoleSkills;
DROP TABLE Skills, Roles;
DROP TABLE SkillCategories, Candidates;
GO
-- Drop Database
USE Master;
GO
DROP DATABASE HR;
GO
*/

---------
-- EOF --
---------