-- Retrieve in descending order of labour force size
-- all counties that had unemployment rates over 10%
-- in the 2008 census.
-- Hint: Unemployment rate = unemployment / labour force
-- 1.1 marks: <9 operators
-- 1.0 marks: <10 operators
-- 1.0 marks: <15 operators
-- 0.8 marks: correct answer

SELECT `abbr`
FROM `state`
WHERE `id` NOT IN
	(SELECT C1.`state`
	FROM `county` C1, `county` C2
	WHERE C1.`fips` <> C2.`fips`
	AND C1.`name` = C2.`name`)
ORDER BY `abbr`
