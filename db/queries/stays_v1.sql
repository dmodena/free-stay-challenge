-- Solution using subquery
SELECT id AS customer_id,
    SUM(sq.paid_stay) AS paid_stays,
    SUM(sq.free_stay) AS free_stays,
    FLOOR(SUM(sq.paid_stay) / 5) - SUM(sq.free_stay) AS balance
FROM
(SELECT c.id,
    (CASE WHEN s.free_stay = FALSE THEN 1 ELSE 0 END) AS paid_stay,
    (CASE WHEN s.free_stay = TRUE THEN 1 ELSE 0 END) AS free_stay
FROM dbo.customers c
LEFT JOIN dbo.stays_v1 s ON c.id = s.customer_id
    AND s.stay_date BETWEEN (CURRENT_DATE - '1 year'::interval) AND CURRENT_DATE) AS sq
GROUP BY id;

-- Solution using CTE
WITH cte AS
(SELECT c.id,
    (CASE WHEN s.free_stay = FALSE THEN 1 ELSE 0 END) AS paid_stay,
    (CASE WHEN s.free_stay = TRUE THEN 1 ELSE 0 END) AS free_stay
FROM dbo.customers c
LEFT JOIN dbo.stays_v1 s ON c.id = s.customer_id
    AND s.stay_date BETWEEN (CURRENT_DATE - '1 year'::interval) AND CURRENT_DATE
)
SELECT cte.id AS customer_id,
    SUM(cte.paid_stay) AS paid_stays,
    SUM(cte.free_stay) AS free_stays,
    FLOOR(SUM(cte.paid_stay) / 5) - SUM(cte.free_stay) AS balance
FROM cte
GROUP BY cte.id;
