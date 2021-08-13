------------------------------------------------
-- LinkedIn Learning ---------------------------
-- Advanced SQL - Interpolation ----------------
-- Ami Levin, August 2021 ----------------------
-- Chapter 4 - Video 2 - Linear Interpolation --
------------------------------------------------
USE Formula1;
GO

SELECT  * 
FROM    CoolantMinuteTemperatures
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

SELECT	*
FROM	CoolantMinuteTemperatures AS CMT
		CROSS APPLY (VALUES	(
								CASE 
									WHEN Temperature IS NOT NULL 
										THEN Time 
									ELSE NULL
								END
							) 
					) AS KnownTemperatures (KnownTemperatureTime)
ORDER BY CMT.Time;
GO

SELECT	*,
        MIN(KnownTemperatureTime)
        OVER (ORDER BY Time ASC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
        AS NextGrouper
FROM	CoolantMinuteTemperatures AS CMT
		CROSS APPLY (VALUES	(
								CASE 
									WHEN Temperature IS NOT NULL 
										THEN Time 
									ELSE NULL
								END
							) 
					) AS KnownTemperatures (KnownTemperatureTime)
ORDER BY CMT.Time;
GO

WITH CoolantTemperaturesWithNextGrouper
AS
(
SELECT	*,
        MIN(KnownTemperatureTime)
        OVER (ORDER BY Time ASC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
        AS NextGrouper
FROM	CoolantMinuteTemperatures AS CMT
		CROSS APPLY (VALUES	(
								CASE 
									WHEN Temperature IS NOT NULL 
										THEN Time 
									ELSE NULL
								END
							) 
					) AS KnownTemperatures (KnownTemperatureTime)
)
SELECT  *,
        MAX(Temperature)
		OVER	(PARTITION BY  NextGrouper) AS NextKnownTemperature
FROM    CoolantTemperaturesWithNextGrouper AS CTPG
ORDER BY CTPG.Time;
GO

WITH CoolantTemperaturesWithNextGrouper
AS
(
SELECT	*,
        MIN(CASE 
                WHEN Temperature IS NOT NULL 
                    THEN Time 
                ELSE NULL
            END) 
        OVER (ORDER BY Time ASC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
        AS NextGrouper
FROM	CoolantMinuteTemperatures AS CMT
)
SELECT  *,
        MAX(Temperature)
		OVER	(PARTITION BY  NextGrouper) AS NextKnownTemperature
FROM    CoolantTemperaturesWithNextGrouper AS CTNG
ORDER BY CTNG.Time;
GO



https://www.itprotoday.com/sql-server/last-non-null-puzzle


---------
-- EOF --
---------