-- Retrieve alphabetically all states
-- with at least one hundred counties.
-- 1.1 marks: <6 operators
-- 1.0 marks: <8 operators
-- 0.8 marks: correct answer

SELECT `abbr`
FROM `county`
	JOIN `state` ON `state` = `id`
GROUP BY `state`
HAVING COUNT(*)>=100
ORDER BY `abbr`
