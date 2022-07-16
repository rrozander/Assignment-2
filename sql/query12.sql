-- Retrieve alphabetically the names of industries that
-- employ at least five million workers across
-- the US, excluding California.
-- 1.1 marks: <9 operators
-- 1.0 marks: <11 operators
-- 0.9 marks: <14 operators
-- 0.8 marks: correct answer

SELECT `name`
FROM `countyindustries`
	JOIN `industry` ON `industry` = `id`
WHERE `county` NOT IN (
	SELECT `fips`
	FROM `county`
		JOIN `state` ON `id`= `state`
	WHERE `abbr` = 'CA'
)
GROUP BY `industry`
HAVING SUM(`employees`) > 5000000
ORDER BY `name`