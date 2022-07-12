-- Retrieve by increasing snowfall the number of employees
-- in 'Mining, quarrying, and oil and gas extraction' for all
-- counties that have the words 'iron', 'coal', or 'mineral'
-- in their name.
-- 1.1 marks: <13 operators
-- 1.0 marks: <15 operators
-- 0.9 marks: <20 operators
-- 0.8 marks: correct answer

WITH sq1 AS (
SELECT `fips`, `cname` AS `name`, `abbr`, `snow`, `employees`
FROM (	SELECT `fips`, `name` AS `cname`, `abbr`, `snow`
		FROM `county`
			JOIN `state` ON (`state`.id = state)
		WHERE `county`.name LIKE 'iron%' 
			OR `county`.name LIKE 'mineral%' 
			OR `county`.name LIKE 'coal%'
	) AS sq
	JOIN `countyindustries` ON (county = fips)
	JOIN `industry` ON (industry = id)
WHERE name = 'Mining, quarrying, and oil and gas extraction'
),
sq2 AS (
SELECT `fips`, `name` , `abbr`,`snow`, NULL AS `employees`
FROM `county`
	JOIN `state` ON (`state`.id = state)
WHERE `county`.name LIKE 'iron%' 
	OR `county`.name LIKE 'mineral%' 
	OR `county`.name LIKE 'coal%')

SELECT name, abbr, employees
FROM
(SELECT name, abbr,`snow`, employees
FROM sq2
WHERE sq2.`fips` NOT IN (SELECT fips FROM sq1)
UNION
SELECT name, abbr,`snow`, employees
FROM sq1) AS uni
ORDER BY `snow` 