from dotenv import load_dotenv
import os
import subprocess
import sys

# Default to dev if not provided
env = sys.argv[1] if len(sys.argv) > 1 else "dev"
env_file = f".env.{env}"

if not os.path.exists(env_file):
    print(f"ERROR: {env_file} does not exist.")
    sys.exit(1)

load_dotenv(dotenv_path=env_file)

# Optional: print which env you're running
print(f"Running dbt in {env.upper()} environment...")

subprocess.run(["dbt", "run"])
