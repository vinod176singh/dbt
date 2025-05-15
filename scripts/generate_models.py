import pandas as pd
import os

# Path to the CSV metadata file
csv_path = 'data/dimension_metadata.csv'

# Read CSV
df = pd.read_csv(csv_path)

# Output directory for generated models
output_dir = 'models/dynamic'

# Create the folder if it doesn't exist
os.makedirs(output_dir, exist_ok=True)

# Loop over rows and generate .sql files
for _, row in df.iterrows():
    model_name = row['model_name']
    source_table = row['source_table']
    columns = row['columns']
    
    database, table = source_table.split('.')
    
    sql_content = f"""-- Auto-generated model: {model_name}
{{{{ config(materialized='table') }}}}

SELECT {columns}
FROM {{{{ source('{database}', '{table}') }}}}
"""

    with open(f"{output_dir}/{model_name}.sql", "w") as f:
        f.write(sql_content.strip())

print("✅ Model files generated successfully!")
