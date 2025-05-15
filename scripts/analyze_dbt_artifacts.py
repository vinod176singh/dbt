import json
import pandas as pd
from pathlib import Path

# Set paths to artifact files
target_path = Path('target')
manifest_file = target_path / 'manifest.json'
run_results_file = target_path / 'run_results.json'

# Load JSON files
with open(manifest_file, 'r') as f:
    manifest = json.load(f)

with open(run_results_file, 'r') as f:
    run_results = json.load(f)

# Look up nodes from manifest
nodes = manifest.get('nodes', {})

# Extract run results
results = run_results.get('results', [])
metadata = run_results.get('metadata', {})

# Combine metadata with node info
combined_data = []

for result in results:
    unique_id = result.get('unique_id')
    node = nodes.get(unique_id, {})
    
    combined_data.append({
        'model': node.get('name'),
        'resource_type': node.get('resource_type'),
        'status': result.get('status'),
        'execution_time_sec': result.get('execution_time'),
        'tags': ','.join(node.get('tags', [])),
        'description': node.get('description', ''),
        'run_started_at': metadata.get('start'),
        'run_ended_at': metadata.get('end')
    })

# Convert to DataFrame for reporting
df = pd.DataFrame(combined_data)

# Print summary
print(df[['model', 'status', 'execution_time_sec']])
print("\n✅ Run Summary:")
print(df['status'].value_counts())
