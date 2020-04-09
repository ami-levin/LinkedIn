-------------------------------------
-- LinkedIn Learning ----------------
-- Advanced SQL - Query Processing --
-- Ami Levin 2020 -------------------
-- .\Chapter 2\Video3.sql -----------
-------------------------------------

-- https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=ee77cf4d2ccfcdb7c2bb319b651101fe&hide=3

USE Animal_Shelter;  -- For SQL Server

SELECT	*
FROM	Animals AS AN
		INNER JOIN 
		Adoptions AS AD
			ON AD.Name = AN.Name 
			AND 
			AD.Species = AN.Species
		INNER JOIN 
		Persons AS P 
			ON	AD.Adopter_Email = P.Email;

SELECT	*
FROM	Animals AS AN
		LEFT OUTER JOIN 
		Adoptions AS AD
			ON AD.Name = AN.Name 
			AND 
			AD.Species = AN.Species
		INNER JOIN 
		Persons AS P
			ON P.Email = AD.Adopter_Email;

SELECT	*
FROM	Animals AS AN
		LEFT OUTER JOIN 
		Adoptions AS AD
			ON AD.Name = AN.Name 
			AND 
			AD.Species = AN.Species
/*		INNER JOIN 
		Persons AS P
			ON P.Email = AD.Adopter_Email */;

SELECT	*
FROM	Animals AS AN
		LEFT OUTER JOIN 
		Adoptions AS AD
			ON AD.Name = AN.Name 
			AND 
			AD.Species = AN.Species
		LEFT OUTER JOIN 
		Persons AS P
			ON P.Email = AD.Adopter_Email;

SELECT	*
FROM	Animals AS AN
		LEFT OUTER JOIN 
		(Adoptions AS AD
			ON AD.Name = AN.Name 
			AND 
			AD.Species = AN.Species
		INNER JOIN 
		Persons AS P
			ON P.Email = AD.Adopter_Email);

SELECT	*
FROM	Animals AS AN
		LEFT OUTER JOIN 
			(
				Adoptions AS AD
				INNER JOIN 
				Persons AS P 
					ON	AD.Adopter_Email = P.Email
			)
			ON AD.Name = AN.Name 
			AND 
			AD.Species = AN.Species;

SELECT	*
FROM	Animals AS AN
		LEFT OUTER JOIN 
			Adoptions AS AD
			INNER JOIN 
			Persons AS P 
				ON	AD.Adopter_Email = P.Email
			ON 	AD.Name = AN.Name 
				AND 
				AD.Species = AN.Species;