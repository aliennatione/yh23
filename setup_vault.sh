#!/bin/bash
# Helper script to encrypt sensitive vars
# Usage: ./setup_vault.sh

echo "Enter your Vault Password (this will be used to encrypt 'vault_pass'):"
read -s VAULT_PASS
echo $VAULT_PASS > .vault_pass

echo "Encrypting secrets.yml..."
ansible-vault encrypt group_vars/all/secrets.yml --vault-password-file .vault_pass

echo "Vault setup complete. Use '--vault-password-file .vault_pass' when running ansible-playbook."
