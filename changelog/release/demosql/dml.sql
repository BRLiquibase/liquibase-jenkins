--liquibase formatted sql

--changeset jsmith:103
UPDATE orders SET status = 'ARCHIVED' WHERE created_date < '2020-01-01';
--rollback UPDATE orders SET status = 'ACTIVE' WHERE created_date < '2020-01-01';