-- Number of stores.
SELECT COUNT(DISTINCT store_id) AS store_count
FROM raw.stores;