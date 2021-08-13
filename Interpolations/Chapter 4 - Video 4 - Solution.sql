------------------------------------
-- LinkedIn Learning ---------------
-- Advanced SQL - Interpolation ----
-- Ami Levin, August 2021 ----------
-- Chapter 4 - Video 4 - Solution --
------------------------------------
USE Formula1;
GO

WITH CoolantTemperaturesWithGroupers
AS
(
SELECT	*,
        MIN(CASE 
                WHEN Temperature IS NOT NULL 
                    THEN Time 
                ELSE NULL
            END) 
        OVER (ORDER BY Time ASC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
        AS NextGrouper,
        MAX(CASE 
                WHEN Temperature IS NOT NULL 
                    THEN Time 
                ELSE NULL
            END) 
        OVER (ORDER BY Time ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS PreviousGrouper
FROM	CoolantMinuteTemperatures AS CMT
)
SELECT  *,
        MAX(CTWG.Temperature)
		OVER	(PARTITION BY  CTWG.NextGrouper) AS NextKnownTemperature,
        MAX(CTWG.Temperature)
		OVER	(PARTITION BY  CTWG.PreviousGrouper) AS PreviousKnownTemperature
FROM    CoolantTemperaturesWithGroupers AS CTWG
ORDER BY CTWG.Time;
GO

WITH TemperaturesWithGroupers
AS
(
SELECT	*,
        MIN(CASE 
                WHEN Temperature IS NOT NULL 
                    THEN Time 
                ELSE NULL
            END) 
        OVER (PARTITION BY Sensor ORDER BY Time ASC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
        AS NextGrouper,
        MAX(CASE 
                WHEN Temperature IS NOT NULL 
                    THEN Time 
                ELSE NULL
            END) 
        OVER (PARTITION BY Sensor ORDER BY Time ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS PreviousGrouper
FROM	MinuteTemperatures AS MT
)
SELECT  *,
        MAX(TWG.Temperature)
		OVER	(PARTITION BY  TWG.Sensor, TWG.NextGrouper) AS NextKnownTemperature,
        MAX(TWG.Temperature)
		OVER	(PARTITION BY  TWG.Sensor, TWG.PreviousGrouper) AS PreviousKnownTemperature
FROM    TemperaturesWithGroupers AS TWG
ORDER BY TWG.Sensor, TWG.Time;
GO

CREATE OR ALTER VIEW TemperaturesWithPreviousAndNextKnownOnes
AS
WITH TemperaturesWithGroupers
AS
(
SELECT	*,
        MIN(CASE 
                WHEN Temperature IS NOT NULL 
                    THEN Time 
                ELSE NULL
            END) 
        OVER (PARTITION BY Sensor ORDER BY Time ASC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
        AS NextGrouper,
        MAX(CASE 
                WHEN Temperature IS NOT NULL 
                    THEN Time 
                ELSE NULL
            END) 
        OVER (PARTITION BY Sensor ORDER BY Time ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS PreviousGrouper
FROM	MinuteTemperatures AS MT
)
SELECT  *,
        MAX(TWG.Temperature)
		OVER	(PARTITION BY  TWG.Sensor, TWG.NextGrouper) AS NextKnownTemperature,
        MAX(TWG.Temperature)
		OVER	(PARTITION BY  TWG.Sensor, TWG.PreviousGrouper) AS PreviousKnownTemperature
FROM    TemperaturesWithGroupers AS TWG;
GO

SELECT  * 
FROM    TemperaturesWithPreviousAndNextKnownOnes AS TWPNKO
ORDER BY TWPNKO.Sensor, TWPNKO.Time;
GO

SELECT  Sensor,
        Time,
        CASE 
            WHEN Temperature IS NOT NULL THEN Temperature 
            ELSE
                (
                PreviousKnownTemperature * DATEDIFF(MINUTE, NextGrouper, Time)
                +
                NextKnownTemperature * DATEDIFF(MINUTE, Time, PreviousGrouper)
                )
                /
                DATEDIFF(MINUTE, NextGrouper, PreviousGrouper)
        END AS Temperature,
        CASE 
            WHEN Temperature IS NULL THEN 'Interpolated'
            ELSE 'Real'
        END AS 'Source'
FROM    TemperaturesWithPreviousAndNextKnownOnes AS TWPNKO
ORDER BY TWPNKO.Sensor, TWPNKO.Time;
GO





---------
-- EOF --
---------