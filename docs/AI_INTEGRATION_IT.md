# Guida Integrazione AI

Il **Smart Bar Cortex** ora include un Gateway AI dual-mode alimentato da Google Gemini (Free Tier). Questo permette sia agli operatori business che agli sviluppatori tecnici di interagire con il sistema usando linguaggio naturale.

## 🧠 Il Gateway AI

Il gateway è un flusso Node-RED (`ai_gateway.json`) che espone due endpoint REST.

### Configurazione Chiave API
> [!IMPORTANT]
> Devi fornire una Google Gemini API Key.
1.  Ottieni una chiave da [Google AI Studio](https://aistudio.google.com/app/apikey).
2.  Aggiungila alle variabili d'ambiente di Node-RED o modifica il nodo `Prepare Gemini Request` nell'editor del flusso.
    *   *Raccomandato*: Aggiungi `GEMINI_API_KEY=tua_chiave` a `/etc/systemd/system/nodered.service.d/override.conf` (richiede passaggio admin manuale).

## 👥 Modalità d'Uso

### 1. Modalità Operatore
*   **Utenti Target**: Baristi, Manager.
*   **Endpoint**: `/api/ai/operator` (POST)
*   **Contesto**: Assistente utile, focalizzato su inventario (Grocy), relazioni (Monica), e ordini (Dolibarr).
*   **Esempio**:
    ```bash
    curl -X POST http://brain.bar.lan/api/ai/operator -d '{"prompt": "Come aggiungo un nuovo cliente al programma fedeltà?"}'
    ```

### 2. Modalità Sviluppatore
*   **Utenti Target**: DevOps, Sysadmin.
*   **Endpoint**: `/api/ai/dev` (POST)
*   **Contesto**: Esperto tecnico, capisce Ansible, log Linux e JSON.
*   **Esempio**:
    ```bash
    curl -X POST http://brain.bar.lan/api/ai/dev -d '{"prompt": "Spiega la strategia di backup in site.yml"}'
    ```

## 🔄 Cambiare Provider
Attualmente configurato per **Google Gemini 1.5 Flash**.
Per passare a OpenAI/Ollama, modifica il nodo `Prepare Gemini Request` in Node-RED per cambiare URL API e formato payload.
