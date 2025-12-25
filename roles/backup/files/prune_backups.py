#!/usr/bin/env python3
import json
import subprocess
import sys

KEEP_COUNT = 3

def get_backups():
    try:
        result = subprocess.run(['yunohost', 'backup', 'list', '--output-as', 'json'], capture_output=True, text=True, check=True)
        return json.loads(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error listing backups: {e}", file=sys.stderr)
        sys.exit(1)

def delete_backup(backup_id):
    print(f"Deleting backup: {backup_id}")
    try:
        subprocess.run(['yunohost', 'backup', 'delete', backup_id], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error deleting backup {backup_id}: {e}", file=sys.stderr)

def main():
    backups = get_backups()
    
    # YunoHost returns a dict where keys are archive names/IDs or a list of dicts. 
    # Usually it's a list or dict. Let's inspect the structure. 
    # Based on standard YunoHost, it returns a list of objects or a dict of objects.
    # We'll normalize to a list of (timestamp, id).
    
    backup_list = []
    
    if isinstance(backups, dict):
        backups = backups.get('backups', backups) # Handle potential wrapper
    
    if isinstance(backups, dict):
        # iterate keys
        for bid, data in backups.items():
            backup_list.append({'id': bid, 'created_at': data.get('created_at', 0)})
    elif isinstance(backups, list):
         backup_list = backups
    
    # Sort by created_at descending (newest first)
    # created_at might be timestamp or string. YunoHost uses unix timestamp usually.
    backup_list.sort(key=lambda x: x.get('created_at', 0), reverse=True)
    
    if len(backup_list) <= KEEP_COUNT:
        print(f"No pruning needed. Found {len(backup_list)} backups (Keep: {KEEP_COUNT}).")
        return

    to_delete = backup_list[KEEP_COUNT:]
    for b in to_delete:
        # Check if 'id' key exists, otherwise maybe the list item itself is the ID? 
        # But 'yunohost backup list --json' usually gives structured data.
        bid = b.get('id')
        if not bid:
             # Fallback if structure is different
             continue
        delete_backup(bid)

if __name__ == "__main__":
    main()
