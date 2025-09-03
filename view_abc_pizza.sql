CREATE VIEW result_abc AS (
    WITH sales_data AS (
        SELECT
            name,
            SUM(quantity) AS amount,
            SUM(revenue) AS revenue
        FROM pizza_trim_data
        WHERE year = 2015
        GROUP BY name
        ORDER BY name
    )
    SELECT
        name,
        CASE
            WHEN SUM(amount) OVER (ORDER BY amount DESC) / SUM(amount) OVER () <= 0.8 THEN 'A'
            WHEN SUM(amount) OVER (ORDER BY amount DESC) / SUM(amount) OVER () <= 0.95 THEN 'B'
            ELSE 'C'
        END abc_amount,
        CASE
            WHEN SUM(revenue) OVER (ORDER BY revenue DESC) / SUM(revenue) OVER () <= 0.8 THEN 'A'
            WHEN SUM(revenue) OVER (ORDER BY revenue DESC) / SUM(revenue) OVER () <= 0.95 THEN 'B'
            ELSE 'C'
        END abc_revenue
    FROM sales_data
)
