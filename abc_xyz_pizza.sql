WITH abc_xyz AS (
    SELECT
        abc.name,
        abc.abc_amount,
        abc.abc_revenue,
        xyz.xyz
    FROM result_abc abc
    JOIN result_xyz xyz
        ON abc.name = xyz.name
    ORDER BY abc.name
)
SELECT
    name AS pizza,
    abc_amount || xyz AS abc_xyz_quantity,
    abc_revenue || xyz AS abc_xyz_revenue
FROM abc_xyz
