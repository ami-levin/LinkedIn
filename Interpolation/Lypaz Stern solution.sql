

--------------
-- OPTIONAL --
--------------
-- Name: Lypaz stern
-- Twitter: 
-- LinkedIn: https://www.linkedin.com/in/lypaz-stern-423700167/
-- Facebook:Lypaz stern
-- Website:
-- Date: Nov 07, 2021


WITH CoolantTemperaturesWithNextGrouper
AS
(
SELECT	*,
        MIN(KnownTemperatureTime)
        OVER (PARTITION BY SENSOR ORDER BY Time ASC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS NextGrouper,
		MAX(KnownTemperatureTime)
        OVER (PARTITION BY SENSOR ORDER BY Time ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS PreviousGrouper 
FROM	MinuteTemperatures AS CMT
CROSS APPLY (VALUES	(
					CASE 
					WHEN Temperature IS NOT NULL 
					THEN Time 
					ELSE NULL
					END
					) 
					) AS KnownTemperatures (KnownTemperatureTime)
), CoolantTemperaturesWithNextGrouper2 AS
(
SELECT  *,
MAX(Temperature) OVER(PARTITION BY  SENSOR,NextGrouper) AS NextKnownTemperature,
MAX(Temperature) OVER(PARTITION BY  SENSOR,PreviousGrouper) AS PreviousKnownTemperature
FROM    CoolantTemperaturesWithNextGrouper AS CTPG
),Liniar_Dirication AS

(
SELECT
*
,ROW_NUMBER() OVER (PARTITION BY SENSOR,NextKnownTemperature ORDER BY NextGrouper) AS Liniar_Dirication
FROM CoolantTemperaturesWithNextGrouper2 
)
,Liniar_Dirication_Agg AS
(
SELECT
SENSOR
,TIME
,Temperature
,MAX(Liniar_Dirication) OVER (PARTITION BY SENSOR,NextKnownTemperature)  AS Liniar_Dirication_Agg
,NextKnownTemperature
,PreviousKnownTemperature
FROM Liniar_Dirication
), RUNNING_TOTAL_VALUE AS
(
SELECT
*
,CASE WHEN Temperature IS NOT NULL THEN Temperature
      WHEN NextKnownTemperature > PreviousKnownTemperature THEN MAX((NextKnownTemperature - PreviousKnownTemperature) / Liniar_Dirication_Agg) OVER (PARTITION BY SENSOR, Liniar_Dirication_Agg ORDER BY TIME)
      WHEN NextKnownTemperature < PreviousKnownTemperature THEN MAX(((PreviousKnownTemperature - NextKnownTemperature) / Liniar_Dirication_Agg)*-1) OVER (PARTITION BY SENSOR, Liniar_Dirication_Agg ORDER BY TIME)
	   END AS RUNNING_TOTAL_VALUE   
FROM Liniar_Dirication_Agg
)
SELECT
SENSOR
,TIME
,CASE WHEN Temperature IS NOT NULL THEN Temperature
      ELSE SUM (RUNNING_TOTAL_VALUE) OVER (PARTITION BY SENSOR , PreviousKnownTemperature ORDER BY TIME) END AS Temperature
,CASE WHEN Temperature IS NOT NULL THEN 'Real'
      ELSE 'Intepolate'  END AS IS_INTERPOLATE
FROM RUNNING_TOTAL_VALUE
ORDER BY SENSOR, TIME



/*
Expected result:
---------------------------------------------------------
Sensor		TIME					Temperature	Source
---------------------------------------------------------
Coolant	2021-01-01 18:01:00.000	98.000000	Real
Coolant	2021-01-01 18:02:00.000	106.000000	Interpolated
Coolant	2021-01-01 18:03:00.000	114.000000	Interpolated
Coolant	2021-01-01 18:04:00.000	122.000000	Real
Coolant	2021-01-01 18:05:00.000	119.000000	Interpolated
Coolant	2021-01-01 18:06:00.000	116.000000	Interpolated
Coolant	2021-01-01 18:07:00.000	113.000000	Interpolated
Coolant	2021-01-01 18:08:00.000	110.000000	Interpolated
Coolant	2021-01-01 18:09:00.000	107.000000	Interpolated
Coolant	2021-01-01 18:10:00.000	104.000000	Real
Intake	2021-01-01 18:09:00.000	85.000000	Real
Intake	2021-01-01 18:10:00.000	84.333333	Interpolated
Intake	2021-01-01 18:11:00.000	83.666666	Interpolated
Intake	2021-01-01 18:12:00.000	83.000000	Interpolated
Intake	2021-01-01 18:13:00.000	82.333333	Interpolated
Intake	2021-01-01 18:14:00.000	81.666666	Interpolated
Intake	2021-01-01 18:15:00.000	81.000000	Interpolated
Intake	2021-01-01 18:16:00.000	80.333333	Interpolated
Intake	2021-01-01 18:17:00.000	79.666666	Interpolated
Intake	2021-01-01 18:18:00.000	79.000000	Real
Intake	2021-01-01 18:19:00.000	82.666666	Interpolated
Intake	2021-01-01 18:20:00.000	86.333333	Interpolated
Intake	2021-01-01 18:21:00.000	90.000000	Real
Oil		2021-01-01 18:01:00.000	102.000000	Real
Oil		2021-01-01 18:02:00.000	113.000000	Interpolated
Oil		2021-01-01 18:03:00.000	124.000000	Real
Oil		2021-01-01 18:04:00.000	125.125000	Interpolated
Oil		2021-01-01 18:05:00.000	126.250000	Interpolated
Oil		2021-01-01 18:06:00.000	127.375000	Interpolated
Oil		2021-01-01 18:07:00.000	128.500000	Interpolated
Oil		2021-01-01 18:08:00.000	129.625000	Interpolated
Oil		2021-01-01 18:09:00.000	130.750000	Interpolated
Oil		2021-01-01 18:10:00.000	131.875000	Interpolated
Oil		2021-01-01 18:11:00.000	133.000000	Real
Oil		2021-01-01 18:12:00.000	131.500000	Interpolated
Oil		2021-01-01 18:13:00.000	130.000000	Interpolated
Oil		2021-01-01 18:14:00.000	128.500000	Interpolated
Oil		2021-01-01 18:15:00.000	127.000000	Interpolated
Oil		2021-01-01 18:16:00.000	125.500000	Interpolated
Oil		2021-01-01 18:17:00.000	124.000000	Interpolated
Oil		2021-01-01 18:18:00.000	122.500000	Interpolated
Oil		2021-01-01 18:19:00.000	121.000000	Real
Oil		2021-01-01 18:20:00.000	118.842105	Interpolated
Oil		2021-01-01 18:21:00.000	116.684210	Interpolated
Oil		2021-01-01 18:22:00.000	114.526315	Interpolated
Oil		2021-01-01 18:23:00.000	112.368421	Interpolated
Oil		2021-01-01 18:24:00.000	110.210526	Interpolated
Oil		2021-01-01 18:25:00.000	108.052631	Interpolated
Oil		2021-01-01 18:26:00.000	105.894736	Interpolated
Oil		2021-01-01 18:27:00.000	103.736842	Interpolated
Oil		2021-01-01 18:28:00.000	101.578947	Interpolated
Oil		2021-01-01 18:29:00.000	99.421052	Interpolated
Oil		2021-01-01 18:30:00.000	97.263157	Interpolated
Oil		2021-01-01 18:31:00.000	95.105263	Interpolated
Oil		2021-01-01 18:32:00.000	92.947368	Interpolated
Oil		2021-01-01 18:33:00.000	90.789473	Interpolated
Oil		2021-01-01 18:34:00.000	88.631578	Interpolated
Oil		2021-01-01 18:35:00.000	86.473684	Interpolated
Oil		2021-01-01 18:36:00.000	84.315789	Interpolated
Oil		2021-01-01 18:37:00.000	82.157894	Interpolated
Oil		2021-01-01 18:38:00.000	80.000000	Real

*/






---------
-- EOF --
---------