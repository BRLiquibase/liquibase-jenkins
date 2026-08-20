--liquibase formatted sql

--changeset jsmith:104-create-table
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    account_name VARCHAR(100)
);
--rollback DROP TABLE accounts;

--changeset jsmith:105-add-column
ALTER TABLE accounts ADD COLUMN risk_tier VARCHAR(10);
--rollback ALTER TABLE accounts DROP COLUMN risk_tier;

--changeset jsmith:106-backfill
UPDATE accounts SET risk_tier = 'STANDARD' WHERE risk_tier IS NULL;
--rollback UPDATE accounts SET risk_tier = NULL WHERE risk_tier = 'STANDARD';

--changeset jsmith:107-add-not-null
ALTER TABLE accounts ALTER COLUMN risk_tier SET NOT NULL;
--rollback ALTER TABLE accounts ALTER COLUMN risk_tier DROP NOT NULL;