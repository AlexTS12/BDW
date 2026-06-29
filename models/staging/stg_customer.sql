{{config(materialized='view')}}

WITH source_data AS (
	SELECT *
	FROM {{source('bdwDataset', 'customerTable')}}
),
cleaned AS (
	SELECT
		CAST(customer_id AS int64) AS customer_id,
		TRIM(first_name) AS first_name,
		TRIM(last_name) AS last_name,
		DATE(date_of_birth) AS date_of_birth,
		LOWER(TRIM(email)) AS email
	FROM source_data
)

SELECT * FROM cleaned