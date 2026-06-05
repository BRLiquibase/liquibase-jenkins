--liquibase formatted sql

--changeset liquibase-mcp:1780505023349-1
CREATE TABLE users_stop (
    id VARCHAR(50) NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL
);

--rollback DROP TABLE users_stop;