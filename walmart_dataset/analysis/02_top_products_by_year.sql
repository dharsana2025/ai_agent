-- Top 10 products by sales for each year.
-- Data source: Ghost PostgreSQL raw.products and raw.order_items.
-- Negative line_amount values are included in total sales.
WITH yearly_product_sales AS (
    SELECT
        EXTRACT(YEAR FROM oi.created_timestamp)::INT AS order_year,
        p.product_id,
        p.product_name,
        SUM(oi.quantity) AS units_sold,
        ROUND(SUM(oi.line_amount), 2) AS total_sales
    FROM raw.products AS p
    LEFT JOIN raw.order_items AS oi ON oi.product_id = p.product_id
    GROUP BY order_year, p.product_id, p.product_name
), ranked_products AS (
    SELECT
        yearly_product_sales.*,
        ROW_NUMBER() OVER (
            PARTITION BY order_year
            ORDER BY total_sales DESC, product_id
        ) AS product_rank
    FROM yearly_product_sales
    WHERE order_year IS NOT NULL
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