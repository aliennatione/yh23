# AI Integration Guide

The **Smart Bar Cortex** now features a dual-mode AI Gateway powered by Google Gemini (Free Tier). This allows both business operators and technical developers to interact with the system using natural language.

## 🧠 The AI Gateway

The gateway is a Node-RED flow (`ai_gateway.json`) that exposes two REST endpoints.

### API Key Setup
> [!IMPORTANT]
> You must provide a Google Gemini API Key.
1.  Get a key from [Google AI Studio](https://aistudio.google.com/app/apikey).
2.  Add it to Node-RED's environment variables or edit the `Prepare Gemini Request` node in the flow editor.
    *   *Recommended*: Add `GEMINI_API_KEY=your_key` to `/etc/systemd/system/nodered.service.d/override.conf` (requires manual admin step).

## 👥 Usage Modes

### 1. Operator Mode
*   **Target Users**: Bartenders, Managers.
*   **Endpoint**: `/api/ai/operator` (POST)
*   **Context**: Helpful assistant, focuses on inventory (Grocy), relations (Monica), and orders (Dolibarr).
*   **Example**:
    ```bash
    curl -X POST http://brain.bar.lan/api/ai/operator -d '{"prompt": "How do I add a new customer to the loyalty program?"}'
    ```

### 2. Developer Mode
*   **Target Users**: DevOps, Sysadmins.
*   **Endpoint**: `/api/ai/dev` (POST)
*   **Context**: Technical expert, understands Ansible, Linux logs, and JSON.
*   **Example**:
    ```bash
    curl -X POST http://brain.bar.lan/api/ai/dev -d '{"prompt": "Explain the backup strategy in site.yml"}'
    ```

## 🔄 Switching Providers
Currently configured for **Google Gemini 1.5 Flash**.
To switch to OpenAI/Ollama, edit the `Prepare Gemini Request` node in Node-RED to change the API URL and payload format.
