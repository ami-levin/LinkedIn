-- Hi Ami,

-- I find a way to solve the same problem with bool operation approach. Please check it, if anything wrong 
-- plz correct it and merge it.
-- A.BoBo

select query.* from
(
SELECT species,
name,
checkup_time,
heart_rate,
AVG(heart_rate) OVER (PARTITION BY species)::decimal(5,2),
(heart_rate > AVG(heart_rate) OVER (PARTITION BY species))::bool as flag
FROM routine_checkups
ORDER BY species ASC,
checkup_time ASC
) query
where query.flag is true