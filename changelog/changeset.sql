--liquibase formatted sql

--changeset Allen:1CreateAccountsTable context:dev label:R1.0
--description Insert SQL change objects here https://docs.liquibase.com/change-types/home.html
CREATE TABLE Accounts (
    id SERIAL PRIMARY KEY,
    account_name VARCHAR(255) NOT NULL,
    description TEXT
);

--rollback DROP TABLE Accounts;

--changeset benriley:2CreateTransactionsTable
CREATE TABLE Transactions (
    id SERIAL PRIMARY KEY,
    account_name VARCHAR(255) NOT NULL,
    description TEXT
);
--rollback DROP TABLE Transactions;

--changeset benriley:3CreateLedgerTable
CREATE TABLE Ledger (
    id SERIAL PRIMARY KEY,
    account_name VARCHAR(255) NOT NULL,
    description TEXT
);

--rollback DROP TABLE Ledger;

--changeset benriley:4CreatePortfolioTable
CREATE TABLE Portfolio (
    id SERIAL PRIMARY KEY,
    account_name VARCHAR(255) NOT NULL,
    description TEXT
);

--rollback DROP TABLE Portfolio;

--changeset benriley:5CreateAuditLogTable
CREATE TABLE AuditLog (
    id SERIAL PRIMARY KEY,
    account_name VARCHAR(255) NOT NULL,
    description TEXT
);

--rollback DROP TABLE AuditLog;

--changeset benriley:6CreateDBTable
CREATE TABLE DBTable (
    id SERIAL PRIMARY KEY,
    account_name VARCHAR(255) NOT NULL,
    description TEXT
);

--rollback DROP TABLE DBTable;

