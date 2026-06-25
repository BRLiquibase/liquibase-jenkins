--liquibase formatted sql

--changeset benriley:CreateDemoTable labels:demo context:dev,test
--comment Create demo table
CREATE TABLE demo (
  demo_id UUID NOT NULL PRIMARY KEY,
  name varchar(100) NOT NULL,
  description text,
  created_at timestamp NOT NULL DEFAULT now(),
  updated_at timestamp NOT NULL DEFAULT now()
);
--rollback DROP TABLE demo;
