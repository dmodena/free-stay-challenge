-- Solution querying view
SELECT c.id AS customer_id,
    COALESCE(SUM(v.period_stays), 0) AS paid_stays,
    COALESCE(SUM(v.free_stays), 0) AS free_stays,
    COALESCE((FLOOR(SUM(v.period_stays) / 5) - SUM(v.free_stays)), 0) AS balance
FROM dbo.customers c
LEFT JOIN dbo.stays_v2_summary v ON c.id = v.customer_id
GROUP BY c.id, c.full_name;
