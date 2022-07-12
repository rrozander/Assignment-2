-- Out of those counties with at least 25000 residents,
-- retrieve the pair from the same state
-- that had the absolute closest
-- population in 2018
-- 1.1 marks: <11 operators
-- 1.0 marks: <12 operators
-- 0.9 marks: <14 operators
-- 0.8 marks: correct answer

WITH sq AS(
SELECT *
FROM `countypopulation`
	JOIN `county` ON `county` = `fips`
	JOIN `state` ON `state` = `id`
WHERE `population`>25000 AND `year`=2018)

SELECT q1.name, q1.population, q2.name, q2.population
FROM sq q1
	JOIN sq q2 ON q1.county <> q2.county AND q1.state = q2.state
ORDER BY ABS(q1.population - q2.population)
LIMIT 1
