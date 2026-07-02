--liquibase formatted sql

--changeset benriley:CreateYetiTable labels:demo context:dev,test
--comment Create PostgreSQL demo table yeti
CREATE TABLE yeti (
  yeti_id UUID NOT NULL PRIMARY KEY,
  name varchar(100) NOT NULL,
  habitat varchar(100) NOT NULL,
  height_cm integer,
  weight_kg numeric(7,2),
  last_sighted_at timestamp NOT NULL DEFAULT now(),
  description text,
  created_at timestamp NOT NULL DEFAULT now(),
  updated_at timestamp NOT NULL DEFAULT now()
);
--rollback DROP TABLE yeti;
