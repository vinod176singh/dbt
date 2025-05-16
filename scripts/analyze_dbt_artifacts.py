import json
from datetime import datetime

# Load JSON files
with open('target/run_results.json') as f:
    run_results = json.load(f)

with open('target/manifest.json') as f:
    manifest = json.load(f)

# Extract summary of run results
def summarize_run_results():
    models = [r for r in run_results['results'] if r['unique_id'].startswith('model.')]
    tests = [r for r in run_results['results'] if r['unique_id'].startswith('test.')]

    summary = {
        'models_total': len(models),
        'models_success': sum(1 for m in models if m['status'] == 'success'),
        'models_failed': sum(1 for m in models if m['status'] == 'error'),
        'tests_total': len(tests),
        'tests_passed': sum(1 for t in tests if t['status'] == 'pass'),
        'tests_failed': sum(1 for t in tests if t['status'] == 'fail'),
    }

    return summary

# Map failed tests to models
def map_failed_tests_to_models():
    failed_tests_info = []

    for r in run_results['results']:
        if r['unique_id'].startswith('test.') and r['status'] == 'fail':
            test_id = r['unique_id']
            test_node = manifest['nodes'].get(test_id)

            if test_node:
                # Get the model dependencies this test depends on
                depends_on = test_node.get('depends_on', {}).get('nodes', [])
                model_names = [
                    manifest['nodes'][dep]['name']
                    for dep in depends_on if dep.startswith('model.') and dep in manifest['nodes']
                ]

                failed_tests_info.append({
                    'test_name': test_node['name'],
                    'failing_models': model_names
                })

    return failed_tests_info

# Output the summary
if __name__ == "__main__":
    result = summarize_run_results()
    print("=== DBT Run Summary ===")
    for k, v in result.items():
        print(f"{k}: {v}")

    print("\n=== Failed Tests and Related Models ===")
    failed_tests = map_failed_tests_to_models()
    for t in failed_tests:
        print(f"Test '{t['test_name']}' failed on models: {', '.join(t['failing_models'])}")
