--liquibase formatted sql
--changeset benriley:1775562144634

CREATE TABLE Football (
    id SERIAL PRIMARY KEY,
    football VARCHAR(255) NOT NULL,
    player TEXT
);  

--rollback DROP TABLE Football;



