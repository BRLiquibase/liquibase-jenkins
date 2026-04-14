--liquibase formatted sql
--changeset benriley:1775562144634

CREATE TABLE Football (
    id SERIAL PRIMARY KEY,
    football VARCHAR(255) NOT NULL,
    player TEXT
);  

--rollback DROP TABLE Football;

--changeset benriley:CreatePlayerTable label: Dev,Test,Production 
--Description: Creating a new table to store player information

CREATE TABLE Player (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    position VARCHAR(255) NOT NULL
);

--rollback DROP TABLE Player;


