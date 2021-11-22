/* Activity level of mining pools */

WITH a AS (
SELECT DISTINCT to_address,
COUNT(1) AS reward_count,
COUNT(CASE WHEN reward_type = 'block' THEN 1 END) AS blocks,
COUNT(CASE WHEN reward_type = 'uncle' THEN 1 END) AS uncles,
SUM(CASE WHEN reward_type = 'block' THEN value END) AS block_reward,
SUM(CASE WHEN reward_type = 'uncle' THEN value END) AS uncle_reward,
SUM(value) AS total_reward,
FROM `crypto_ethereum.traces`
WHERE block_number <= 11828337 AND to_address IN (SELECT address FROM
mining_pools) AND trace_type = 'reward'
GROUP BY to_address
)
SELECT b.label,a.*
FROM a
LEFT JOIN mining_pools AS b ON a.to_address = b.address
ORDER BY blocks DESC
