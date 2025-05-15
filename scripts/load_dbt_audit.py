import json
import snowflake.connector
from datetime import datetime

# Load dbt run results JSON
with open('target/run-results.json') as f:
    run_results = json.load(f)

# Snowflake connection parameters
conn = snowflake.connector.connect(
    user='vinods',
    password='Dallas@#Anblicks2025',
    account='ANBLICKSORG-ANBLICKSPARTNER',
    warehouse='demo_wh',
    database='CELLULAR_SALES',
    schema='BRONZE',
    role='sysadmin'
)

cursor = conn.cursor()

# Extract and insert audit data
run_timestamp = datetime.utcnow()

for result in run_results['results']:
    model_name = result['unique_id'].split('.')[-1]
    status = result['status']
    execution_time = result.get('execution_time', 0)
    rows_produced = result.get('rows', 0)

    insert_query = """
        INSERT INTO cellular_sales.audit.dbt_model_audit
        (model_name, status, execution_time, rows_produced, run_timestamp)
        VALUES (%s, %s, %s, %s, %s)
    """
    cursor.execute(insert_query, (model_name, status, execution_time, rows_produced, run_timestamp))

conn.commit()
cursor.close()
conn.close()

print("Audit data loaded successfully!")
