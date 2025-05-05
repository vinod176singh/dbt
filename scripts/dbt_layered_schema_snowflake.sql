
CREATE OR REPLACE SCHEMA bronze;

CREATE OR REPLACE TABLE bronze.raw_customers (
    customer_id INT,
    first_name STRING,
    last_name STRING,
    email STRING,
    signup_date DATE,
    raw_region STRING
);


CREATE OR REPLACE SCHEMA silver;

CREATE OR REPLACE TABLE silver.refined_customers (
    customer_id INT,
    email STRING,
    signup_date DATE,
    full_name STRING,
    region STRING
);


CREATE OR REPLACE SCHEMA gold;

CREATE OR REPLACE TABLE gold.customer_summary (
    region STRING,
    customer_count INT
);
