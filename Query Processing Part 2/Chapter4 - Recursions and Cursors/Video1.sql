--------------------------------------------
-- LinkedIn Learning -----------------------
-- Advanced SQL - Query Processing Part 2 --
-- Ami Levin 2020 --------------------------
-- .\Chapter4\Video1.sql -------------------
--------------------------------------------

-- GitHub
https://github.com/ami-levin/LinkedIn/tree/master/Query%20Processing%20Part%202/Chapter4%20-%20Recursions%20and%20Cursors/Video1.sql

-- DBFiddle UK
/*SQL Server*/	https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=075b0e5ef4d49f60737ed7ab80f0c3c6&hide=3
/*PostgreSQL*/	https://dbfiddle.uk/?rdbms=postgres_12&fiddle=3c7809a20db10b7d91e5c7db7131e3ac&hide=1

/*
	____							_				_		______________	__	 ________					 
   / __ \___  _______  ____________(_)	 _____	   | |	   / /	_/_	 __/ / / /	/ ____/ /___ ___  __________ 
  / /_/ / _ \/ ___/ / / / ___/ ___/ / | / / _ \	   | | /| / // /  / / / /_/ /  / /	 / / __ `/ / / / ___/ _ \
 / _, _/  __/ /__/ /_/ / /	(__	 ) /| |/ /	__/	   | |/ |/ // /	 / / / __  /  / /___/ / /_/ / /_/ (__  )  __/
/_/ |_|\___/\___/\__,_/_/  /____/_/ |___/\___/	   |__/|__/___/ /_/ /_/ /_/	  \____/_/\__,_/\__,_/____/\___/ 
																											 
*/

/* PostgreSQL
-- Generate a series of all days in 2019, one row per day
SELECT	CAST(day AS DATE) AS day 
FROM	generate_series(	'2019-01-01'::date, -- Start::Type
							'2019-12-31',		-- End
							'1 day'				-- Interval
						) AS days_of_2019(day)
ORDER BY day ASC;
*/

-- Generating time series in SQL Server
WITH days_of_2019 (day)
AS
(
	SELECT	CAST('20190101' AS DATE)
	UNION ALL
	SELECT	DATEADD(DAY, 1, day)
	FROM	days_of_2019
	WHERE	day < CAST('20191231' AS DATE)
)
SELECT	* 
FROM	days_of_2019
ORDER BY day ASC
OPTION (MAXRECURSION 365);

/* PostgreSQL
-- Recursion
WITH RECURSIVE days_of_2019 (day) 
AS
(
	SELECT CAST('20190101' AS DATE)
	UNION ALL
	SELECT	CAST(day  + INTERVAL '1 DAY' AS DATE)
	FROM	days_of_2019
	WHERE	CAST(day AS DATE) < CAST('20191231'AS DATE)
)
SELECT	* 
FROM	days_of_2019
ORDER BY day ASC;
*/

-- Web link crawler
DROP TABLE IF EXISTS Weblinks;

CREATE TABLE Weblinks 
(
	URL		CHAR(3) NOT NULL,
	Points_To_URL CHAR(3) NOT NULL,
	PRIMARY KEY (URL, Points_To_URL),
	CHECK (URL <> Points_To_URL)
);

INSERT INTO weblinks (URL, Points_To_URL)
VALUES	('U1', 'U9'), ('U1', 'U3'), 
		('U2', 'U8'), ('U2', 'U6'),
		('U3', 'U2') ,('U3', 'U4') ,('U3', 'U5') ,('U3', 'U9') ,
		('U4', 'U2') ,('U5', 'U4') ,('U5', 'U6')

SELECT	* 
FROM	Weblinks
ORDER BY URL, Points_To_URL;

-- Crawl the web starting with URL U4
WITH Crawler (From_URL, To_URL, Level)
AS
(
	SELECT	CAST('>' AS CHAR(3)), 
			CAST('U4' AS CHAR(3)),
			CAST(0 AS INT)
	UNION ALL
	SELECT	c.To_URL, 
			W.Points_To_URL,
			level + 1
	FROM	Weblinks AS W 
			INNER JOIN 
			Crawler AS C
			ON W.URL = C.To_URL
)
SELECT	CONCAT(REPLICATE('-', Level), ' ', from_URL, ' -> ',  to_URL) AS URL_Path
FROM	Crawler
ORDER BY Level, From_URL, To_URL;

-- Cleanup
DROP TABLE weblinks;

/*
  ________  ________   _______   ______ 
 /_  __/ / / / ____/  / ____/ | / / __ \
  / / / /_/ / __/    / __/ /  |/ / / / /
 / / / __  / /___   / /___/ /|  / /_/ / 
/_/ /_/ /_/_____/  /_____/_/ |_/_____/  
                                        
*/