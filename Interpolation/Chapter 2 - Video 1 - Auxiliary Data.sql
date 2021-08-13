------------------------------------------
-- LinkedIn Learning ---------------------
-- Advanced SQL - Interpolation ----------
-- Ami Levin, August 2021 ----------------
-- Chapter 2 - Video 1 - Auxiliary Data --
------------------------------------------
USE Formula1;
GO

CREATE SCHEMA Auxiliary;
GO

-- Auxiliary.Numbers Table
https://sqlperformance.com/2021/01/t-sql-queries/number-series-solutions-1

CREATE TABLE Auxiliary.Numbers
(Number INT NOT NULL PRIMARY KEY);
GO

-- Populate Auxiliary.Numbers
WITH
  Level0   AS	(SELECT 1 AS constant UNION ALL SELECT 1),
  Level1   AS	(SELECT 1 AS constant FROM Level0 AS A CROSS JOIN Level0 AS B),
  Level2   AS	(SELECT 1 AS constant FROM Level1 AS A CROSS JOIN Level1 AS B),
  Level3   AS	(SELECT 1 AS constant FROM Level2 AS A CROSS JOIN Level2 AS B),
  Level4   AS	(SELECT 1 AS constant FROM Level3 AS A CROSS JOIN Level3 AS B),
  SequentialNumbers AS(SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS Number FROM Level4)
INSERT INTO Auxiliary.Numbers (Number)
SELECT	Number 
FROM	SequentialNumbers;
GO

--Auxiliary.Calendar Table
CREATE TABLE Auxiliary.Calendar
(
	Date		DATE 		NOT NULL PRIMARY KEY,
	Year		INT 		NOT NULL,
    Quarter     INT         NOT NULL,
	Month		INT 		NOT NULL,
	MonthName	VARCHAR(10) NOT NULL,
	Day			INT 		NOT NULL,
	DayName		VARCHAR(10) NOT NULL,
	DayOfYear	INT 		NOT NULL,
	Weekday		VARCHAR(10) NOT NULL,
	YearWeek	INT 		NOT NULL,
	--US Federal Holiday	VARCHAR(50) NULL,
	--Other Holiday		VARCHAR(50) NULL
);
GO

-- PopulateAuxiliary.Calendar
DECLARE @BaseDate DATE = CAST('20200101' AS DATE);
INSERT INTO Auxiliary.Calendar (Date, Year, Quarter, Month, MonthName, Day, DayName, DayOfYear, Weekday, YearWeek) 
SELECT	DATEADD(DAY, Number-1, @BaseDate),
		YEAR(DATEADD(DAY, Number-1, @BaseDate)),
        DATEPART(QUARTER, (DATEADD(DAY, Number-1, @BaseDate))),
		MONTH(DATEADD(DAY, Number-1, @BaseDate)),
		DATENAME(MONTH, (DATEADD(DAY, Number-1, @BaseDate))),
		DAY((DATEADD(DAY, Number-1, @BaseDate))),
		DATENAME(WEEKDAY, (DATEADD(DAY, Number-1, @BaseDate))),
		DATEPART(DAYOFYEAR, (DATEADD(DAY, Number-1, @BaseDate))),
		DATEPART(WEEKDAY, (DATEADD(DAY, Number-1, @BaseDate))),
		DATEPART(WEEK, (DATEADD(DAY, Number-1, @BaseDate)))
FROM	Auxiliary.Numbers
WHERE	Number <= 3650;
GO

SELECT  * 
FROM    Auxiliary.Calendar 
ORDER BY Date ASC;
GO






---------
-- EOF --
---------