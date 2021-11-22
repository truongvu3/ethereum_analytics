/* Mining Pool Tx Received, Average Received Block Reward, Unique Mining
Pools and Mining Ratio of mining pool participants */

WITH mp_agg AS (
SELECT * FROM mining_pools
UNION ALL
SELECT * FROM mp_proxy
),
total_inc AS (
SELECT DISTINCT to_address AS address,
COUNT(1) AS tx_received
FROM `crypto_ethereum.transactions`
WHERE block_number <= 11828337 AND
GROUP BY to_address
)
SELECT DISTINCT to_address AS miner,
COUNT(1) AS mining_pool_tx_received,
COUNT(DISTINCT label) AS unique_mining_pool,
AVG(value) AS avg_received_block_reward,
SUM(value) AS total_amount_ether_from_mining_pool,
COUNT(1)/tx_received AS mining_ratio
FROM `crypto_ethereum.transactions` AS a
LEFT JOIN mp_agg AS b ON a.from_address = b.address
LEFT JOIN total_inc AS c ON a.to_address = c.address
WHERE block_number <= 11828337 AND
from_address IN (SELECT address FROM mp_agg) AND
to_address NOT IN (SELECT address FROM mp_proxy)
GROUP BY miner
