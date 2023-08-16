-- Snowflake
-- Database CDC_DEMO

-- Schema: APP_DB
CRAETE TABLE APP_DB.customers (
    customerid integer,
    name varchar(255),
    dob date,
    gender varchar(10),
    marital_status varchar(10),
    address varchar(255),
    postcode integer,
    created_at timestamp,
    updated_at timestamp,
    deleted_at timestamp
);

-- D-3
INSERT INTO APP_DB.customers VALUES (1, 'John Doe', '1988-03-21', 'Male', 'Single', '11 Aws Street', 11121, DATEADD(DAY, -3, CURRENT_TIMESTAMP), DATEADD(DAY, -3, CURRENT_TIMESTAMP), null);
INSERT INTO APP_DB.customers VALUES (2, 'Jane Doe', '1985-08-11', 'Female', 'Married', '12 Kafka Street', 12176, DATEADD(DAY, -3, CURRENT_TIMESTAMP), DATEADD(DAY, -3, CURRENT_TIMESTAMP), null);
-- D-2
INSERT INTO APP_DB.customers VALUES (3, 'Smith Willam', '1990-01-22', 'Male', 'Single', '13 Snowflake Street', 13251, DATEADD(DAY, -2, CURRENT_TIMESTAMP), DATEADD(DAY, -2, CURRENT_TIMESTAMP), null);
INSERT INTO APP_DB.customers VALUES (4, 'Olivia Simpson', '1984-05-16', 'Female', 'Married', '14 Dbt Street', 14710, DATEADD(DAY, -2, CURRENT_TIMESTAMP), DATEADD(DAY, -2, CURRENT_TIMESTAMP), null);
UPDATE APP_DB.customers SET address = '22 Kafka Street', postcode = 22176, updated_at = DATEADD(DAY, -2, CURRENT_TIMESTAMP) WHERE customerid = 2;
-- D-1
INSERT INTO APP_DB.customers VALUES (5, 'James Thomas', '1989-07-07', 'Male', 'Married', '15 Airflow Street', 15283, DATEADD(DAY, -1, CURRENT_TIMESTAMP), DATEADD(DAY, -1, CURRENT_TIMESTAMP), null);
UPDATE APP_DB.customers SET address = '24 Dbt Street', postcode = 24710, updated_at = DATEADD(DAY, -1, CURRENT_TIMESTAMP) WHERE customerid = 4;
UPDATE APP_DB.customers SET deleted_at = DATEADD(DAY, -1, CURRENT_TIMESTAMP) WHERE customerid = 1;


-- Schema: RAW_DB
CRAETE TABLE RAW_DB.raw_customers (
    customerid integer,
    name varchar(255),
    dob date,
    gender varchar(10),
    marital_status varchar(10),
    address varchar(255),
    postcode integer,
    created_at timestamp,
    updated_at timestamp,
    deleted_at timestamp,
    etl_loaded_at timestamp
);

-- T-1 Day ETL Loads
-- Append: Changed Source Data
-- D-3
INSERT INTO RAW_DB.raw_customers SELECT *, DATEADD(DAY, -2, CURRENT_TIMESTAMP) FROM APP_DB.customers;
-- D-2
INSERT INTO RAW_DB.raw_customers SELECT *, DATEADD(DAY, -1, CURRENT_TIMESTAMP) FROM APP_DB.customers WHERE ( TO_DATE(created_at)=TO_DATE(DATEADD(DAY, -2, CURRENT_TIMESTAMP)) OR TO_DATE(updated_at)=TO_DATE(DATEADD(DAY, -2, CURRENT_TIMESTAMP)) OR TO_DATE(deleted_at)=TO_DATE(DATEADD(DAY, -2, CURRENT_TIMESTAMP)) );
-- D-1
INSERT INTO RAW_DB.raw_customers SELECT *, DATEADD(DAY, 0, CURRENT_TIMESTAMP) FROM APP_DB.customers WHERE ( TO_DATE(created_at)=TO_DATE(DATEADD(DAY, -1, CURRENT_TIMESTAMP)) OR TO_DATE(updated_at)=TO_DATE(DATEADD(DAY, -1, CURRENT_TIMESTAMP)) OR TO_DATE(deleted_at)=TO_DATE(DATEADD(DAY, -1, CURRENT_TIMESTAMP)) );


-- Loaded By DBT
-- Schema: STG_DB
CRAETE TABLE STG_DB.stg_customers (
    customerid integer,
    name varchar(255),
    dob date,
    gender varchar(10),
    marital_status varchar(10),
    address varchar(255),
    postcode integer,
    created_at timestamp,
    updated_at timestamp,
    deleted_at timestamp,
    etl_loaded_at timestamp,
    sf_created_at timestamp,
    sf_updated_at timestamp
);

dbt build --select stg_customers


-- Loaded By DBT
-- Schema: DWH_DB
create table STG_DB.dim_customers (
    customerid integer,
    name varchar(255),
    dob date,
    gender varchar(10),
    marital_status varchar(10),
    address varchar(255),
    postcode integer,
    created_at timestamp,
    updated_at timestamp,
    deleted_at timestamp,
    etl_loaded_at timestamp,
    sf_created_at timestamp,
    sf_updated_at timestamp
);

dbt build --select dim_customers
