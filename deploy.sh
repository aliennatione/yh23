#!/bin/bash
# Smart Bar Cortex - Deployment Helper
# Wraps ansible-playbook with common checks and flags.

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

INVENTORY="inventory/hosts.ini"
PLAYBOOK="site.yml"
SECRETS_FILE="group_vars/all/secrets.yml"

echo -e "${GREEN}🧠 Smart Bar Cortex - Deployment Utility${NC}"
echo "=========================================="

# Check if inventory exists
if [ ! -f "$INVENTORY" ]; then
    echo -e "${RED}[ERROR] Inventory file '$INVENTORY' not found.${NC}"
    echo "Please copy 'inventory/hosts.example.ini' to '$INVENTORY' and configure it."
    exit 1
fi

# Check if secrets file exists
if [ ! -f "$SECRETS_FILE" ]; then
    echo -e "${RED}[ERROR] Secrets file '$SECRETS_FILE' not found.${NC}"
    exit 1
fi

# Check if secrets file is encrypted
if grep -q "\$ANSIBLE_VAULT;" "$SECRETS_FILE"; then
    echo -e "${YELLOW}[INFO] Secrets file is encrypted. You will be prompted for the Vault password.${NC}"
    VAULT_ARG="--ask-vault-pass"
else
    echo -e "${RED}[WARNING] Secrets file is NOT encrypted!${NC}"
    echo "It is highly recommended to run: ansible-vault encrypt $SECRETS_FILE"
    echo -e "${YELLOW}[INFO] Creating backup of cleartext secrets before proceeding...${NC}"
    cp "$SECRETS_FILE" "${SECRETS_FILE}.bak"
    VAULT_ARG=""
fi

echo -e "${GREEN}Starting Deployment...${NC}"
echo "------------------------------------------"
echo "Command: ansible-playbook $PLAYBOOK -i $INVENTORY $VAULT_ARG"
echo "------------------------------------------"

# Execute Ansible
ansible-playbook "$PLAYBOOK" -i "$INVENTORY" $VAULT_ARG "$@"

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}[SUCCESS] Deployment completed successfully!${NC}"
else
    echo -e "${RED}[FAILURE] Deployment failed with exit code $EXIT_CODE.${NC}"
fi

exit $EXIT_CODE
