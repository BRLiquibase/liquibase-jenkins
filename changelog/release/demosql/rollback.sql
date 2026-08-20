--liquibase formatted sql

--changeset jsmith:102-create-shipments-table
CREATE TABLE shipments (
    shipment_id SERIAL PRIMARY KEY,
    order_ref VARCHAR(50),
    ship_date DATE
);
--rollback DROP TABLE shipments;

--changeset jsmith:103-add-column
ALTER TABLE shipments ADD COLUMN tracking_code VARCHAR(20);
--rollback ALTER TABLE shipments DROP COLUMN tracking_code;

-- Rollback commands:
    -- liquibase rollback --tag=release-4.2
    -- liquibase rollbackCount 3
    -- liquibase rollbackToDate 2026-08-01