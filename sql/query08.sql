-- Retrieve the fifteen counties with the largest 2016 vote imbalance,
-- with their vote counts and states, restricted to counties with at least 10000 votes
-- Hint: Use pq to measure variance/imbalance in this question,
-- where p is the probability of voting democrat and q, republican.
-- 1.1 marks: <11 operators
-- 1.0 marks: <12 operators
-- 0.9 marks: <15 operators
-- 0.8 marks: correct answer

SELECT `name`, `abbr`, `dem`, `gop`, `total_votes`
FROM `electionresult`
	JOIN `county` ON `county` = `fips`
    JOIN `state` ON `state` = `id`
WHERE `total_votes` > 10000 AND `year` = 2016
ORDER BY (`dem`/`total_votes`)*(`gop`/`total_votes`)
LIMIT 15
