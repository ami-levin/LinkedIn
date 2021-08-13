----------------------------------------
-- LinkedIn Learning -------------------
-- Advanced SQL - Interpolation --------
-- Ami Levin, August 2021 --------------
-- Chapter 1 - Video 2 - Formula 1 DB --
----------------------------------------
USE Master;
GO

CREATE DATABASE Formula1;
GO

USE Formula1;
GO

--Sensors
CREATE TABLE TemperatureSensors
(Sensor	VARCHAR(10) NOT NULL PRIMARY KEY);

INSERT INTO	TemperatureSensors (Sensor)
VALUES  ('Oil'), ('Coolant'), ('Intake');

--Temperatures
CREATE TABLE Temperatures
(
	Sensor		VARCHAR(10) 	NOT NULL,
	Time		DATETIME 		NOT NULL,
	Temperature	DECIMAL(5,2)	NOT NULL,
	PRIMARY KEY (Sensor,Time),
	FOREIGN KEY (Sensor)
		REFERENCES TemperatureSensors(Sensor)
);

INSERT INTO Temperatures (Sensor, Time, Temperature)
VALUES	('Oil', 	'20210101 18:01:00', 102.00),
		('Oil', 	'20210101 18:03:00', 124.00),
		('Oil', 	'20210101 18:11:00', 133.00),
		('Oil', 	'20210101 18:19:00', 121.00), 
		('Oil', 	'20210101 18:38:00', 80.00), 
		('Coolant', '20210101 18:01:00', 93.00),
		('Coolant', '20210101 18:04:00', 122.00),
		('Coolant', '20210101 18:10:00', 104.00),
 		('Intake', 	'20210101 18:09:00', 85.00), 
		('Intake', 	'20210101 18:18:00', 79.00), 	
		('Intake', 	'20210101 18:21:00', 90.00);

SELECT	* 
FROM	Temperatures;
GO


---------
-- EOF --
---------