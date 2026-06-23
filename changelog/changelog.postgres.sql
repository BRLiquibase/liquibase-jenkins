--liquibase formatted sql

--changeset liquibase-mcp:1782122860604-8 labels:finance,orders context:dev
--comment Create orders table
CREATE TABLE orders (
  order_id UUID NOT NULL PRIMARY KEY,
  customer_id UUID NOT NULL,
  order_date timestamp NOT NULL DEFAULT now(),
  status varchar(50) NOT NULL DEFAULT 'pending',
  total_amount numeric(10,2) NOT NULL
);
--rollback DROP TABLE orders;

--changeset liquibase-mcp:1782122860604-7 labels:finance,reporting context:dev
--comment Create active_users view
CREATE VIEW active_users AS SELECT user_id, email, username, tenant_id FROM users WHERE is_active = true;
--rollback DROP VIEW active_users;

--changeset liquibase-mcp:1782122860604-6 labels:finance,performance context:dev
--comment Create index on orders.customer_id
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
--rollback DROP INDEX idx_orders_customer_id;

--changeset liquibase-mcp:100-001 labels:finance context:dev
--comment Create payments table
CREATE TABLE payments (
  payment_id UUID PRIMARY KEY,
  order_id UUID NOT NULL,
  amount numeric(12,2) NOT NULL,
  payment_date timestamp DEFAULT now(),
  status varchar(50)
);

--changeset liquibase-mcp:100-002 labels:finance context:dev
--comment Create invoices table
CREATE TABLE invoices (
  invoice_id UUID PRIMARY KEY,
  customer_id UUID NOT NULL,
  invoice_date timestamp NOT NULL,
  due_date timestamp,
  total_amount numeric(12,2)
);
--rollback DROP TABLE invoices;

--changeset liquibase-mcp:100-003 labels:finance context:dev
CREATE TABLE ledger_entries (
  entry_id UUID PRIMARY KEY,
  account_id VARCHAR(20) NOT NULL,
  debit_amount numeric(12,2),
  credit_amount numeric(12,2),
  entry_date timestamp DEFAULT now()
);

--changeset liquibase-mcp:100-004 labels:finance context:dev
--comment Create fx_rates table
CREATE TABLE fx_rates (
  rate_id UUID PRIMARY KEY,
  currency_pair varchar(10) NOT NULL,
  rate numeric(18,8) NOT NULL,
  rate_date timestamp NOT NULL
);
--rollback DROP TABLE fx_rates;

--changeset liquibase-mcp:100-005 labels:finance context:dev
--comment Create audit_logs table
CREATE TABLE audit_logs (
  log_id UUID PRIMARY KEY,
  table_name varchar(100) NOT NULL,
  operation varchar(10),
  user_id UUID,
  log_date timestamp DEFAULT now(),
  is_sensitive boolean DEFAULT false
);

--changeset liquibase-mcp:100-006 labels:finance context:dev
CREATE TABLE transactions (
  transaction_id UUID PRIMARY KEY,
  from_account varchar(30) NOT NULL,
  to_account varchar(30) NOT NULL,
  amount numeric(15,2) NOT NULL
);
--rollback DROP TABLE transactions;

--changeset liquibase-mcp:100-007 labels:finance context:dev
--comment Create reconciliation table
CREATE TABLE reconciliation (
  reconcile_id UUID PRIMARY KEY,
  statement_date timestamp,
  statement_amount numeric(15,2),
  reconciled_amount numeric(15,2),
  variance numeric(15,2)
);

--changeset liquibase-mcp:100-008 context:dev
CREATE TABLE bank_accounts (
  account_number varchar(30) PRIMARY KEY,
  account_name varchar(100) NOT NULL,
  balance numeric(15,2),
  currency varchar(3),
  opened_date timestamp
);
--rollback DROP TABLE bank_accounts;

--changeset liquibase-mcp:100-009 labels:finance context:dev
--comment Create tax_records table
CREATE TABLE tax_records (
  tax_record_id UUID PRIMARY KEY,
  fiscal_year integer,
  tax_amount numeric(15,2) NOT NULL,
  filing_date timestamp
);
--rollback DROP TABLE tax_records;

--changeset liquibase-mcp:100-010 labels:finance context:dev
CREATE TABLE vendor_accounts (
  vendor_id UUID PRIMARY KEY,
  vendor_name varchar(150) NOT NULL,
  payment_terms varchar(50),
  account_balance numeric(15,2)
);

--changeset liquibase-mcp:100-011 labels:finance
--comment Create expense_claims table
CREATE TABLE expense_claims (
  claim_id UUID PRIMARY KEY,
  employee_id UUID NOT NULL,
  claim_date timestamp DEFAULT now(),
  amount numeric(12,2) NOT NULL,
  status varchar(50)
);
--rollback DROP TABLE expense_claims;

--changeset liquibase-mcp:100-012 labels:finance context:dev
CREATE TABLE budget_allocations (
  budget_id UUID PRIMARY KEY,
  department varchar(100) NOT NULL,
  fiscal_year integer,
  allocated_amount numeric(15,2)
);
--rollback DROP TABLE budget_allocations;

--changeset liquibase-mcp:100-013 labels:finance context:dev
--comment Create cost_centers table
CREATE TABLE cost_centers (
  center_id varchar(20) PRIMARY KEY,
  center_name varchar(150) NOT NULL,
  manager_id UUID,
  budget_limit numeric(15,2)
);

--changeset liquibase-mcp:100-014 labels:finance context:dev
CREATE TABLE revenue_streams (
  stream_id UUID PRIMARY KEY,
  stream_name varchar(100),
  monthly_revenue numeric(15,2),
  forecast_revenue numeric(15,2),
  last_updated timestamp DEFAULT now()
);
--rollback DROP TABLE revenue_streams;

--changeset liquibase-mcp:100-015 labels:finance context:dev
--comment Create general ledger table
CREATE TABLE general_ledger (
  gl_id UUID PRIMARY KEY,
  account_code varchar(20) NOT NULL,
  balance numeric(15,2),
  is_active boolean DEFAULT true
);

--changeset liquibase-mcp:100-016 labels:finance context:dev
CREATE TABLE settlement_details (
  settlement_id UUID PRIMARY KEY,
  payment_date timestamp NOT NULL,
  settled_amount numeric(15,2),
  settlement_status varchar(50)
);
--rollback DROP TABLE settlement_details;

--changeset liquibase-mcp:100-017 labels:finance context:dev
--comment Create interest_calculations table
CREATE TABLE interest_calculations (
  interest_id UUID PRIMARY KEY,
  principal_amount numeric(15,2) NOT NULL,
  interest_rate numeric(8,4),
  calculation_date timestamp
);

--changeset liquibase-mcp:100-018 labels:finance context:dev
CREATE TABLE accruals (
  accrual_id UUID PRIMARY KEY,
  accrual_type varchar(50) NOT NULL,
  accrual_amount numeric(15,2),
  accrual_date timestamp DEFAULT now()
);
--rollback DROP TABLE accruals;

--changeset liquibase-mcp:100-019 labels:finance context:dev
--comment Create depreciation_schedules table
CREATE TABLE depreciation_schedules (
  schedule_id UUID PRIMARY KEY,
  asset_id UUID NOT NULL,
  depreciation_amount numeric(12,2),
  schedule_date timestamp
);

--changeset liquibase-mcp:100-020 labels:finance context:dev
CREATE TABLE asset_registers (
  asset_id UUID PRIMARY KEY,
  asset_name varchar(200) NOT NULL,
  cost_value numeric(15,2),
  acquisition_date timestamp,
  useful_life integer
);
--rollback DROP TABLE asset_registers;

--changeset liquibase-mcp:100-021 labels:finance context:dev
--comment Create liability_accounts table
CREATE TABLE liability_accounts (
  liability_id UUID PRIMARY KEY,
  liability_type varchar(50) NOT NULL,
  amount_due numeric(15,2),
  due_date timestamp
);

--changeset liquibase-mcp:100-022 labels:finance context:dev
CREATE TABLE equity_transactions (
  equity_id UUID PRIMARY KEY,
  transaction_type varchar(50),
  transaction_amount numeric(15,2),
  transaction_date timestamp DEFAULT now()
);
--rollback DROP TABLE equity_transactions;

--changeset liquibase-mcp:100-023 labels:finance context:dev
--comment Create cash_flow_statements table
CREATE TABLE cash_flow_statements (
  statement_id UUID PRIMARY KEY,
  reporting_period varchar(20),
  operating_cash numeric(15,2),
  investing_cash numeric(15,2),
  financing_cash numeric(15,2)
);

--changeset liquibase-mcp:100-024 labels:finance context:dev
CREATE TABLE income_statements (
  statement_id UUID PRIMARY KEY,
  period_start timestamp,
  period_end timestamp,
  total_revenue numeric(15,2),
  total_expenses numeric(15,2)
);
--rollback DROP TABLE income_statements;

--changeset liquibase-mcp:100-025 labels:finance context:dev
--comment Create balance_sheet table
CREATE TABLE balance_sheet (
  sheet_id UUID PRIMARY KEY,
  reporting_date timestamp NOT NULL,
  total_assets numeric(15,2),
  total_liabilities numeric(15,2),
  total_equity numeric(15,2)
);

--changeset liquibase-mcp:100-026 labels:finance context:dev runInTransaction:false
CREATE TABLE receivables (
  receivable_id UUID PRIMARY KEY,
  customer_id UUID NOT NULL,
  amount_due numeric(15,2),
  due_date timestamp
);
--rollback DROP TABLE receivables;

--changeset liquibase-mcp:100-027 labels:finance context:dev
--comment Create payables table
CREATE TABLE payables (
  payable_id UUID PRIMARY KEY,
  vendor_id UUID NOT NULL,
  amount_due numeric(15,2),
  payment_date timestamp
);

--changeset liquibase-mcp:100-028 labels:finance context:dev
CREATE TABLE contra_accounts (
  contra_id UUID PRIMARY KEY,
  account_id varchar(20) NOT NULL,
  contra_amount numeric(15,2),
  contra_date timestamp DEFAULT now()
);
--rollback DROP TABLE contra_accounts;

--changeset liquibase-mcp:100-029 labels:finance context:dev
--comment Create consolidation_data table
CREATE TABLE consolidation_data (
  consolidation_id UUID PRIMARY KEY,
  entity_id UUID NOT NULL,
  consolidation_period varchar(20),
  consolidation_amount numeric(15,2)
);

--changeset liquibase-mcp:100-030 labels:finance context:dev
CREATE TABLE foreign_exchange (
  fx_transaction_id UUID PRIMARY KEY,
  source_currency varchar(3) NOT NULL,
  target_currency varchar(3) NOT NULL,
  exchange_rate numeric(18,8),
  transaction_date timestamp
);
--rollback DROP TABLE foreign_exchange;

--changeset liquibase-mcp:100-031 labels:finance context:dev
--comment Create provision_accounts table
CREATE TABLE provision_accounts (
  provision_id UUID PRIMARY KEY,
  provision_type varchar(100) NOT NULL,
  provision_amount numeric(15,2),
  created_date timestamp DEFAULT now()
);

--changeset liquibase-mcp:100-032 labels:finance
CREATE TABLE deferred_revenue (
  deferred_id UUID PRIMARY KEY,
  customer_id UUID NOT NULL,
  deferred_amount numeric(15,2),
  recognition_date timestamp
);
--rollback DROP TABLE deferred_revenue;

--changeset liquibase-mcp:100-033 labels:finance context:dev
--comment Create deferred_expenses table
CREATE TABLE deferred_expenses (
  deferred_expense_id UUID PRIMARY KEY,
  expense_type varchar(100),
  expense_amount numeric(15,2),
  deferral_period integer
);

--changeset liquibase-mcp:100-034 labels:finance context:dev
CREATE TABLE goodwill_amortization (
  amortization_id UUID PRIMARY KEY,
  goodwill_amount numeric(15,2),
  amortization_rate numeric(8,4),
  amortization_date timestamp
);
--rollback DROP TABLE goodwill_amortization;

--changeset liquibase-mcp:100-035 labels:finance context:dev
--comment Create impairment_tests table
CREATE TABLE impairment_tests (
  test_id UUID PRIMARY KEY,
  asset_id UUID NOT NULL,
  book_value numeric(15,2),
  fair_value numeric(15,2),
  test_date timestamp
);

--changeset liquibase-mcp:100-036 labels:finance context:dev
CREATE TABLE lease_obligations (
  lease_id UUID PRIMARY KEY,
  asset_id UUID NOT NULL,
  lease_amount numeric(15,2),
  lease_term integer
);
ALTER TABLE lease_obligations MODIFY lease_amount varchar(50);

--changeset liquibase-mcp:100-037 labels:finance context:dev
--comment Create subscription_revenue table
CREATE TABLE subscription_revenue (
  subscription_id UUID PRIMARY KEY,
  customer_id UUID NOT NULL,
  monthly_fee numeric(12,2),
  subscription_date timestamp DEFAULT now()
);
--rollback DROP TABLE subscription_revenue;

--changeset liquibase-mcp:100-038 labels:finance context:dev
CREATE TABLE contract_assets (
  contract_id UUID PRIMARY KEY,
  customer_id UUID NOT NULL,
  contract_value numeric(15,2),
  completion_percentage numeric(5,2)
);
--rollback DROP TABLE contract_assets;

--changeset liquibase-mcp:100-039 labels:finance context:dev
--comment Create revenue_recognition table
CREATE VIEW revenue_recognition AS SELECT * FROM subscription_revenue WHERE subscription_date IS NOT NULL;
--rollback DROP VIEW revenue_recognition;

--changeset liquibase-mcp:100-040 labels:finance context:dev
CREATE TABLE performance_obligations (
  obligation_id UUID PRIMARY KEY,
  contract_id UUID NOT NULL,
  obligation_amount numeric(15,2),
  satisfaction_status varchar(50)
);
--rollback DROP TABLE performance_obligations;

--changeset liquibase-mcp:100-041 labels:finance context:dev
--comment Create warranty_provisions table
CREATE TABLE warranty_provisions (
  warranty_id UUID PRIMARY KEY,
  product_id UUID NOT NULL,
  provision_amount numeric(12,2),
  warranty_period integer
);

--changeset liquibase-mcp:100-042 labels:finance context:dev
CREATE TABLE contingent_liabilities (
  contingent_id UUID PRIMARY KEY,
  liability_description text,
  estimated_amount numeric(15,2)
);
DROP TABLE contingent_liabilities;

--changeset liquibase-mcp:100-043 labels:finance context:dev
--comment Create legal_settlements table
CREATE TABLE legal_settlements (
  settlement_id UUID PRIMARY KEY,
  case_id VARCHAR(50) NOT NULL,
  settlement_amount numeric(15,2),
  settlement_date timestamp
);
--rollback DROP TABLE legal_settlements;

--changeset liquibase-mcp:100-044 labels:finance context:dev
CREATE TABLE insurance_claims (
  claim_id UUID PRIMARY KEY,
  policy_id VARCHAR(50) NOT NULL,
  claim_amount numeric(15,2),
  claim_date timestamp DEFAULT now()
);

--changeset liquibase-mcp:100-045 labels:finance context:dev
--comment Create pension_obligations table
CREATE TABLE pension_obligations (
  pension_id UUID PRIMARY KEY,
  employee_id UUID NOT NULL,
  obligation_amount numeric(15,2),
  vesting_date timestamp
);
--rollback DROP TABLE pension_obligations;

--changeset liquibase-mcp:100-046 labels:finance context:dev
CREATE TABLE share_issuance (
  issuance_id UUID PRIMARY KEY,
  share_type varchar(50) NOT NULL,
  shares_issued integer,
  issue_price numeric(12,4)
);
GRANT SELECT ON share_issuance TO role_analyst;

--changeset liquibase-mcp:100-047 labels:finance context:dev
--comment Create dividend_payments table
CREATE TABLE dividend_payments (
  dividend_id UUID PRIMARY KEY,
  shareholder_id UUID NOT NULL,
  dividend_amount numeric(12,2),
  payment_date timestamp
);
--rollback DROP TABLE dividend_payments;

--changeset liquibase-mcp:100-048 labels:finance context:dev
CREATE TABLE stock_repurchase (
  repurchase_id UUID PRIMARY KEY,
  shares_repurchased integer,
  repurchase_price numeric(12,4),
  repurchase_date timestamp DEFAULT now()
);
--rollback DROP TABLE stock_repurchase;

--changeset liquibase-mcp:100-049 labels:finance context:dev
--comment Create earnings_per_share table
CREATE TABLE earnings_per_share (
  eps_id UUID PRIMARY KEY,
  reporting_period varchar(20),
  net_income numeric(15,2),
  shares_outstanding integer
);

--changeset liquibase-mcp:100-050 labels:finance context:dev
CREATE TABLE price_earnings_ratio (
  pe_id UUID PRIMARY KEY,
  stock_price numeric(12,4),
  earnings_per_share numeric(12,4),
  calculation_date timestamp
);
--rollback DROP TABLE price_earnings_ratio;

--changeset liquibase-mcp:100-051 labels:finance context:dev
--comment Create debt_equity_ratio table
CREATE TABLE debt_equity_ratio (
  ratio_id UUID PRIMARY KEY,
  total_debt numeric(15,2),
  total_equity numeric(15,2)
);

--changeset liquibase-mcp:100-052 labels:finance context:dev
CREATE TABLE current_ratio (
  ratio_id UUID PRIMARY KEY,
  current_assets numeric(15,2),
  current_liabilities numeric(15,2),
  calculation_date timestamp DEFAULT now()
);
ALTER TABLE current_ratio DROP COLUMN calculation_date;

--changeset liquibase-mcp:100-053 labels:finance context:dev
--comment Create quick_ratio table
CREATE TABLE quick_ratio (
  ratio_id UUID PRIMARY KEY,
  liquid_assets numeric(15,2),
  current_liabilities numeric(15,2)
);
--rollback DROP TABLE quick_ratio;

--changeset liquibase-mcp:100-054 labels:finance context:dev
CREATE TABLE roa_analysis (
  analysis_id UUID PRIMARY KEY,
  net_income numeric(15,2),
  total_assets numeric(15,2),
  reporting_period varchar(20)
);
--rollback DROP TABLE roa_analysis;

--changeset liquibase-mcp:100-055 labels:finance context:dev
--comment Create roe_analysis table
CREATE TABLE roe_analysis (
  analysis_id UUID PRIMARY KEY,
  net_income numeric(15,2),
  total_equity numeric(15,2)
);

--changeset liquibase-mcp:100-056 labels:finance context:dev
CREATE TABLE debt_service_coverage (
  coverage_id UUID PRIMARY KEY,
  net_operating_income numeric(15,2),
  total_debt_service numeric(15,2),
  coverage_ratio numeric(8,4)
);
--rollback DROP TABLE debt_service_coverage;

--changeset liquibase-mcp:100-057 labels:finance
--comment Create interest_coverage table
CREATE TABLE interest_coverage (
  coverage_id UUID PRIMARY KEY,
  ebit numeric(15,2),
  interest_expense numeric(15,2)
);
--rollback DROP TABLE interest_coverage;

--changeset liquibase-mcp:100-058 labels:finance context:dev
CREATE TABLE liquidity_analysis (
  analysis_id UUID PRIMARY KEY,
  cash_balance numeric(15,2),
  short_term_obligations numeric(15,2),
  analysis_date timestamp DEFAULT now()
);

--changeset liquibase-mcp:100-059 labels:finance context:dev
--comment Create solvency_analysis table
CREATE TABLE solvency_analysis (
  analysis_id UUID PRIMARY KEY,
  total_assets numeric(15,2),
  total_liabilities numeric(15,2),
  solvency_ratio numeric(8,4)
);
--rollback DROP TABLE solvency_analysis;

--changeset liquibase-mcp:100-060 labels:finance context:dev
CREATE TABLE cash_equivalents (
  equivalent_id UUID PRIMARY KEY,
  equivalent_type varchar(50) NOT NULL,
  amount numeric(15,2),
  maturity_date timestamp
);
--rollback DROP TABLE cash_equivalents;

--changeset liquibase-mcp:100-061 labels:finance runInTransaction:false
--comment Create short_term_investments table
CREATE TABLE short_term_investments (
  investment_id UUID PRIMARY KEY,
  investment_type varchar(50),
  amount numeric(15,2),
  purchase_date timestamp
);

--changeset liquibase-mcp:100-062 labels:finance context:dev
CREATE TABLE long_term_investments (
  investment_id UUID PRIMARY KEY,
  investment_type varchar(50) NOT NULL,
  amount numeric(15,2),
  expected_return numeric(8,4)
);
--rollback DROP TABLE long_term_investments;

--changeset liquibase-mcp:100-063 labels:finance context:dev
--comment Create portfolio_allocation table
CREATE TABLE portfolio_allocation (
  allocation_id UUID PRIMARY KEY,
  asset_type varchar(50),
  allocation_percentage numeric(5,2),
  target_allocation numeric(5,2)
);

--changeset liquibase-mcp:100-064 labels:finance context:dev
CREATE TABLE currency_exposure (
  exposure_id UUID PRIMARY KEY,
  currency varchar(3) NOT NULL,
  exposure_amount numeric(15,2),
  hedge_ratio numeric(5,2)
);
USE DATABASE risk_analytics;

--changeset liquibase-mcp:100-065 labels:finance context:dev
--comment Create credit_exposure table
CREATE TABLE credit_exposure (
  exposure_id UUID PRIMARY KEY,
  counterparty_id UUID NOT NULL,
  exposure_amount numeric(15,2),
  credit_rating varchar(10)
);
--rollback DROP TABLE credit_exposure;

--changeset liquibase-mcp:100-066 labels:finance context:dev
CREATE TABLE market_risk (
  risk_id UUID PRIMARY KEY,
  risk_type varchar(50) NOT NULL,
  risk_amount numeric(15,2),
  confidence_level numeric(5,2)
);
--rollback DROP TABLE market_risk;

--changeset liquibase-mcp:100-067 labels:finance context:dev
--comment Create operational_risk table
CREATE TABLE operational_risk (
  risk_id UUID PRIMARY KEY,
  risk_description text,
  estimated_loss numeric(15,2),
  probability numeric(5,4)
);

--changeset liquibase-mcp:100-068 labels:finance context:dev
CREATE TABLE liquidity_risk (
  risk_id UUID PRIMARY KEY,
  asset_id UUID NOT NULL,
  liquidity_score numeric(5,2),
  risk_level varchar(20)
);
--rollback DROP TABLE liquidity_risk;

--changeset liquibase-mcp:100-069 labels:finance context:dev
--comment Create interest_rate_risk table
CREATE TABLE interest_rate_risk (
  risk_id UUID PRIMARY KEY,
  exposure_amount numeric(15,2),
  duration numeric(8,4),
  convexity numeric(12,6)
);

--changeset liquibase-mcp:100-070 labels:finance context:dev
CREATE TABLE basis_risk (
  risk_id UUID PRIMARY KEY,
  instrument_id UUID NOT NULL,
  basis_spread numeric(8,6),
  measurement_date timestamp DEFAULT now()
);
--rollback DROP TABLE basis_risk;

--changeset liquibase-mcp:100-071 labels:finance context:dev
--comment Create concentration_risk table
CREATE TABLE concentration_risk (
  risk_id UUID PRIMARY KEY,
  concentration_type varchar(50),
  concentration_percentage numeric(5,2),
  threshold_percentage numeric(5,2)
);

--changeset liquibase-mcp:100-072 labels:finance context:dev
CREATE TABLE systemic_risk (
  risk_id UUID PRIMARY KEY,
  systemic_indicator varchar(100) NOT NULL,
  indicator_value numeric(12,4),
  measurement_date timestamp
);
--rollback DROP TABLE systemic_risk;

--changeset liquibase-mcp:100-073 labels:finance context:dev
--comment Create counterparty_risk table
CREATE TABLE counterparty_risk (
  risk_id UUID PRIMARY KEY,
  counterparty_id UUID NOT NULL,
  exposure_amount numeric(15,2)
);
TRUNCATE TABLE counterparty_risk;

--changeset liquibase-mcp:100-074 labels:finance context:dev
CREATE TABLE regulatory_exposure (
  exposure_id UUID PRIMARY KEY,
  regulation varchar(100) NOT NULL,
  compliance_status varchar(50),
  exposure_amount numeric(15,2)
);
--rollback DROP TABLE regulatory_exposure;

--changeset liquibase-mcp:100-075 labels:finance context:dev
--comment Create compliance_violations table
CREATE TABLE compliance_violations (
  violation_id UUID PRIMARY KEY,
  violation_type varchar(100),
  violation_date timestamp,
  penalty_amount numeric(12,2)
);

--changeset liquibase-mcp:100-076 labels:finance context:dev
CREATE TABLE capital_requirements (
  requirement_id UUID PRIMARY KEY,
  regulatory_body varchar(100) NOT NULL,
  required_capital numeric(15,2),
  current_capital numeric(15,2)
);
--rollback DROP TABLE capital_requirements;

--changeset liquibase-mcp:100-077 labels:finance context:dev
--comment Create reserve_requirements table
CREATE TABLE reserve_requirements (
  reserve_id UUID PRIMARY KEY,
  reserve_type varchar(50),
  required_amount numeric(15,2),
  held_amount numeric(15,2)
);

--changeset liquibase-mcp:100-078 labels:finance context:dev
CREATE TABLE liquidity_requirements (
  requirement_id UUID PRIMARY KEY,
  requirement_date timestamp NOT NULL,
  required_liquidity numeric(15,2),
  held_liquidity numeric(15,2)
);
ALTER TABLE liquidity_requirements MODIFY requirement_date varchar(50);

--changeset liquibase-mcp:100-079 labels:finance context:dev
--comment Create stress_testing table
CREATE TABLE stress_testing (
  test_id UUID PRIMARY KEY,
  scenario varchar(100) NOT NULL,
  impact_amount numeric(15,2),
  probability numeric(5,4)
);
--rollback DROP TABLE stress_testing;

--changeset liquibase-mcp:100-080 labels:finance context:dev
CREATE TABLE scenario_analysis (
  scenario_id UUID PRIMARY KEY,
  scenario_name varchar(150),
  scenario_probability numeric(5,4),
  expected_outcome numeric(15,2)
);
--rollback DROP TABLE scenario_analysis;

--changeset liquibase-mcp:100-081 labels:finance context:dev
--comment Create sensitivity_analysis table
CREATE TABLE sensitivity_analysis (
  analysis_id UUID PRIMARY KEY,
  variable_name varchar(100),
  base_value numeric(15,2),
  sensitivity_coefficient numeric(12,6)
);

--changeset liquibase-mcp:100-082 labels:finance context:dev
CREATE TABLE monte_carlo_simulation (
  simulation_id UUID PRIMARY KEY,
  simulation_iterations integer,
  mean_outcome numeric(15,2),
  standard_deviation numeric(15,2)
);
--rollback DROP TABLE monte_carlo_simulation;

--changeset liquibase-mcp:100-083 labels:finance context:dev
--comment Create value_at_risk table
CREATE VIEW value_at_risk AS SELECT * FROM portfolio_allocation WHERE asset_type IS NOT NULL;
--rollback DROP VIEW value_at_risk;

--changeset liquibase-mcp:100-084 labels:finance context:dev
CREATE TABLE conditional_var (
  var_id UUID PRIMARY KEY,
  portfolio_id UUID NOT NULL,
  confidence_level numeric(5,2),
  cvar_amount numeric(15,2)
);
--rollback DROP TABLE conditional_var;

--changeset liquibase-mcp:100-085 labels:finance context:dev
--comment Create expected_shortfall table
CREATE TABLE expected_shortfall (
  shortfall_id UUID PRIMARY KEY,
  loss_amount numeric(15,2),
  probability numeric(5,4),
  cumulative_probability numeric(5,4)
);

--changeset liquibase-mcp:100-086 labels:finance context:dev
CREATE TABLE credit_default_swap (
  swap_id UUID PRIMARY KEY,
  reference_entity varchar(100) NOT NULL,
  swap_spread numeric(8,4),
  maturity_date timestamp
);
--rollback DROP TABLE credit_default_swap;

--changeset liquibase-mcp:100-087 labels:finance context:dev
--comment Create equity_derivatives table
CREATE TABLE equity_derivatives (
  derivative_id UUID PRIMARY KEY,
  underlying_asset varchar(100),
  strike_price numeric(12,4)
);
DROP TABLE equity_derivatives;

--changeset liquibase-mcp:100-088 labels:finance context:dev
CREATE TABLE interest_rate_swap (
  swap_id UUID PRIMARY KEY,
  notional_amount numeric(15,2) NOT NULL,
  fixed_rate numeric(8,6),
  floating_rate_index varchar(50)
);
--rollback DROP TABLE interest_rate_swap;

--changeset liquibase-mcp:100-089 labels:finance context:dev
--comment Create commodity_futures table
CREATE TABLE commodity_futures (
  future_id UUID PRIMARY KEY,
  commodity_type varchar(50),
  future_price numeric(15,4),
  expiration_date timestamp
);

--changeset liquibase-mcp:100-090 labels:finance context:dev
CREATE TABLE options_chain (
  option_id UUID PRIMARY KEY,
  option_type varchar(10) NOT NULL,
  strike_price numeric(12,4),
  expiration_date timestamp,
  volatility numeric(8,6)
);
GRANT INSERT, UPDATE ON options_chain TO role_trader;

--changeset liquibase-mcp:100-091 labels:finance context:dev
--comment Create forward_contracts table
CREATE TABLE forward_contracts (
  contract_id UUID PRIMARY KEY,
  counterparty_id UUID NOT NULL,
  contract_value numeric(15,2),
  maturity_date timestamp
);
--rollback DROP TABLE forward_contracts;

--changeset liquibase-mcp:100-092 labels:finance context:dev
CREATE TABLE repo_agreements (
  repo_id UUID PRIMARY KEY,
  security_identifier varchar(50),
  repo_rate numeric(8,6),
  maturity_date timestamp
);

--changeset liquibase-mcp:100-093 labels:finance context:dev
--comment Create securitization table
CREATE TABLE securitization (
  securitization_id UUID PRIMARY KEY,
  underlying_assets numeric(15,2) NOT NULL,
  tranche_structure varchar(200),
  yield_rate numeric(8,6)
);
--rollback DROP TABLE securitization;

--changeset liquibase-mcp:100-094 labels:finance context:dev
CREATE TABLE asset_backed_securities (
  security_id UUID PRIMARY KEY,
  underlying_asset_type varchar(100),
  issue_amount numeric(15,2),
  rating varchar(10)
);
ALTER TABLE asset_backed_securities DROP COLUMN rating;

--changeset liquibase-mcp:100-095 labels:finance context:dev
--comment Create mortgage_backed_securities table
CREATE TABLE mortgage_backed_securities (
  security_id UUID PRIMARY KEY,
  pool_number varchar(50) NOT NULL,
  principal_balance numeric(15,2),
  wac numeric(8,6)
);
--rollback DROP TABLE mortgage_backed_securities;

--changeset liquibase-mcp:100-096 labels:finance context:dev
CREATE TABLE collateral_management (
  collateral_id UUID PRIMARY KEY,
  pledge_type varchar(50),
  collateral_value numeric(15,2),
  haircut_percentage numeric(5,2),
  margin_requirement numeric(15,2),
  daily_valuation numeric(15,2)
);
REVOKE SELECT ON collateral_management FROM role_external;

--changeset liquibase-mcp:100-097 labels:finance context:dev
--comment Create margin_calls table
CREATE TABLE margin_calls (
  call_id UUID PRIMARY KEY,
  account_id UUID NOT NULL,
  call_amount numeric(15,2),
  call_date timestamp
);
--rollback DROP TABLE margin_calls;

--changeset liquibase-mcp:100-098 labels:finance context:dev
CREATE TABLE settlement_failures (
  failure_id UUID PRIMARY KEY,
  trade_id UUID NOT NULL,
  failure_reason varchar(200),
  resolution_date timestamp
);
TRUNCATE TABLE settlement_failures;

--changeset liquibase-mcp:100-099 labels:finance context:dev
--comment Create failed_transactions table
CREATE TABLE failed_transactions (
  transaction_id UUID PRIMARY KEY,
  transaction_date timestamp NOT NULL,
  failure_reason varchar(200),
  retry_count integer
);
USE DATABASE archive_db;

--changeset liquibase-mcp:100-100 labels:finance context:dev
CREATE TABLE comprehensive_accounts (
  account_id_col1 UUID PRIMARY KEY,
  account_name_col2 varchar(200),
  account_type_col3 varchar(50),
  balance_col4 numeric(15,2),
  currency_col5 varchar(3),
  status_col6 varchar(20),
  created_date_col7 timestamp,
  last_modified_col8 timestamp,
  manager_id_col9 UUID,
  cost_center_col10 varchar(50),
  profit_center_col11 varchar(50),
  reporting_unit_col12 varchar(100),
  consolidation_flag_col13 boolean,
  intercompany_flag_col14 boolean,
  blocked_flag_col15 boolean,
  reconciliation_status_col16 varchar(50),
  audit_trail_col17 text,
  compliance_flag_col18 boolean,
  risk_rating_col19 varchar(10),
  credit_limit_col20 numeric(15,2),
  credit_used_col21 numeric(15,2),
  notes_col22 text
);
--rollback DROP TABLE comprehensive_accounts;
