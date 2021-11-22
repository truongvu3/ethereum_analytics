 /* Zero Tx Ratio for regular users with Idle Time ≤ 30 (transactions to smart
contracts) */

SELECT DISTINCT address,
COUNT(CASE WHEN to_address IN (SELECT address FROM `bigquery-publicdata.crypto_ethereum.contracts` WHERE is_erc20 IS True) THEN 1 END) AS
erc20_tx_sent,
FROM
(
 SELECT
 from_address AS address,
 to_address AS to_address,
 block_timestamp AS bt,
 FROM `crypto_ethereum.transactions` AS t
 WHERE block_number <= 11828337 AND to_address IN
 (SELECT address FROM `crypto_ethereum.contracts`)

)
GROUP BY address
HAVING COUNT(1) >= 124 AND COUNT(1) <= 1894 AND DATE_DIFF(DATE('2021-
02-10 10:53:31 UTC'), DATE(MAX(bt)), DAY) <= 30
