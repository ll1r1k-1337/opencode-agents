import json
import sys
import os

def update_config(config_path, agents_dir):
    try:
        if not os.path.exists(config_path):
            print(f"Config file not found: {config_path}")
            return

        with open(config_path, 'r') as f:
            try:
                config = json.load(f)
            except json.JSONDecodeError:
                print(f"Error: {config_path} is not valid JSON. Skipping update.")
                return

        modified = False

        # Check for possible keys for agent paths
        path_keys = ['agents_path', 'agent_paths', 'agents_dir', 'agent_dirs']
        found_key = None

        for key in path_keys:
            if key in config:
                found_key = key
                break

        if found_key:
            current_paths = config[found_key]

            if isinstance(current_paths, list):
                if agents_dir not in current_paths:
                    config[found_key].append(agents_dir)
                    modified = True
                    print(f"Added '{agents_dir}' to '{found_key}' in {config_path}")
            elif isinstance(current_paths, str):
                if current_paths != agents_dir:
                    # Convert to list to support multiple paths
                    config[found_key] = [current_paths, agents_dir]
                    modified = True
                    print(f"Converted '{found_key}' to list and added '{agents_dir}' in {config_path}")
            else:
                print(f"Warning: '{found_key}' in {config_path} is of unknown type. Skipping update.")

        # If no key found, we might want to add 'agents_path' pointing to our agents_dir?
        # The prompt says "modify it if it needed". If the user has a config file but no agent path,
        # maybe they are relying on defaults. Adding it explicitly ensures our agents are found.
        # However, forcing a key might be risky if the tool doesn't support it.
        # Given the ambiguity, I will add 'agents_path' only if the config is otherwise empty
        # or if it seems appropriate. But safer is to not add if key is missing unless we know the schema.
        # I'll stick to updating existing keys for safety, as per my previous thought process.

        if modified:
            with open(config_path, 'w') as f:
                json.dump(config, f, indent=4)
            print(f"Successfully updated {config_path}")
        else:
            print(f"No changes needed for {config_path}")

    except Exception as e:
        print(f"Error updating config {config_path}: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 update_config.py <config_path> <agents_dir>")
        sys.exit(1)

    update_config(sys.argv[1], sys.argv[2])
