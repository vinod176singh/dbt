import os
import yaml

CONFIG_PATH = "config/dimension_metadata.yml"
OUTPUT_DIR = "models/dimensions"

TEMPLATE = """{{{{ config(materialized='table') }}}}

{{{{ generate_dimension_model(
    source_table='{source_table}',
    columns='{columns}',
    filter="{filter}"
) }}}}
"""

# Load YAML
with open(CONFIG_PATH, "r") as file:
    dimensions = yaml.safe_load(file)

# Create model files
os.makedirs(OUTPUT_DIR, exist_ok=True)

for dim in dimensions:
    filename = f"{dim['table_name']}.sql"
    file_path = os.path.join(OUTPUT_DIR, filename)

    content = TEMPLATE.format(
        source_table=dim["source_table"],
        columns=dim["columns"],
        filter=dim["filter"].replace('"', '\\"')  # escape double quotes
    )

    with open(file_path, "w") as f:
        f.write(content)

    print(f"✅ Generated: {file_path}")
