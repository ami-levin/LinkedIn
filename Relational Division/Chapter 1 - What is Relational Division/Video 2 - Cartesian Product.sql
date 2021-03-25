----------------------------------------
-- LinkedIn Learning -------------------
-- Advanced SQL - Relational Division --
-- Ami Levin 2021 ----------------------
-- .\Chapter1\Video2.sql ---------------
----------------------------------------

CREATE TABLE TeamUSA
(
Player VARCHAR(30) NOT NULL PRIMARY KEY
);

CREATE TABLE TeamRussia
(
Shakhmatist VARCHAR(30) NOT NULL PRIMARY KEY
);

CREATE TABLE Matches
(
Player VARCHAR(30) NOT NULL,
Shakhmatist VARCHAR(30) NOT NULL,
PRIMARY KEY (Player, Shakhmatist)
);

INSERT INTO TeamUSA 
VALUES ('Bobby Fischer','Paul Morphy');

INSERT INTO TeamRussia 
VALUES ('Garry Kasparov','Mikhail Tal');

INSERT INTO Matches (Player, Shakhmatist)
SELECT 	Player, Shakhmatist
FROM 	TeamUSA 
		CROSS JOIN
		TeamRussia;

