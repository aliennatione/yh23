# Strategie di Testing & Workflow

Questo progetto è progettato per essere flessibile, supportando sia deployment "Greenfield" (nuova installazione) che "Brownfield" (server esistente).

## 1. Contesto: Lo Stack "Intranet"
Assumiamo che molti utenti (come te) stiano eseguendo lo stack **Headscale + AdGuard + YunoHost** descritto in [questa guida della community](https://forum.yunohost.org/t/create-your-intranet-with-a-vpn-and-your-own-dns-with-yunohost-adguard-and-headscale/37393).

**Conferma Compatibilità:**
*   Questo playbook Ansible opera principalmente a **Livello Applicativo** (installazione app, configurazione temi).
*   **NON** modifica la tua interfaccia `wg0`, le rotte Headscale o le impostazioni DNS AdGuard.
*   **Sicuro da eseguire**: È perfettamente sicuro lanciare questo playbook sul tuo VPS "Intranet" esistente, a patto di seguire i passaggi di sicurezza qui sotto.

## 2. Scenari di Test

### Scenario A: Test Non Distruttivo (VPS Esistente)
Hai un VPS di produzione/lab funzionante e vuoi aggiungere le funzionalità Smart Bar senza romperlo.

**Protocollo di Sicurezza:**
1.  **Snapshot del Provider (Altamente Raccomandato)**:
    Prima di lanciare Ansible, vai nella console del tuo provider (es. Hetzner Cloud Console) e fai uno **Snapshot** del server.
    *   *Perché?* Se Ansible rompe qualcosa, puoi revertire l'intero stato del disco in pochi minuti.
    *   *Costo:* Solitamente pochi centesimi per le ore in cui lo mantieni.
2.  **Backup YunoHost (Livello App)**:
    Se non puoi fare snapshot, crea un backup locale:
    ```bash
    yunohost backup create --system --apps
    ```
3.  **Lancia Ansible**:
    ```bash
    ansible-playbook site.yml --tags "apps,theme"
    ```
    *   *Suggerimento*: Usa i tag per limitare lo scopo inizialmente.

### Scenario B: Test Pulito (Hetzner Effimero)
Per testare rigorosamente il processo di bootstrap completo senza rischi per il tuo server principale.

**Workflow:**
1.  **Crea un nuovo VPS** (es. istanza CX22 su Hetzner).
    *   *Strategia Costi*: Hetzner fattura a ore. Un test di 2 ore costa < $0.02.
2.  **Installa YunoHost**:
    ```bash
    curl https://install.yunohost.org | bash
    ```
    *(Salta il wizard post-install se vuoi automatizzarlo, o completalo velocemente via web).*
3.  **Configura Inventory Ansible**:
    Aggiungi il nuovo IP a `inventory/hosts.ini` sotto un gruppo `[test]`.
4.  **Esegui Playbook Completo**:
    ```bash
    ansible-playbook site.yml -i inventory/hosts.ini --limit test
    ```
5.  **Distruggi**:
    Cancella il server immediatamente dopo il test per fermare la fatturazione.

## 3. Strategie di Backup & Ripristino

### Per Preservare lo Stato
Se vuoi "congelare" lo stato del tuo VPS attuale per provare qualcosa di sperimentale e poi tornare indietro:

**Metodo 1: Il "Fork" (Snapshot & Restore)**
1.  Spegni il tuo VPS principale.
2.  Fai uno Snapshot.
3.  "Create Server" da quello Snapshot (Clone).
4.  Testa sul Clone.
5.  Se successo, applica le modifiche al Main. Se fallito, cancella il Clone.

**Metodo 2: Archivi YunoHost**
Utile se vuoi spostare la configurazione "Smart Bar" su un nuovo server.
1.  **Backup**:
    ```bash
    yunohost backup create --apps forgejo,trilium,nodered,dolibarr --label pre-smartbar-test
    ```
2.  **Download**:
    `scp admin@tuo-ip:/home/yunohost.backup/archives/pre-smartbar-test.tar .`
3.  **Restore (su target)**:
    `yunohost backup restore pre-smartbar-test`

## 4. Risoluzione Conflitti Intranet
Se usi il dominio VPN (es. `vpn.bar.lan`) per le app:
*   Assicurati che le variabili in `group_vars/all/vars.yml` corrispondano ai record DNS Headscale.
*   Se Ansible fallisce a risolvere i domini, aggiungi i mapping IP al tuo `/etc/hosts` locale temporaneamente o usa la variabile `ansible_host` nell'inventory.
