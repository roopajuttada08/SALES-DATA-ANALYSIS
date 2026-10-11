-- ============================================================
-- Sales Data Analysis — Advanced SQL
-- Demonstrates JOINs, CTEs, subqueries and window functions.
-- Assumes a MySQL database with the `sales` table (see schema.sql).
-- ============================================================

-- 1) Revenue by category (aggregation + ordering)
SELECT
    category,
    SUM(quantity * unit_price)            AS total_revenue,
    COUNT(DISTINCT order_id)              AS orders
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;

-- 2) Monthly revenue trend with month-over-month growth (window function)
WITH monthly AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m')  AS ym,
        SUM(quantity * unit_price)        AS revenue
    FROM sales
    GROUP BY ym
)
SELECT
    ym,
    revenue,
    LAG(revenue) OVER (ORDER BY ym)                                   AS prev_month_revenue,
    ROUND((revenue - LAG(revenue) OVER (ORDER BY ym))
          / LAG(revenue) OVER (ORDER BY ym) * 100, 2)                 AS mom_growth_pct
FROM monthly
ORDER BY ym;

-- 3) Top products ranked by revenue (window function: RANK)
WITH product_revenue AS (
    SELECT
        product,
        SUM(quantity * unit_price) AS total_revenue
    FROM sales
    GROUP BY product
)
SELECT
    product,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM product_revenue
ORDER BY revenue_rank;

-- 4) Customer value with cumulative contribution (running total)
WITH customer_spend AS (
    SELECT
        customer_id,
        SUM(quantity * unit_price) AS total_spend
    FROM sales
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_spend,
    SUM(total_spend) OVER (ORDER BY total_spend DESC)                          AS cumulative_spend,
    ROUND(SUM(total_spend) OVER (ORDER BY total_spend DESC)
          / SUM(total_spend) OVER () * 100, 1)                                 AS cumulative_share_pct
FROM customer_spend
ORDER BY total_spend DESC;

-- 5) JOIN example: enrich sales with a customers dimension table
SELECT
    s.order_id,
    s.order_date,
    c.customer_name,
    c.region            AS customer_region,
    s.product,
    (s.quantity * s.unit_price) AS revenue
FROM sales s
JOIN customers c ON c.customer_id = s.customer_id
WHERE (s.quantity * s.unit_price) > (
    SELECT AVG(quantity * unit_price) FROM sales   -- subquery filter
)
ORDER BY revenue DESC;
