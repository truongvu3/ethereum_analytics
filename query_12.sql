/* Activity level of centralised exchanges */

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
)
SELECT COUNT(1) AS transaction_count,
COUNT(DISTINCT from_address) AS user,
COUNT(1)/COUNT(DISTINCT from_address) AS transaction_per_user,
COUNT(DISTINCT from_address)/COUNT((SELECT * FROM regular_users)) AS
user_regularuser_ratio
FROM
(
 SELECT
 to_address AS address,
 from_address AS from_address,
 FROM `crypto_ethereum.transactions` AS t
 WHERE block_number <= 11828337 AND to_address IN
 (SELECT address FROM exch) AND from_address IN
 (SELECT address FROM regular_users)
)
