-- Ad hoc analysis queries used for the Walmart PostgreSQL database.
-- Expected schema: raw
-- These statements are read-only and can be run through Ghost MCP SQL or psql.

-- 1. Top 10 customers by total order spend.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    COUNT(DISTINCT o.order_id) AS order_count,
    ROUND(SUM(oi.line_amount), 2) AS total_spend
FROM raw.customers AS c
JOIN raw.orders AS o ON o.customer_id = c.customer_id
JOIN raw.order_items AS oi ON oi.order_id = o.order_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY total_spend DESC, c.customer_id
LIMIT 10;

-- 2. Top 10 products by sales for each order year.
WITH yearly_product_sales AS (
    SELECT
        EXTRACT(YEAR FROM o.order_timestamp)::INT AS order_year,
        p.product_id,
        p.product_name,
        SUM(oi.quantity) AS units_sold,
        ROUND(SUM(oi.line_amount), 2) AS total_sales
    FROM raw.orders AS o
    JOIN raw.order_items AS oi ON oi.order_id = o.order_id
    JOIN raw.products AS p ON p.product_id = oi.product_id
    GROUP BY order_year, p.product_id, p.product_name
), ranked_products AS (
    SELECT
        yearly_product_sales.*,
        ROW_NUMBER() OVER (
            PARTITION BY order_year
            ORDER BY total_sales DESC, product_id
        ) AS product_rank
    FROM yearly_product_sales
)
SELECT
    order_year,
    product_rank,
    product_id,
    product_name,
    units_sold,
    total_sales
FROM ranked_products
WHERE product_rank <= 10
ORDER BY order_year, product_rank;

-- 3. Number of stores.
SELECT COUNT(*) AS store_count
FROM raw.stores;

-- 4. Number of customers.
SELECT COUNT(*) AS customer_count
FROM raw.customers;
