--------------------------------------------------
-- LinkedIn Learning -----------------------------
-- Advanced SQL: Conquering Relational Division --
-- Ami Levin 2021 --------------------------------
-- Chapter 1 - Video 2 - Cartesian Product -------
--------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%201%20-%20What%20is%20Relational%20Division/Video%202%20-%20Cartesian%20Product.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=40ab944f586b8fe9c6f702b962980eb2

-- Fictional Chess Tournament
CREATE TABLE TeamUSA (Player VARCHAR(30) NOT NULL PRIMARY KEY);

CREATE TABLE TeamRussia (Shakhmatist VARCHAR(30) NOT NULL PRIMARY KEY);

CREATE TABLE Matches
(	Player VARCHAR(30) NOT NULL,
	Shakhmatist VARCHAR(30) NOT NULL,
	PRIMARY KEY (Player, Shakhmatist)
);

INSERT INTO TeamUSA VALUES ('Bobby Fischer'),('Paul Morphy');

INSERT INTO TeamRussia VALUES ('Garry Kasparov'),('Mikhail Tal');

INSERT INTO Matches (Player, Shakhmatist)
SELECT 	Player, Shakhmatist
FROM 	TeamUSA CROSS JOIN TeamRussia;

SELECT * FROM TeamUSA;
SELECT * FROM TeamRussia;
SELECT * FROM Matches; 

---------
-- EOF --
---------