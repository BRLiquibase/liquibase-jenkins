--liquibase formatted sql

--changeset benriley:CreatingOrdersTable labels:V1.0 context:dev,test
--comment Create orders table
CREATE TABLE orders1 (
  order_id UUID NOT NULL PRIMARY KEY,
  customer_id UUID NOT NULL,
  order_date timestamp NOT NULL DEFAULT now(),
  status varchar(50) NOT NULL DEFAULT 'pending',
  total_amount numeric(10,2) NOT NULL
);
--rollback DROP TABLE orders1;
