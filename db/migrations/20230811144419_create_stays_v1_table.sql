-- migrate:up
CREATE TABLE dbo.stays_v1 (
    customer_id uuid NOT NULL REFERENCES dbo.customers(id),
    stay_date DATE NOT NULL,
    free_stay BOOLEAN NOT NULL DEFAULT FALSE
);

-- migrate:down
DROP TABLE dbo.stays_v1;
