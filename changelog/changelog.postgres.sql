--liquibase formatted sql

--changeset liquibase-mcp:1780505023349-2
CREATE TABLE orders3 (
    order_id UUID NOT NULL PRIMARY KEY,
    customer_id UUID NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT now(),
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    total_amount NUMERIC(10,2) NOT NULL
);

--rollback drop table orders3;


--changeset liquibase-mcp:1780505023349-4
CREATE INDEX idx_orders_customer_id ON orders3 (customer_id);
--rollback drop index idx_orders_customer_id;