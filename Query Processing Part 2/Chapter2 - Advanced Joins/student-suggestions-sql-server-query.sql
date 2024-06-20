-----------------------------------------------------
-- Please copy and fill the following information: --
-----------------------------------------------------
/*
Name: Shruti Chanda
Video: Advanced Loagical Processing Part 2 > Chapter 2 > Solution 
Time: 
My suggestion: I want to understand if the current use case (challenge 2) is correct and optimal use for lateral joins. On watching your solution video, I understand that there could be a very easy way to solve this challenge by simply applying self join and qualification predicate. And I do feel that the proposed solution has a few redundant qualification predicates. Please comment your thoughts and is this a valid solution.
*/

-- Query:

USE Animal_Shelter;
GO;

SELECT A.Species, A.Breed, A.Name AS Male, Females.*
FROM Animals AS A
	CROSS APPLY
	(SELECT An.Name AS Female
		FROM Animals AS An
		WHERE An.Species = A.Species
			AND
			An.Breed = A.Breed
			AND 
			An.Gender = 'F') AS Females
WHERE A.Breed IS NOT NULL
	AND
	A.Gender = 'M'
ORDER BY A.Species, A.Breed;
GO;
