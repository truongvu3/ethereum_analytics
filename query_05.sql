/* Active Days for regular users with Idle Time ≤ 30  */

SELECT DISTINCT address,
COUNT(1) AS tx,
DATE_DIFF(DATE(MAX(bt)), DATE(MIN(bt)), DAY) AS active_days
FROM
(
 SELECT
 from_address AS address,
 block_timestamp AS bt,
 FROM `crypto_ethereum.transactions` AS t
 WHERE block_number <= 11828337

)
GROUP BY address
HAVING COUNT(1) >= 124 and COUNT(1) <= 1894 and DATE_DIFF(DATE('2021-
02-10 10:53:31 UTC'), DATE(MAX(bt)), DAY) <= 30
