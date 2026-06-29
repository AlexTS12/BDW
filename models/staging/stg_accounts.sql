{{config(materialized='view')}}

WITH source_date AS (
	SELECT *
	FROM {{source('bdwDataset', 'accountTable')}}
),
cleaned AS (
	SELECT
		CAST(account_id AS int64) AS account_id,
		CAST(customer_id AS int64) AS customer_id,
		LOWER(TRIM(account_type)) AS account_type,
		LOWER(TRIM(status)) AS status,
		DATE(opened_date) AS opened_date,
		SAFE_CAST(closed_date AS DATE) AS closed_date
	FROM source_date
)

SELECT * FROM cleaned