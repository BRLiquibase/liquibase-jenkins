--liquibase formatted sql

--changeset benriley:CreateTransactionsTable labels:V1.0 context:dev,test
--comment Create transactions table
CREATE TABLE transactions (
  transaction_id UUID NOT NULL PRIMARY KEY,
  account_id UUID NOT NULL,
  transaction_date timestamp NOT NULL DEFAULT now(),
  transaction_type varchar(50) NOT NULL,
  amount numeric(15,2) NOT NULL,
  currency varchar(3) NOT NULL DEFAULT 'USD',
  status varchar(50) NOT NULL DEFAULT 'pending',
  reference_number varchar(100)
);
--rollback DROP TABLE transactions;


--changeset benriley:CreateAccountsTable labels:V1.0 context:dev,test
--comment Create accounts table
CREATE TABLE accounts (
  account_id UUID NOT NULL PRIMARY KEY,
  account_holder varchar(100) NOT NULL,
  account_type varchar(50) NOT NULL,
  balance numeric(15,2) NOT NULL DEFAULT 0.00,
  currency varchar(3) NOT NULL DEFAULT 'USD',
  created_at timestamp NOT NULL DEFAULT now(),
  status varchar(50) NOT NULL DEFAULT 'active'
);
--rollback DROP TABLE accounts;


--changeset benriley:AddForeignKeyTransactionsAccounts labels:V1.0 context:dev,test
--comment Link transactions to accounts
ALTER TABLE transactions
  ADD CONSTRAINT fk_transactions_account_id
  FOREIGN KEY (account_id) REFERENCES accounts(account_id);
--rollback ALTER TABLE transactions DROP CONSTRAINT fk_transactions_account_id;

--changeset benriley:Createtable labels:V1.0 context:dev,test
--comment Link transactions to accounts
create table audit_log (
  log_id UUID NOT NULL PRIMARY KEY,
  entity_name varchar(100) NOT NULL,
  entity_id UUID NOT NULL,
  action varchar(50) NOT NULL,
  performed_by varchar(100) NOT NULL,
  performed_at timestamp NOT NULL DEFAULT now(),
  details text
);
 DROP TABLE audit_log;

--changeset benriley:CreateCustomerAccountsTable labels:V1.0 context:dev,test
--comment Create customer accounts table for SAP HANA
CREATE COLUMN TABLE customer_accounts (
  customer_account_id BIGINT NOT NULL PRIMARY KEY,
  customer_number NVARCHAR(50) NOT NULL,
  account_name NVARCHAR(200) NOT NULL,
  account_type NVARCHAR(50) NOT NULL,
  opening_balance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  currency_code NVARCHAR(3) NOT NULL DEFAULT 'USD',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status NVARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT uk_customer_accounts_customer_number UNIQUE (customer_number)
);
--rollback DROP TABLE customer_accounts;


