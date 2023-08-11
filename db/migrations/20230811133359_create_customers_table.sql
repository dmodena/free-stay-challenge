-- migrate:up
CREATE TABLE dbo.customers (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name VARCHAR(250)
);

-- migrate:down
DROP TABLE dbo.customers;
