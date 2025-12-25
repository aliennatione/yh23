# Testing Strategy & Workflows

This project is designed to be flexible, supporting both "Greenfield" (clean install) and "Brownfield" (existing server) deployments.

## 1. Context: The "Intranet" Stack
We assume many users (like yourself) are running the **Headscale + AdGuard + YunoHost** stack described in [this community guide](https://forum.yunohost.org/t/create-your-intranet-with-a-vpn-and-your-own-dns-with-yunohost-adguard-and-headscale/37393).

**Compatibility Confirmation:**
*   This Ansible playbook operates primarily at the **Application Layer** (installing apps, configuring themes).
*   It does **NOT** modify your `wg0` interface, Headscale routes, or AdGuard DNS settings.
*   **Safe to Run**: It is perfectly safe to run this playbook on your existing "Intranet" VPS, provided you follow the safety steps below.

## 2. Testing Scenarios

### Scenario A: Non-Destructive Test (Existing VPS)
You have a running production/lab VPS and want to add the Smart Bar features without breaking it.

**Safety Protocol:**
1.  **Provider Snapshot (Highly Recommended)**:
    Before running Ansible, go to your VPS provider console (e.g., Hetzner Cloud Console) and take a **Snapshot** of the server.
    *   *Why?* If Ansible breaks something, you can revert the entire disk state in minutes.
    *   *Cost:* Usually pennies for the few hours you keep it.
2.  **YunoHost Backup (Application Level)**:
    If you can't snapshot, create a local backup:
    ```bash
    yunohost backup create --system --apps
    ```
3.  **Run Ansible**:
    ```bash
    ansible-playbook site.yml --tags "apps,theme"
    ```
    *   *Tip*: Use tags to limit scope initially.

### Scenario B: Clean Slate Test (Hetzner Ephemeral)
To rigorously test the full bootstrap process without risk to your main server.

**Workflow:**
1.  **Spin up a new VPS** (e.g., CX22 instance on Hetzner).
    *   *Cost Strategy*: Hetzner bills hourly. A test run of 2 hours costs < $0.02.
2.  **Install YunoHost**:
    ```bash
    curl https://install.yunohost.org | bash
    ```
    *(Skip post-install wizard if you want to automate it, or complete it quickly via web).*
3.  **Configure Ansible Inventory**:
    Add the new IP to `inventory/hosts.ini` under a `[test]` group.
4.  **Run Full Playbook**:
    ```bash
    ansible-playbook site.yml -i inventory/hosts.ini --limit test
    ```
5.  **Destroy**:
    Delete the server immediately after testing to stop billing.

## 3. Backup & Restore Strategies

### For State Preservation
If you want to "freeze" your current VPS state to try something experimental and then return:

**Method 1: The "Fork" (Snapshot & Restore)**
1.  Power down your main VPS.
2.  Take a Snapshot.
3.  "Create Server" from that Snapshot (Clone).
4.  Test on the Clone.
5.  If successful, apply changes to Main. If failed, delete Clone.

**Method 2: YunoHost Archives**
Useful if you want to move the "Smart Bar" configuration to a new server.
1.  **Backup**:
    ```bash
    yunohost backup create --apps forgejo,trilium,nodered,dolibarr --label pre-smartbar-test
    ```
2.  **Download**:
    `scp admin@your-ip:/home/yunohost.backup/archives/pre-smartbar-test.tar .`
3.  **Restore (on target)**:
    `yunohost backup restore pre-smartbar-test`

## 4. Troubleshooting Intranet Conflicts
If you use the VPN domain (e.g., `vpn.bar.lan`) for apps:
*   Ensure variables in `group_vars/all/vars.yml` match your Headscale DNS records.
*   If Ansible fails to resolve domains, add the IP mappings to your local `/etc/hosts` temporarily or use the `ansible_host` inventory variable.
