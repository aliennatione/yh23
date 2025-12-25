# 🔧 Guida Risoluzione Problemi (Troubleshooting)

## Problemi Comuni di Deployment

### 1. Ansible "Permission Denied"
**Sintomo:** Ansible fallisce la connessione all'host.
**Soluzione:**
*   Assicurati che la chiave SSH sia aggiunta: `ssh-add ~/.ssh/id_rsa`.
*   Verifica di poter accedere via SSH manualmente: `ssh admin@tuo-dominio.lan`.
*   Controlla che `ansible.cfg` punti alla chiave privata corretta se non è quella di default.

### 2. "App already installed" (Idempotenza)
**Sintomo:** Il playbook fallisce sull'installazione app.
**Soluzione:**
*   I ruoli usano `yunohost app list` per controllare lo stato.
*   Se il controllo fallisce, assicurati che l'utente abbia permessi sudo.
*   Prova a eseguire con `-vvv` per vedere l'output JSON del controllo.

### 3. Webhook Dolibarr non partono
**Sintomo:** Aggiornamenti in Dolibarr non attivano Node-RED.
**Soluzione:**
*   Controlla i log Dolibarr: `Home > Strumenti Admin > Log`.
*   Verifica che il modulo sia abilitato in `Home > Setup > Moduli`.
*   Testa manualmente l'endpoint Node-RED:
    ```bash
    curl -X POST https://brain.bar.lan/api/doli-webhook -d '{"test":true}'
    ```
*   Rilancia il tag bridge: `ansible-playbook site.yml --tags "bridge"`

### 4. Tema Custom non appare
**Sintomo:** Il portale appare con il tema di default.
**Soluzione:**
*   Pulisci cache browser (Ctrl+F5).
*   Verifica che `/etc/ssowat/conf.json.persistent` contenga `"theme": "smartbar"`.
*   Riavvia SSOwat/Nginx: `sudo systemctl restart nginx`.

## Specifiche SSOWat / Portale
Se il tema "Neon" blocca il box di login:
*   Modifica `/usr/share/ssowat/portal/assets/themes/smartbar/custom_portal.css`.
*   Assicurati che lo z-index di `.sso-panel` sia positivo.

## Node-RED "502 Bad Gateway"
*   Comune su installazioni fresche. Attendi 30-60s affinché il servizio Node-RED si avvii completamente.
*   Controlla log: `journalctl -u nodered -f`.
