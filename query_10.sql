/* Out Token, In Token, Out/In Token Ratio for regular users with Idle Time ≤ 30  */

WITH regular_users AS (
SELECT DISTINCT address
FROM
(
 SELECT
 from_address AS address,
 block_timestamp AS bt,
 FROM `crypto_ethereum.transactions` AS t
 WHERE block_number <= 11828337

)
GROUP BY address
HAVING COUNT(1) >= 124 AND COUNT(1) <= 1894 AND DATE_DIFF(DATE('2021-
02-10 10:53:31 UTC'), DATE(MAX(bt)), DAY) <= 30
),
out AS (
SELECT DISTINCT from_address AS address,
COUNT(1) AS out_token
FROM `crypto_ethereum.token_transfers`
WHERE block_number <= 11828337 AND from_address IN (SELECT address FROM
regular_users)
GROUP BY from_address
)
SELECT DISTINCT to_address AS address,
out_token,
COUNT(1) AS in_token,
(out_token)/(count(1) + out_token) AS out_in_token_ratio
FROM `crypto_ethereum.token_transfers` AS incom
LEFT JOIN out ON incom.to_address = out.address
WHERE block_number <= 11828337 AND to_address IN (SELECT address FROM
regular_users)
GROUP BY to_address, out_token
