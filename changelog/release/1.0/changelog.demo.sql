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

--changeset benriley:CreateTaxReturnTable labels:demo context:dev,test
--comment Create PostgreSQL demo table tax_return
CREATE TABLE tax_return (
  tax_return_id UUID NOT NULL PRIMARY KEY,
  taxpayer_name varchar(200) NOT NULL,
  tax_year integer NOT NULL,
  filing_status varchar(50) NOT NULL,
  gross_income numeric(12,2) NOT NULL,
  taxable_income numeric(12,2) NOT NULL,
  tax_due numeric(12,2) NOT NULL,
  filing_date date NOT NULL,
  created_at timestamp NOT NULL DEFAULT now()
);
DROP TABLE tax_return;

--changeset benriley:CreateFilesTable labels:demo context:dev,test,prod
--comment Create PostgreSQL demo table files
CREATE TABLE files (
  file_id UUID NOT NULL PRIMARY KEY,
  file_name varchar(255) NOT NULL,
  file_path varchar(500) NOT NULL,
  file_size_bytes bigint,
  content_type varchar(100),
  uploaded_at timestamp NOT NULL DEFAULT now(),
  is_active boolean NOT NULL DEFAULT true
);
 --rollback DROP TABLE files;

--changeset benriley:CreateNiceTable labels:active context:dev,test,prod
--comment Create PostgreSQL demo table rick
CREATE TABLE NICE (
  NICE_ID UUID NOT NULL PRIMARY KEY,
  name varchar(100) NOT NULL,
  description text,
  created_at timestamp NOT NULL DEFAULT now(),
  updated_at timestamp NOT NULL DEFAULT now()
);
--rollback DROP TABLE NICE;

---changeset benriley:CreateTableAF labels:active context:dev,test,prod
--comment Create PostgreSQL demo table af
CREATE TABLE AF (
  AF_ID UUID NOT NULL PRIMARY KEY,
  name varchar(100) NOT NULL,
  description text,
  created_at timestamp NOT NULL DEFAULT now(),
  updated_at timestamp NOT NULL DEFAULT now()
);
--rollback DROP TABLE AF;