--liquibase formatted sql

--changeset jsmith:100-create-orders-table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE,
    status VARCHAR(20),
    created_date DATE
);
--rollback DROP TABLE orders;

--changeset jsmith:101::jsmith
ALTER TABLE orders ADD COLUMN promo_code VARCHAR(20);
--rollback ALTER TABLE orders DROP COLUMN promo_code;

--changeset jsmith:102-backfill
UPDATE orders SET status = 'ACTIVE' WHERE status IS NULL;
--rollback UPDATE orders SET status = NULL WHERE status = 'ACTIVE';