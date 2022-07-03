-- Retrieve alphabetically all states in which
-- every county has a name not found anywhere else
-- in the US
-- 1.1 marks: <8 operators
-- 1.0 marks: <9 operators
-- 0.8 marks: correct answer

SELECT `abbr`
FROM `state`
WHERE id NOT IN
	(SELECT C1.state
	FROM `county` C1, `county` C2
	WHERE C1.fips <> C2.fips
	AND C1.name = C2.name)
ORDER BY `abbr`
