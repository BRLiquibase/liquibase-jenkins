--liquibase formatted sql

--changeset benriley:1CreateAussieRulesTable
--description Insert SQL change objects here https://docs.liquibase.com/change-types/home.html
CREATE TABLE AussieRules (
    id SERIAL PRIMARY KEY,
    rule_name VARCHAR(255) NOT NULL,
    description TEXT
);

--rollback DROP TABLE AussieRules;

--changeset benriley:2CreateCricketTable
create table Cricket (
    id SERIAL PRIMARY KEY,
    rule_name VARCHAR(255) NOT NULL,
    description TEXT
);
--rollback DROP TABLE Cricket;


--changeset benriley:3CreateRugbyTable
CREATE table Rugby (
    id SERIAL PRIMARY KEY,
    rule_name VARCHAR(255) NOT NULL,
    description TEXT
);
--rollback DROP TABLE Rugby;


