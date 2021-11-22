/* Proxy address heuristic: Query calculates the highest consecutive occurrence of
payouts to the same receiver and orders receivers by maximum occurrence in
descending order. The query has to be run for every mining pool. */

WITH all_mp_payouts AS (
SELECT from_address AS address,
label,
to_address AS recipient,
block_timestamp,
FROM `crypto_ethereum.transactions` AS t
LEFT JOIN mining_pools AS mp ON mp.address = t.from_address
WHERE block_number <= 11828337
),

a AS (
SELECT recipient,
label,
block_timestamp
FROM all_mp_payouts
WHERE address = /* <INSERT ADDRESS OF MINING POOL TO EXAMINE> */
ORDER BY block_timestamp ASC
),
b AS (
SELECT recipient,
label,
count(*) AS occ
FROM (SELECT a.*,
 (ROW_NUMBER() OVER (ORDER BY
 block_timestamp) - ROW_NUMBER() OVER
 (PARTITION BY recipient ORDER BY
 block_timestamp)
 ) AS grp
 FROM a
 ) a
GROUP BY grp, recipient, label
),
c AS(
SELECT DISTINCT recipient,
label,
MAX(occ) AS maxocc
FROM b
GROUP BY recipient,label
)
SELECT * FROM c ORDER BY maxocc DESC
