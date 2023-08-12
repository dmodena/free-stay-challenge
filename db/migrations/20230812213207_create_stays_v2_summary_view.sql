-- migrate:up
CREATE VIEW dbo.stays_v2_summary AS
SELECT sq.customer_id, 
    sq.stay_days, 
    sq.free_stays,
    (SELECT CASE WHEN (sq.period_check_in IS NULL OR sq.period_check_out IS NULL) THEN 0
        ELSE (sq.period_check_out - sq.period_check_in) end) as period_stays
FROM
(SELECT s.customer_id,
    s.check_in,
    s.check_out,
    (SELECT s.check_out - s.check_in) as stay_days,
    s.free_stays,
    (SELECT CASE WHEN s.check_out < DATE(current_date - '1 year'::interval) THEN NULL 
        ELSE GREATEST(DATE(current_date - '1 year'::interval), s.check_in) END) AS period_check_in,	
    (SELECT CASE WHEN s.check_out < DATE(current_date - '1 year'::interval) THEN NULL
        ELSE LEAST(current_date, s.check_out) END) AS period_check_out
FROM dbo.stays_v2 s) AS sq;

-- migrate:down
DROP VIEW dbo.stays_v2_summary;
