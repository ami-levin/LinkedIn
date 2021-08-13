---------------------------------------
-- LinkedIn Learning ------------------
-- Advanced SQL - Interpolation -------
-- Ami Levin, August 2021 -------------
-- Chapter 2 - Video 2 - Methodology --
---------------------------------------
USE Formula1;
GO

-- Temperatures

SELECT 	*
FROM 	Temperatures
ORDER BY Sensor ASC, Time ASC;

-- Hours

CREATE TABLE Auxiliary.Hours
(Hour INT NOT NULL PRIMARY KEY);
GO

INSERT INTO Auxiliary.Hours (Hour) 
SELECT 	Number - 1 -- zero offset
FROM 	Auxiliary.Numbers 
WHERE 	Number <= 24;
GO

SELECT 	* 
FROM 	Auxiliary.Hours;
GO

-- Minutes

CREATE TABLE Auxiliary.Minutes 
(Minute INT NOT NULL PRIMARY KEY);
GO

INSERT INTO Auxiliary.Minutes(Minute) 
SELECT 	Number - 1 -- zero offset
FROM 	Auxiliary.Numbers
WHERE 	Number <= 60;
GO

SELECT 	* 
FROM 	Auxiliary.Minutes;
GO

CREATE OR ALTER VIEW Auxiliary.CalendarHours
AS
	SELECT 	DATEADD(Hour, H.Hour, CAST(C.Date AS DATETIME)) AS Time
	FROM 	Auxiliary.Calendar AS C 
			CROSS JOIN 
			Auxiliary.Hours AS H;
GO

SELECT 	* 
FROM 	Auxiliary.CalendarHours
ORDER BY Time ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY;

CREATE OR ALTER VIEW Auxiliary.CalendarMinutes
AS
SELECT 	DATEADD(Minute, M.Minute, CH.Time) AS Time
FROM 	Auxiliary.CalendarHours AS CH
		CROSS JOIN 
		Auxiliary.Minutes AS M;
GO

SELECT 	*
FROM 	Auxiliary.CalendarMinutes
ORDER BY Time ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY;

SELECT  * 
FROM    Auxiliary.CalendarMinutes AS CM
        CROSS JOIN 
        Temperatures AS T;
GO

SELECT  * 
FROM    Auxiliary.CalendarMinutes AS CM
        CROSS JOIN 
        Temperatures AS T
WHERE   T.Time <> CM.Time;
GO

CREATE OR ALTER VIEW SensorsTimeRanges
AS	
	SELECT	Sensor, 
			MIN(Time) AS EarliestTime,
			MAX(Time) AS LatestTime
	FROM	Temperatures
	GROUP BY Sensor;	
GO

SELECT 	* 
FROM 	SensorsTimeRanges;
GO

CREATE OR ALTER VIEW SequentialMinuteTimeRanges
AS
	SELECT 	CM.Time, STR.Sensor
	FROM 	Auxiliary.CalendarMinutes AS CM
			CROSS JOIN
			SensorsTimeRanges AS STR
	WHERE	CM.Time BETWEEN STR.EarliestTime AND STR.LatestTime;
GO

SELECT 	* 
FROM 	SequentialMinuteTimeRanges 
ORDER BY Sensor ASC, Time ASC;
GO

SELECT  *
FROM    SequentialMinuteTimeRanges AS SMTR 
        LEFT OUTER JOIN 
        Temperatures AS T 
        ON  T.Sensor = SMTR.Sensor
            AND   
            T.Time = SMTR.Time
ORDER BY SMTR.Sensor, SMTR.Time;
GO

INSERT INTO Temperatures(Sensor, Time, Temperature)
VALUES ('Coolant', '20210101 18:01:02.000', 103);
GO

SELECT  *
FROM    SequentialMinuteTimeRanges AS SMTR 
        LEFT OUTER JOIN 
        Temperatures AS T 
        ON  T.Sensor = SMTR.Sensor
            AND   
            T.Time = SMTR.Time
ORDER BY SMTR.Sensor, SMTR.Time;
GO

SELECT 	* 
FROM 	Temperatures 
WHERE 	Sensor = 'Coolant'
ORDER BY Time ASC;
GO

SELECT	Sensor,
        DATETIMEFROMPARTS
		(	DATEPART(YEAR, Time),
            DATEPART(MONTH, Time),
            DATEPART(DAY, Time),
            DATEPART(HOUR, Time),
            DATEPART(MINUTE, Time)
            ,0,0) AS Time,
        Temperature
FROM	Temperatures
ORDER BY Sensor ASC, Time ASC;
GO

CREATE VIEW StandardizedTimeTemperatures
AS 
WITH RoundedMinutes AS
(SELECT	Sensor,
        DATETIMEFROMPARTS(	DATEPART(YEAR, Time),
                            DATEPART(MONTH, Time),
                            DATEPART(DAY, Time),
                            DATEPART(HOUR, Time),
                            DATEPART(MINUTE, Time)
                            ,0,0
        ) AS RoundedMinuteTime,
        Temperature
FROM	Temperatures
)
SELECT  Sensor,
        RoundedMinuteTime AS Time,
        AVG(Temperature) AS Temperature
FROM    RoundedMinutes
GROUP BY	Sensor,
            RoundedMinuteTime;
GO

SELECT 	* 
FROM 	StandardizedTimeTemperatures 
ORDER BY Sensor ASC, Time ASC;
GO

SELECT	SMTR.Sensor,
		SMTR.Time,
		STT.Temperature
FROM	SequentialMinuteTimeRanges AS SMTR 	 
        LEFT OUTER JOIN
	    StandardizedTimeTemperatures AS STT
		ON	SMTR.Sensor = STT.Sensor
			AND
			SMTR.Time = STT.Time
ORDER BY SMTR.Sensor, SMTR.Time; 

CREATE OR ALTER VIEW MinuteTemperatures
AS
SELECT	SMTR.Sensor,
		SMTR.Time,
		STT.Temperature
FROM	SequentialMinuteTimeRanges AS SMTR 	 
        LEFT OUTER JOIN
	    StandardizedTimeTemperatures AS STT
		ON	SMTR.Sensor = STT.Sensor
			AND
			SMTR.Time = STT.Time; 
GO

SELECT	* 
FROM	MinuteTemperatures
ORDER BY	Sensor ASC,	Time ASC;
GO


https://www.youtube.com/watch?v=2JM2oImb9Qg
https://docs.microsoft.com/en-us/sql/t-sql/functions/datetimefromparts-transact-sql

---------
-- EOF --
---------