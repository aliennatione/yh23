# 📘 Smart Bar AI-Stack: The Complete Guide

> **Note**: This document is auto-generated for import into Trilium Notes. It combines the Architecture, Usage, and Maintenance guides.

---

## 🏗️ Part 1: Architecture

The Smart Bar infrastructure is built on **YunoHost 12**, leveraging **Ansible** for 'Infrastructure as Code' (IaC).

### Core Components
*   **Forgejo**: Private Git server for code versioning.
*   **Dolibarr**: ERP system for sales and inventory logic.
*   **Trilium**: Knowledge Base (this system).
*   **Node-RED**: The "AI Brain" connecting Dolibarr events to automation.
*   **Headscale**: VPN Mesh for secure internal access.

### Access Control Matrix
| Access Type | Description |
| :--- | :--- |
| **Private** | Requires Login. (Default for ERP, Node-RED, Grocy) |
| **VPN-Public** | Accessible without login *only* if inside the VPN. |
| **Public** | Accessible to the open web (if port forwarded). |

> **Note**: Permissions are managed in `group_vars/all/vars.yml` via the `access: public/private` key.

### Integration Flow
1.  **Event**: A product is updated in Dolibarr.
2.  **Trigger**: Dolibarr fires a Webhook (SQL injected config).
3.  **Processing**: Node-RED receives the hook at `https://brain.bar.lan/api/doli-webhook`.
4.  **Action**: Node-RED processes the data (AI RAG or Telegram alert).

---

## 🚀 Part 2: Deployment & Recovery

### Deploying from Scratch
Run the Ansible playbook from your control node:
```bash
ansible-playbook site.yml
```

### Updates & Maintenance
*   **Update Themes**: `ansible-playbook site.yml --tags "theme"`
*   **Verify Backups**: Check `/home/yunohost.backup/archives/` before major changes.
*   ** Disaster Recovery**: Use the `roles/backup` tag to create snapshots.

---

## 🎨 Part 3: Customization

### Themes
We use a custom "Neon/Cyberpunk" aesthetic.
*   **Portal**: CSS injected via `hooks` into SSOWat assets.
*   **Trilium**: Use the `SmartBarTheme` note (CSS).

### Manual configurations
Some settings cannot be automated safely:
1.  **Trilium Public Share**: You are reading this! This note must be set to "Shared" in Trilium attributes.
2.  **Grocy Dark Mode**: Enable in User Settings.

---

## ❓ Part 4: Troubleshooting

*   **VPN Issues**: Check `headscale` status on the Alpha node.
*   **Webhooks**: Verify Dolibarr `llx_webhook` table if events rely on it.
*   **Ansible Vault**: If variables are encrypted, use `--ask-vault-pass`.
