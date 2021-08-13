--------------------------------------------------
-- LinkedIn Learning -----------------------------
-- Advanced SQL - Interpolation ------------------
-- Ami Levin, August 2021 ------------------------
-- Chapter 3 - Video 2 - Proximal Interpolation --
--------------------------------------------------
USE Formula1;
GO

SELECT	*,
        NULL AS PreviousKnownTemperature,
        NULL AS PreviousKnownTime,
        NULL AS NextKnownTemperature,
        NULL AS NextKnownTime
FROM	MinuteTemperatures
ORDER BY Sensor ASC, Time ASC;
GO

-- Simplified data set

CREATE OR ALTER VIEW CoolantMinuteTemperatures
AS
SELECT 	Time, 
        Temperature
FROM 	MinuteTemperatures
WHERE   Sensor = 'Coolant';
GO

SELECT  * 
FROM    CoolantMinuteTemperatures
ORDER BY Time ASC;
GO

SELECT  *, 
        LEAD(Temperature /*IGNORE NULLS*/) OVER (ORDER BY Time ASC) AS JustNext
FROM    CoolantMinuteTemperatures
ORDER BY Time ASC;
GO

SELECT  *, 
        CASE
            WHEN Time = '2021-01-01 18:01' THEN 'A'
            WHEN Time BETWEEN '2021-01-01 18:02' AND '2021-01-01 18:04' THEN 'B'
            ELSE 'C'
        END AS Grouper
FROM    CoolantMinuteTemperatures
ORDER BY Time ASC;
GO

WITH AddGrouper
AS
(
SELECT  *, 
        CASE
            WHEN Time = '2021-01-01 18:01' THEN 'A'
            WHEN Time BETWEEN '2021-01-01 18:02' AND '2021-01-01 18:04' THEN 'B'
            ELSE 'C'
        END AS Grouper
FROM    CoolantMinuteTemperatures
)
SELECT  *,
        MAX(Temperature) OVER (PARTITION BY Grouper) AS NextKnownTemperature
FROM    AddGrouper
ORDER BY Time ASC;
GO

WITH AddGrouper
AS
(
SELECT  *, 
        COUNT(Temperature) OVER (ORDER BY Time ASC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
        AS Grouper
FROM    CoolantMinuteTemperatures
)
SELECT  *,
        MAX(Temperature) OVER (PARTITION BY Grouper) AS NextKnownTemperature
FROM    AddGrouper
ORDER BY Time ASC;
GO

-- Add PreviousKnownTemperature 

WITH BothPreviousAndNextKnownCoolantTemperatures
AS
(
SELECT  *, 
        COUNT(Temperature) OVER (ORDER BY Time ASC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
        AS NextGrouper,
        COUNT(Temperature) OVER (ORDER BY Time ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS PreviousGrouper 
FROM    CoolantMinuteTemperatures
)
SELECT  *,
        MAX(Temperature) OVER (PARTITION BY NextGrouper) AS NextKnownTemperature,
        MAX(Temperature) OVER (PARTITION BY PreviousGrouper) AS PreviousKnownTemperature
FROM    BothPreviousAndNextKnownCoolantTemperatures
ORDER BY Time ASC;
GO

CREATE OR ALTER VIEW CoolantTemperaturesWithPreviousAndNextKnownOnesWithposition
AS
WITH PreviousAndNextKnownTemperatures
AS
(
SELECT  *, 
        COUNT(Temperature) OVER (ORDER BY Time ASC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
        AS NextGrouper,
        COUNT(Temperature) OVER (ORDER BY Time ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS PreviousGrouper 
FROM    CoolantMinuteTemperatures
)
SELECT  *,
        MAX(Temperature) OVER (PARTITION BY NextGrouper) AS NextKnownTemperature,
        MAX(Temperature) OVER (PARTITION BY PreviousGrouper) AS PreviousKnownTemperature,
        ROW_NUMBER() OVER (PARTITION BY NextGrouper ORDER BY Time ASC ) AS PositionInNextGroup
FROM    PreviousAndNextKnownTemperatures;
GO

SELECT  * 
FROM    CoolantTemperaturesWithPreviousAndNextKnownOnesWithposition
ORDER BY Time ASC;
GO

SELECT  Time, 
        CASE 
            WHEN Temperature IS NOT NULL THEN Temperature
            WHEN PositionInNextGroup > (MAX(PositionInNextGroup) OVER (PARTITION BY NextGrouper) / 2)
                THEN NextKnownTemperature
            ELSE PreviousKnownTemperature
        END AS Temperature,
        CASE 
            WHEN Temperature IS NOT NULL THEN 'Real'
            ELSE 'Interpolated'
        END AS InterpolatedOrReal 
FROM    CoolantTemperaturesWithPreviousAndNextKnownOnesWithposition
ORDER BY Time ASC;
GO

---------
-- EOF --
---------