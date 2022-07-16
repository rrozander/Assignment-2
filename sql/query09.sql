-- Show which industries in which states (except DC)
-- employed at least 7.5% of the state's 2019 population,
-- ordered by the total payroll for that industry
-- in that state.
-- 1.1 marks: <26 operators
-- 1.0 marks: <30 operators
-- 0.9 marks: <35 operators
-- 0.8 marks: correct answer


WITH sq1 AS (
	SELECT `state`, SUM(`population`) AS `state_population`
    FROM `countypopulation`
		JOIN `county` ON `county` = `fips`
		JOIN `state` ON `state` = `id`
    WHERE `year` = 2019
    GROUP BY `state`
)

	SELECT `abbr`, i.`name`, SUM(`payroll`) AS `Total Payrolls`, (SUM(`employees`)/`state_population`)*100 AS `% of Population`
	FROM `countyindustries`
		JOIN `county` c ON `county` = `fips`
		JOIN `state` s ON `state` = s.`id`
		JOIN `industry` i ON `industry` = i.`id`
		JOIN sq1 ON sq1.`state` = c.`state`
	WHERE `abbr` != 'DC'
	GROUP BY c.`state`, `industry`
	HAVING `% of Population` > 7.5
	ORDER BY `Total Payrolls` DESC
