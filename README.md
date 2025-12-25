# 🧠 Smart Bar Cortex

![Status](https://img.shields.io/badge/Status-Production%20Ready-green)
![Ansible](https://img.shields.io/badge/Ansible-2.14+-red)
![YunoHost](https://img.shields.io/badge/YunoHost-12.x-blue)

> [🇮🇹 Versione Italiana](README_IT.md) | [🤝 Contributing](CONTRIBUTING.md)

Comprehensive "Business OS" for the Smart Bar ecosystem. This playbook orchestrates the deployment of an AI-integrated server stack on YunoHost.

## 🌟 Features

*   **⚡ Automated Deployment**: One-click install for **Forgejo**, **Trilium**, **Dolibarr**, **Grocy**, **Node-RED**, and **Monica**.
*   **🎨 Custom Experience**:
    *   **Portal**: Neon/Cyberpunk theme w/ persistent hooks.
    *   **Apps**: Dark modes pre-configured for Forgejo & Node-RED.
*   **🧠 AI Bridge**:
    *   **Dolibarr -> Node-RED**: SQL-injected Webhooks.
    *   **Public Guide**: Automated documentation generation for Trilium.
*   **🛡️ Secure & Resilient**:
    *   **Zero-Trust Permissions**: Granular "Private vs VPN-Public" control via Ansible variables.
    *   **Vault**: Encrypted secrets support.
    *   **Backup**: Pre-deploy snapshots.
    *   **Idempotency**: Safe for repetitive runs.

## 📂 Repository Structure

```tree
smart-bar-infra/
├── ansible.cfg          # YunoHost-optimized config
├── site.yml             # Master Playbook
├── inventory/           # Hosts definitions (Alpha/Test)
├── group_vars/          # Global variables (Domains, passwords)
├── assets/              # Custom Theme Files & Configs
│   ├── ssowat/          # Portal Theme (CSS/JS)
│   ├── forgejo/         # Git Interface Theme
│   └── nodered/         # Flow & Settings templates
├── roles/               # Application Logic
│   ├── common/          # Dependencies (jq, curl)
│   ├── yunohost_portal/ # Theming & Config
│   ├── forgejo/         # Git Server
│   ├── bridge_config/   # Integrations
│   └── ...
└── docs/                # Detailed Documentation
    ├── ARCHITECTURE.md  # Technical Design
    └── MANUAL_STEPS.md  # Post-Install Manual Actions
```

## 🚀 Quick Start

### Prerequisites
*   Ansible installed on your local machine.
*   SSH access to your YunoHost server (`admin@your-ip`).

### 1. Configure Inventory
Update `inventory/hosts.ini`:
```ini
[alpha]
my-server.lan ansible_host=192.168.1.50 ansible_user=admin
```

### 2. Run Deployment
To deploy the full stack (Non-destructive):
```bash
ansible-playbook site.yml
```

To update only the visual themes:
```bash
ansible-playbook site.yml --tags "theme"
```

To fix/update network bridges:
```bash
ansible-playbook site.yml --tags "bridge"
```

## 🔍 Verification & Idempotency
This playbook follows the **"Check First, Install Later"** pattern:
1.  Queries `yunohost app list --json`.
2.  Installs/Updates only if missing.
3.  SQL operations use `ON DUPLICATE KEY UPDATE` to prevent errors on re-runs.

**Verified working on:** YunoHost 12 / Debian 12 (Bookworm).

## 📚 Documentation
*   [Architecture Overview](docs/ARCHITECTURE.md)
*   [Manual Customization Steps](docs/MANUAL_STEPS.md)
