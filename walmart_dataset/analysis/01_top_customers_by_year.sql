-- Top 10 customers by total order spend for each order year.
WITH yearly_customer_spend AS (
    SELECT
        EXTRACT(YEAR FROM o.order_timestamp)::INT AS order_year,
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        COUNT(DISTINCT o.order_id) AS order_count,
        COALESCE(ROUND(SUM(oi.line_amount), 2), 0) AS total_spend
    FROM raw.customers AS c
    LEFT JOIN raw.orders AS o ON o.customer_id = c.customer_id
    LEFT JOIN raw.order_items AS oi ON oi.order_id = o.order_id
    GROUP BY order_year, c.customer_id, c.first_name, c.last_name, c.email
), ranked_customers AS (
    SELECT
        yearly_customer_spend.*,
        ROW_NUMBER() OVER (
            PARTITION BY order_year
            ORDER BY total_spend DESC, customer_id
        ) AS customer_rank
    FROM yearly_customer_spend
    WHERE order_year IS NOT NULL
)
SELECT
    order_year,
    customer_rank,
    customer_id,
    first_name,
    last_name,
    email,
    order_count,
    total_spend
FROM ranked_customers
WHERE customer_rank <= 10
ORDER BY order_year, customer_rank;