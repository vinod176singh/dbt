import json
from dbt_artifacts_parser.parser import parse_manifest, parse_run_results

# Load and parse manifest.json
with open('target/manifest.json') as f:
    manifest_data = json.load(f)
manifest = parse_manifest(manifest_data)

# Load and parse run_results.json
with open('target/run_results.json') as f:
    run_results_data = json.load(f)
run_results = parse_run_results(run_results_data)

# Example: Print the number of models and tests
model_count = sum(1 for node in manifest.nodes.values() if node.resource_type == 'model')
test_count = sum(1 for node in manifest.nodes.values() if node.resource_type == 'test')

print(f"Number of models: {model_count}")
print(f"Number of tests: {test_count}")

# Example: Print the status of each run result
for result in run_results.results:
    print(f"{result.unique_id}: {result.status}")
