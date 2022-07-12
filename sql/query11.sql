-- Retrieve alphabetically the states that had
-- over 100 counties with unemployment rates above 6.0%
-- in 2008.
-- Hint: Unemployment rate = unemployed / labour force
-- 1.1 marks: <8 operators
-- 1.0 marks: <9 operators
-- 0.9 marks: <11 operators
-- 0.8 marks: correct answer


SELECT `abbr`
FROM `county`
    JOIN `countylabourstats` ON (`county` = `fips`)
    JOIN `state` ON (`state` = `id`)
WHERE `year`= 2008 AND (`unemployed`/`labour_force`) > 0.06 
GROUP BY `state`
HAVING COUNT(`county`)> 100
ORDER BY `abbr`