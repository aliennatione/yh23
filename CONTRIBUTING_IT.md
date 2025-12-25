# Contribuire a Smart Bar Cortex

Grazie per il tuo interesse nel contribuire! 🎉

Queste sono linee guida per contribuire allo sviluppo di Smart Bar Cortex. Sentiti libero di proporre modifiche a questo documento tramite una Pull Request.

## 🛠️ Flusso di Sviluppo (Workflow)

1.  **Forka la repository**.
2.  **Clona il tuo fork** localmente.
3.  **Crea un branch** per la tua funzionalità o fix (`git checkout -b feature/nuova-funzionalita`).
4.  **Apporta le tue modifiche**.
    *   Assicurati che il codice sia **idempotente**.
    *   Segui la struttura esistente dei **Ruoli Ansible**.
    *   Testa le modifiche su un'istanza YunoHost virtualizzata se possibile.
5.  **Committa le modifiche** (`git commit -m 'Aggiunta nuova funzionalità'`).
6.  **Pusha sul branch** (`git push origin feature/nuova-funzionalita`).
7.  **Apri una Pull Request**.

## 📐 Standard di Codice

### Ansible
*   **Idempotenza**: Ogni task deve poter essere eseguito più volte senza effetti collaterali indesiderati.
*   **Check First**: Usa comandi di controllo (es. `yunohost app list --json`) prima di tentare installazioni.
*   **Variabili**: Usa `group_vars` per la configurazione globale. Evita di scrivere percorsi o domini direttamente nel codice dei ruoli.
*   **Tags**: Tagga i tuoi ruoli appropriatamente (es. `tags: ['apps', 'forgejo']`) per permettere deployment parziali.

### Sicurezza
*   **Segreti**: NON committare MAI password in chiaro. Usa sempre `ansible-vault` per `group_vars/all/secrets.yml`.
*   **Permessi**: Segui il principio del "Least Privilege" (Minimo Privilegio). Usa il ruolo `sso_security` per gestire i permessi YunoHost esplicitamente.

## 📝 Documentazione

*   Aggiorna `README_IT.md` (e l'inglese `README.md`) se cambi la struttura del progetto.
*   Aggiorna `docs/MANUAL_STEPS.md` se la tua modifica richiede interventi manuali post-deployment.
*   Se aggiungi un nuovo ruolo, documenta il suo scopo in `docs/ARCHITECTURE.md`.

## 🤝 Comunità

*   Sii rispettoso e inclusivo.
*   Fornisci feedback costruttivi nelle Code Review.
*   Se trovi una vulnerabilità di sicurezza, contatta direttamente i maintainer o apri una Draft PR privata.

Grazie per contribuire a costruire con noi!
