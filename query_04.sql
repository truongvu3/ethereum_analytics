/* Idle Time for EOAs with Active Days ≥ 2 */

SELECT DISTINCT address,
DATE_DIFF(DATE('2021-02-10 10:53:31 UTC'), DATE(MAX(bt)), DAY) AS
idle_time
FROM
(
 SELECT
 from_address AS address,
 block_timestamp AS bt,
 FROM `crypto_ethereum.transactions` AS t
 WHERE block_number <= 11828337

)
GROUP BY address
HAVING DATE_DIFF(DATE(MAX(bt)), DATE(MIN(bt)), DAY) >= 2
