SELECT COUNT(DISTINCT address) FROM `crypto_ethereum.balances`
UNION ALL
SELECT COUNT(DISTINCT address) FROM `crypto_ethereum.balances`
WHERE address NOT IN (SELECT address FROM `crypto_ethereum.contracts`)
UNION ALL
SELECT COUNT(DISTINCT address) FROM `crypto_ethereum.balances`
WHERE address IN (SELECT address FROM `crypto_ethereum.transactions`)
UNION ALL
SELECT COUNT(DISTINCT address) FROM `crypto_ethereum.balances`
WHERE address NOT IN (SELECT address FROM `crypto_ethereum.transactions`)
AND address NOT IN (SELECT address FROM `crypto_ethereum.contracts`)
UNION ALL
SELECT COUNT(DISTINCT address) FROM `crypto_ethereum.balances`
WHERE address IN (SELECT address FROM `crypto_ethereum.contracts`)
UNION ALL
SELECT COUNT(DISTINCT address) FROM `crypto_ethereum.balances`
WHERE address IN (SELECT address FROM `crypto_ethereum.contracts`
WHERE is_Erc20 IS True)
UNION ALL
SELECT COUNT(DISTINCT address) FROM `crypto_ethereum.balances`
WHERE address IN (SELECT address FROM `crypto_ethereum.contracts`
WHERE is_erc721 IS True)
