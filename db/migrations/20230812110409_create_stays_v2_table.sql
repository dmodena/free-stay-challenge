-- migrate:up
CREATE TABLE dbo.stays_v2 (
    customer_id uuid NOT NULL REFERENCES dbo.customers(id),
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    free_stays NUMERIC NOT NULL DEFAULT 0
);

-- migrate:down
DROP TABLE dbo.stays_v2;
