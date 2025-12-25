# 🧠 Smart Bar Cortex (Italiano)

> [🇬🇧 English Version](README.md)

![Stato](https://img.shields.io/badge/Status-Production%20Ready-green)
![Ansible](https://img.shields.io/badge/Ansible-2.14+-red)
![YunoHost](https://img.shields.io/badge/YunoHost-12.x-blue)

Il "Business OS" completo per l'ecosistema Smart Bar. Questo playbook orchestra il deployment di uno stack server integrato con AI su YunoHost.

## 🌟 Funzionalità

*   **⚡ Deployment Automatizzato**: Installazione in un click per **Forgejo**, **Trilium**, **Dolibarr**, **Grocy**, **Node-RED** e **Monica**.
*   **🎨 Esperienza Personalizzata**:
    *   **Portale**: Tema Neon/Cyberpunk con hook di persistenza.
    *   **App**: Dark mode pre-configurata per Forgejo & Node-RED.
*   **🧠 Ponte AI**:
    *   **Dolibarr -> Node-RED**: Webhook via SQL Injection.
    *   **Guida Pubblica**: Generazione automatizzata documentazione per Trilium.
*   **🛡️ Sicuro & Resiliente**:
    *   **Permessi Zero-Trust**: Controllo granulare "Privato vs VPN-Pubblico" via variabili Ansible.
    *   **Vault**: Supporto per segreti criptati.
    *   **Backup**: Snapshot pre-deploy.
    *   **Idempotenza**: Sicuro per esecuzioni ripetute.

## 📂 Struttura della Repository

```tree
smart-bar-infra/
├── ansible.cfg          # Configurazione ottimizzata per YunoHost
├── site.yml             # Playbook Master
├── inventory/           # Definizioni Host (Alpha/Test)
├── group_vars/          # Variabili globali (Domini, password)
├── assets/              # File Tema & Config Custom
│   ├── ssowat/          # Tema Portale (CSS/JS)
│   ├── forgejo/         # Tema Interfaccia Git
│   └── nodered/         # Flow & Template Impostazioni
├── roles/               # Logica Applicativa
│   ├── common/          # Dipendenze (jq, curl)
│   ├── yunohost_portal/ # Temi & Config
│   ├── forgejo/         # Server Git
│   ├── bridge_config/   # Integrazioni
│   └── ...
├── deploy.sh            # Script helper per il deployment
├── docs/                # Documentazione Dettagliata
│   ├── ARCHITECTURE.md  # Design Tecnico
│   └── MANUAL_STEPS.md  # Azioni Manuali Post-Installazione
└── README_IT.md         # Questo file
```

## 🚀 Guida Rapida

### Prerequisiti
*   Ansible installato sulla tua macchina locale.
*   Accesso SSH al tuo server YunoHost (`admin@tuo-ip`).

### 1. Configura Inventory
Aggiorna `inventory/hosts.ini` (copia da `inventory/hosts.example.ini` se necessario):
```ini
[alpha]
my-server.lan ansible_host=192.168.1.50 ansible_user=admin
```

### 2. Cifra i Segreti
È fondamentale cifrare il file delle password prima dell'uso in produzione:
```bash
ansible-vault encrypt group_vars/all/secrets.yml
```

### 3. Esegui il Deployment
Usa lo script helper incluso:
```bash
./deploy.sh
```
Oppure manualmente:
```bash
ansible-playbook site.yml --ask-vault-pass
```

Per aggiornare solo i temi visuali:
```bash
ansible-playbook site.yml --tags "theme"
```

## 🔍 Verifica & Idempotenza
Questo playbook segue il pattern **"Check First, Install Later"**:
1.  Interroga `yunohost app list --json`.
2.  Installa/Aggiorna solo se mancante.
3.  Le operazioni SQL usano `ON DUPLICATE KEY UPDATE` per prevenire errori in riesecuzioni.

**Verificato funzionante su:** YunoHost 12 / Debian 12 (Bookworm).

## 📚 Documentazione
*   [Panoramica Architettura](docs/ARCHITECTURE.md)
*   [Passaggi Manuali](docs/MANUAL_STEPS.md)
*   [Guida per Contribuire](CONTRIBUTING_IT.md)
