-- Show the percentage of counties that have more
-- females than males.
-- 1.1 marks: <8 operators
-- 1.0 marks: <10 operators
-- 0.9 marks: <13 operators
-- 0.8 marks: correct answer

SELECT `females`/`total` AS 'Fraction'
FROM 
(SELECT
	(SELECT COUNT(*)
	FROM 
		(SELECT gen.`county`
		FROM `genderbreakdown` gen
        JOIN `countypopulation` pop ON gen.`county` = pop.`county`
        WHERE `year` = 2019 AND  `gender` = 'female' AND gen.`population`/pop.`population` > 0.5) AS sq
	) AS females,
	(SELECT COUNT(*)
    FROM `county`
    )AS total) AS sq1