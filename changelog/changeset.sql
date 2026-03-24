--liquibase formatted sql

--changeset benriley:1774379681428
--description Insert SQL change objects here https://docs.liquibase.com/change-types/home.html
CREATE TABLE AussieRules (
    id SERIAL PRIMARY KEY,
    rule_name VARCHAR(255) NOT NULL,
    description TEXT
);

--rollback DROP TABLE AussieRules;