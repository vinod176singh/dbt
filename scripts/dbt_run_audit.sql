CREATE TABLE IF NOT EXISTS dbt_run_audit (
    model_name STRING,
    model_path STRING,
    status STRING,
    execution_time FLOAT,
    run_started_at TIMESTAMP,
    run_completed_at TIMESTAMP,
    materialization STRING,
    dbt_version STRING,
    invocation_id STRING
);