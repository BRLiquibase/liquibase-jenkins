--liquibase formatted sql
--changeset benriley:1775562144634

CREATE TABLE Soccer (
    id SERIAL PRIMARY KEY,
    rule_name VARCHAR(255) NOT NULL,
    description TEXT
);

--rollback DROP TABLE Soccer;



