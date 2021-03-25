--------------------------------------------------
-- LinkedIn Learning -----------------------------
-- Advanced SQL: Conquering Relational Division --
-- Ami Levin 2021 --------------------------------
-- Chapter 1 - Video 3 - Relational Division -----
--------------------------------------------------
-- https://github.com/ami-levin/LinkedIn/blob/master/Relational%20Division/Chapter%201%20-%20What%20is%20Relational%20Division/Video%203%20-%20Relational%20Division.sql
-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=0c1a79affa1dc75f1435fc91d963110c

-- See previous video code file for the original tables and data.
INSERT INTO Matches (Player, Shakhmatist)
VALUES 	('Wesly So','Garry Kasparov'), 
		('Bobby Fischer','Anatoly Karpov');
		
SELECT 	* FROM Matches;

-- Can you find all USA players who have played ALL Russian Shakhmatists?
-- Go ahead! Give it a try! It's not a rhetorical question!

---------
-- EOF --
---------