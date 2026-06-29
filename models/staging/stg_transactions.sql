{{ config(materialized='view') }}

WITH source_date AS (
	SELECT *
	FROM {{source('bdwDataset', 'transactionTable')}}
),
cleaned AS (
	SELECT
		CAST(transaction_id AS int64) AS transaction_id,
		CAST(account_id AS int64) AS account_id,
		LOWER(TRIM(transaction_type)) AS transaction_type,
		CAST(amount AS numeric) AS amount,
		DATE(transaction_date) AS transaction_date,
		TRIM(merchant_name) AS merchant_name,
		LOWER(TRIM(category)) AS category,
		TIMESTAMP(created_at) AS created_at
	FROM source_date
)

SELECT * FROM cleaned