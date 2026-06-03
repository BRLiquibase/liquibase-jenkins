--liquibase formatted sql

--changeset benriley:10-demotables
CREATE TABLE demo (
    id SERIAL PRIMARY KEY,
    account_name VARCHAR(255) NOT NULL,
    description TEXT
);

--rollback DROP TABLE demo;