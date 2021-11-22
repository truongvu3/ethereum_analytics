/* SC Ratio for regular users with Idle Time ≤ 30 */

SELECT DISTINCT address,
COUNT(1) AS tx_sent,
COUNT(CASE WHEN to_address IN (SELECT address FROM
`crypto_ethereum.contracts`) THEN 1 END) AS sc_tx_sent,
(COUNT(CASE WHEN to_address IN (SELECT address FROM
`crypto_ethereum.contracts`) THEN 1 END))/(COUNT(1)) AS sc_ratio
FROM
(
 SELECT
 from_address AS address,
 to_address AS to_address,
 block_timestamp AS bt,
 FROM `crypto_ethereum.transactions` AS t
 WHERE block_number <= 11828337

)
GROUP BY address
HAVING COUNT(1) >= 124 AND COUNT(1) <= 1894 AND DATE_DIFF(DATE('2021-
02-10 10:53:31 UTC'), DATE(MAX(bt)), DAY) <= 30
