--liquibase formatted sql

--changeset jsmith:104-create-customer-accounts-table
CREATE TABLE customer_accounts (
    account_id SERIAL PRIMARY KEY,
    account_name VARCHAR(100),
    account_type VARCHAR(20)
);
--rollback DROP TABLE customer_accounts;

--changeset jsmith:105
ALTER TABLE customer_accounts ADD COLUMN credit_limit NUMERIC(12,2);
--rollback ALTER TABLE customer_accounts DROP COLUMN credit_limit;

--changeset jsmith:106
UPDATE customer_accounts SET credit_limit = 5000.00 WHERE credit_limit IS NULL;
--rollback UPDATE customer_accounts SET credit_limit = NULL WHERE credit_limit = 5000.00;

--changeset jsmith:107
ALTER TABLE customer_accounts ALTER COLUMN credit_limit SET NOT NULL;
--rollback ALTER TABLE customer_accounts ALTER COLUMN credit_limit DROP NOT NULL;