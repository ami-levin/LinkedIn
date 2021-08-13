------------------------------------
-- LinkedIn Learning ---------------
-- Advanced SQL - Interpolation ----
-- Ami Levin, August 2021 ----------
-- Chapter 3 - Video 4 - Solution --
------------------------------------
USE Formula1;
GO

CREATE OR ALTER VIEW TemperaturesWithPreviousAndNextKnownOnesWithposition
AS
WITH PreviousAndNextKnownTemperatures
AS
(
SELECT  *, 
        COUNT(Temperature) OVER (PARTITION BY Sensor ORDER BY Time ASC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
        AS NextGrouper,
        COUNT(Temperature) OVER (PARTITION BY Sensor ORDER BY Time ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS PreviousGrouper 
FROM    MinuteTemperatures
)
SELECT  *,
        MAX(Temperature) OVER (PARTITION BY Sensor, NextGrouper) AS NextKnownTemperature,
        MAX(Temperature) OVER (PARTITION BY Sensor, PreviousGrouper) AS PreviousKnownTemperature,
        ROW_NUMBER() OVER (PARTITION BY Sensor, NextGrouper ORDER BY Time ASC ) AS PositionInNextGroup
FROM    PreviousAndNextKnownTemperatures;
-- ORDER BY Sensor, Time ASC;
GO

SELECT  * 
FROM    TemperaturesWithPreviousAndNextKnownOnesWithposition
ORDER BY Time ASC;
GO

SELECT  Sensor,
        Time, 
        CASE 
            WHEN Temperature IS NOT NULL THEN Temperature
            WHEN PositionInNextGroup > (MAX(PositionInNextGroup) OVER (PARTITION BY Sensor, NextGrouper) / 2)
                THEN NextKnownTemperature
            ELSE PreviousKnownTemperature
        END AS Temperature,
        CASE 
            WHEN Temperature IS NOT NULL THEN 'Real'
            ELSE 'Interpolated'
        END AS InterpolatedOrReal 
FROM    TemperaturesWithPreviousAndNextKnownOnesWithposition
ORDER BY Sensor ASC, Time ASC;
GO



---------
-- EOF --
---------