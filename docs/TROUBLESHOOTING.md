# 🔧 Troubleshooting Guide

## Common Deployment Issues

### 1. Ansible "Permission Denied"
**Symptom:** Ansible fails to connect to the host.
**Fix:**
*   Ensure your SSH key is added: `ssh-add ~/.ssh/id_rsa`.
*   Verify you can SSH manually: `ssh admin@your-domain.lan`.
*   Check `ansible.cfg` points to the correct private key if not default.

### 2. "App already installed" (Idempotency)
**Symptom:** Playbook fails on app installation.
**Fix:**
*   The roles use `yunohost app list` to check status.
*   If checking fails, ensure the user has sudo rights.
*   Try running with `-vvv` to see the JSON output of the check.

### 3. Dolibarr Webhooks Not Firing
**Symptom:** Update in Dolibarr doesn't trigger Node-RED.
**Fix:**
*   Check Dolibarr logs: `Home > Admin Tools > Logs`.
*   Verify the module is enabled in `Home > Setup > Modules`.
*   Manually test the Node-RED endpoint:
    ```bash
    curl -X POST https://brain.bar.lan/api/doli-webhook -d '{"test":true}'
    ```
*   Re-run the bridge tag: `ansible-playbook site.yml --tags "bridge"`

### 4. Custom Theme Not Appearing
**Symptom:** Portal looks like default.
**Fix:**
*   Clear browser cache (Ctrl+F5).
*   Verify `/etc/ssowat/conf.json.persistent` contains `"theme": "smartbar"`.
*   Restart SSOwat/Nginx: `sudo systemctl restart nginx`.

## SSOWat / Portal Specifics
If the "Neon" theme blocks login box:
*   Edit `/usr/share/ssowat/portal/assets/themes/smartbar/custom_portal.css`.
*   Ensure `.sso-panel` z-index is positive.

## Node-RED "502 Bad Gateway"
*   Common on fresh installs. Wait 30-60s for Node-RED service to fully boot.
*   Check logs: `journalctl -u nodered -f`.
