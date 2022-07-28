-- Retrieve the state with the median number of
-- employees in 'Education Services'
-- 1.1 marks: < 10 operators
-- 1.0 marks: < 11 operators
-- 0.8 marks: correct answer

WITH sq AS (
SELECT ANY_VALUE(`abbr`) AS `abbr`, SUM(`employees`) AS `TotalEmployees`
FROM `countyindustries`
	JOIN `county` ON `county` = `fips`
    JOIN `state` s ON `state` = s.`id`
    JOIN `industry` i ON `industry` = i.`id`
WHERE i.`name` = 'Educational Services'
GROUP BY `state`, `industry`
ORDER BY `TotalEmployees`
)

SELECT q1.`abbr`, q1.`TotalEmployees`
FROM sq q1, sq q2
GROUP BY q1.`TotalEmployees`
HAVING SUM(SIGN(1-SIGN(q2.`TotalEmployees`-q1.`TotalEmployees`))) = (COUNT(*)+1)/2