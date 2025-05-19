import json
import pandas as pd
import snowflake.connector
from datetime import datetime

# === Load dbt artifacts ===
with open('target/run_results.json') as rr_file:
    run_results = json.load(rr_file)

with open('target/manifest.json') as mf_file:
    manifest = json.load(mf_file)

invocation_id = run_results['metadata']['invocation_id']

# === Connect to Snowflake ===
conn = snowflake.connector.connect(
    user='vinods',
    password='Dallas@#Anblicks2025',
    account='ANBLICKSORG-ANBLICKSPARTNER',
    warehouse='demo_wh',
    database='cellular_sales',
    schema='bronze',
    role='sysadmin',
    client_session_keep_alive=False
)

cs = conn.cursor()

# === Check if this run was already logged ===
cs.execute("SELECT COUNT(*) FROM dbt_run_audit WHERE invocation_id = %s", (invocation_id,))
if cs.fetchone()[0] > 0:
    print(f"⚠️ Already logged run with invocation_id: {invocation_id}")
    cs.close()
    conn.close()
    exit()

# === Build audit log records ===
audit_logs = []
for result in run_results['results']:
    unique_id = result['unique_id']
    node = manifest['nodes'].get(unique_id, {})

    audit_logs.append({
        'model_name': node.get('name', ''),
        'model_path': node.get('original_file_path', ''),
        'status': result['status'],
        'execution_time': result['execution_time'],
        'run_started_at': run_results['metadata']['generated_at'],
        'run_completed_at': datetime.utcnow().isoformat(),
        'materialization': node.get('config', {}).get('materialized', ''),
        'dbt_version': run_results['metadata']['dbt_version'],
        'invocation_id': invocation_id
    })

df = pd.DataFrame(audit_logs)

# === Insert new audit records ===
for _, row in df.iterrows():
    cs.execute("""
        INSERT INTO dbt_run_audit (
            model_name, model_path, status, execution_time,
            run_started_at, run_completed_at,
            materialization, dbt_version, invocation_id
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, tuple(row))

cs.close()
conn.close()

print(f"✅ Logged {len(df)} rows for invocation_id: {invocation_id}")
