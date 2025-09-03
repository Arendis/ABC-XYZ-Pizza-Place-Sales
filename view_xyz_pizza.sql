CREATE VIEW result_xyz AS (
    WITH group_data_xyz AS (
        SELECT
            month,
            name,
            SUM(quantity) AS quantity
        FROM pizza_trim_data
        WHERE year = 2015
        GROUP BY month, name
        ORDER BY name
    ), xyz AS (
        SELECT
            month,
            name,
            quantity,
            STDDEV_POP(quantity) OVER (PARTITION BY name),
            AVG(quantity) OVER (PARTITION BY name),
            ROUND(STDDEV_POP(quantity) OVER (PARTITION BY name) / AVG(quantity) OVER (PARTITION BY name), 3) AS covar
        FROM group_data_xyz
    ), xyz_total AS (
        SELECT
            name,
            MIN(covar) AS cov
        FROM xyz
        GROUP BY name
    )
    SELECT
        name,
        cov,
        CASE
            WHEN cov <= 0.1 THEN 'X'
            WHEN cov <= 0.25 THEN 'Y'
            ELSE 'Z'
        END xyz
    FROM xyz_total
    ORDER BY name
)