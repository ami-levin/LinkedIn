-------------------------------------
-- LinkedIn Learning ----------------
-- Advanced SQL - Interpolation -----
-- Ami Levin, August 2021 -----------
-- Chapter 3 - Video 3 - Challenge --
-------------------------------------

/*
Your challenge for this chapter is to modify the solution we just created together 
that works only for the coolant temperatures, so that it supports multiple sensors.

Execute the query that worked against the "Coolant Minute Temperatures" view against the "Minute Temperatures" view.
See what is wrong with it, and work your way up till you get it all right. 


Expected result:
---------------------------------------------------------
Sensor	TIME					Temperature	Source
---------------------------------------------------------
Coolant	2021-01-01 18:01:00.000	98.000000	Real
Coolant	2021-01-01 18:02:00.000	98.000000	Interpolated
Coolant	2021-01-01 18:03:00.000	122.000000	Interpolated
Coolant	2021-01-01 18:04:00.000	122.000000	Real
Coolant	2021-01-01 18:05:00.000	122.000000	Interpolated
Coolant	2021-01-01 18:06:00.000	122.000000	Interpolated
Coolant	2021-01-01 18:07:00.000	122.000000	Interpolated
Coolant	2021-01-01 18:08:00.000	104.000000	Interpolated
Coolant	2021-01-01 18:09:00.000	104.000000	Interpolated
Coolant	2021-01-01 18:10:00.000	104.000000	Real
Intake	2021-01-01 18:09:00.000	85.000000	Real
Intake	2021-01-01 18:10:00.000	85.000000	Interpolated
Intake	2021-01-01 18:11:00.000	85.000000	Interpolated
Intake	2021-01-01 18:12:00.000	85.000000	Interpolated
Intake	2021-01-01 18:13:00.000	85.000000	Interpolated
Intake	2021-01-01 18:14:00.000	79.000000	Interpolated
Intake	2021-01-01 18:15:00.000	79.000000	Interpolated
Intake	2021-01-01 18:16:00.000	79.000000	Interpolated
Intake	2021-01-01 18:17:00.000	79.000000	Interpolated
Intake	2021-01-01 18:18:00.000	79.000000	Real
Intake	2021-01-01 18:19:00.000	79.000000	Interpolated
Intake	2021-01-01 18:20:00.000	90.000000	Interpolated
Intake	2021-01-01 18:21:00.000	90.000000	Real
Oil		2021-01-01 18:01:00.000	102.000000	Real
Oil		2021-01-01 18:02:00.000	102.000000	Interpolated
Oil		2021-01-01 18:03:00.000	124.000000	Real
Oil		2021-01-01 18:04:00.000	124.000000	Interpolated
Oil		2021-01-01 18:05:00.000	124.000000	Interpolated
Oil		2021-01-01 18:06:00.000	124.000000	Interpolated
Oil		2021-01-01 18:07:00.000	124.000000	Interpolated
Oil		2021-01-01 18:08:00.000	133.000000	Interpolated
Oil		2021-01-01 18:09:00.000	133.000000	Interpolated
Oil		2021-01-01 18:10:00.000	133.000000	Interpolated
Oil		2021-01-01 18:11:00.000	133.000000	Real
Oil		2021-01-01 18:12:00.000	133.000000	Interpolated
Oil		2021-01-01 18:13:00.000	133.000000	Interpolated
Oil		2021-01-01 18:14:00.000	133.000000	Interpolated
Oil		2021-01-01 18:15:00.000	133.000000	Interpolated
Oil		2021-01-01 18:16:00.000	121.000000	Interpolated
Oil		2021-01-01 18:17:00.000	121.000000	Interpolated
Oil		2021-01-01 18:18:00.000	121.000000	Interpolated
Oil		2021-01-01 18:19:00.000	121.000000	Real
Oil		2021-01-01 18:20:00.000	121.000000	Interpolated
Oil		2021-01-01 18:21:00.000	121.000000	Interpolated
Oil		2021-01-01 18:22:00.000	121.000000	Interpolated
Oil		2021-01-01 18:23:00.000	121.000000	Interpolated
Oil		2021-01-01 18:24:00.000	121.000000	Interpolated
Oil		2021-01-01 18:25:00.000	121.000000	Interpolated
Oil		2021-01-01 18:26:00.000	121.000000	Interpolated
Oil		2021-01-01 18:27:00.000	121.000000	Interpolated
Oil		2021-01-01 18:28:00.000	121.000000	Interpolated
Oil		2021-01-01 18:29:00.000	80.000000	Interpolated
Oil		2021-01-01 18:30:00.000	80.000000	Interpolated
Oil		2021-01-01 18:31:00.000	80.000000	Interpolated
Oil		2021-01-01 18:32:00.000	80.000000	Interpolated
Oil		2021-01-01 18:33:00.000	80.000000	Interpolated
Oil		2021-01-01 18:34:00.000	80.000000	Interpolated
Oil		2021-01-01 18:35:00.000	80.000000	Interpolated
Oil		2021-01-01 18:36:00.000	80.000000	Interpolated
Oil		2021-01-01 18:37:00.000	80.000000	Interpolated
Oil		2021-01-01 18:38:00.000	80.000000	Real
*/


---------
-- EOF --
---------