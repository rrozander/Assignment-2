-- Retrieve the state with the median number of
-- employees in 'Education Services'
-- 1.1 marks: < 10 operators
-- 1.0 marks: < 11 operators
-- 0.8 marks: correct answer

SELECT `abbr`, SUM(`employees`) AS 'TotalEmployees'
FROM (SELECT `county`, `employees`
		FROM `countyindustries`
		WHERE `industry` =	(SELECT `id` FROM `industry` WHERE `name` = 'Educational services')) AS sq
	JOIN `county` ON (`county` = `fips`)
	JOIN `state` ON (`state` = `id`)
    GROUP BY `state`
    ORDER BY `TotalEmployees`
