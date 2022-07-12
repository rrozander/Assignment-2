-- Show the percentage of counties that have more
-- females than males.
-- 1.1 marks: <8 operators
-- 1.0 marks: <10 operators
-- 0.9 marks: <13 operators
-- 0.8 marks: correct answer


WITH sq1 AS (
SELECT COUNT(*) AS `cnt`
FROM 
(SELECT *
FROM `genderbreakdown`
GROUP BY `county`
HAVING population/SUM(population) > 0.5) AS sq)

SELECT `cnt`/COUNT(*) AS `Fraction`
FROM `county`, sq1