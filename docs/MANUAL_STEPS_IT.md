# Passaggi di Personalizzazione Manuale

Mentre Ansible automatizza il 95% dell'infrastruttura, alcune personalizzazioni specifiche richiedono un intervento manuale a causa di strutture database interne o mancanza di API CLI.

## Trilium Notes - Tema Personalizzato

Trilium usa un sistema interno di "Note" per i temi. Non possiamo iniettarli facilmente via SQL senza rischiare la corruzione del DB.

### Passaggi per applicare "Smart Bar Dark":

1.  **Login** alla tua istanza Trilium (es. `https://wiki.bar.lan`).
2.  **Crea una Nuova Nota**:
    *   Titolo: `SmartBarTheme`
    *   Tipo: `Code` (Seleziona "CSS" dal menu a tendina nell'editor).
3.  **Aggiungi Attributi** (Pannello "Attributes" in alto a destra):
    *   Aggiungi etichetta: `#appTheme`
    *   Valore per etichetta: `smartbar`
4.  **Incolla Contenuto CSS**:
    Copia il contenuto qui sotto nella nota:

```css
:root {
    --main-background-color: #0f0f1b;
    --main-text-color: #e0e0e0;
    --left-pane-background-color: #16213e;
    --left-pane-text-color: #e0e0e0;
    --accent-color: #00d2ff;
}

body {
    background-color: var(--main-background-color);
    color: var(--main-text-color);
}

.tree-node:hover {
    background-color: #1a1a2e;
}

.ribbon-tab-title.active {
    border-bottom: 2px solid var(--accent-color);
}
```

5.  **Attiva**:
    *   Vai su **Options** (Menu in alto a sinistra) -> **Appearance**.
    *   Seleziona `smartbar` dal menu a tendina Theme.
    *   Ricarica la pagina.

### Passaggi per Pubblicare "Project Guide":

1.  **Crea una Nota Root**:
    *   Titolo: `Smart Bar Guide`
    *   Contenuto: Copia/Incolla contenuto da `docs/PROJECT_MANUAL_FOR_TRILIUM.md`.
2.  **Abilita Accesso Pubblico**:
    *   Clicca l'icona **"Share"** (in alto a destra) o "Attributes".
    *   Aggiungi attributo: `promoted` (Promuovi a sito pubblico) o attiva l'interruttore "Share this note".
    *   (Opzionale) Imposta un "Custom URL alias" come `guide`.
3.  **Verifica**:
    *   Visita `https://wiki.bar.lan/share/guide` (o il tuo URL pubblico equivalente).

## Grocy - Dark Mode

Grocy ha un'impostazione Dark Mode integrata per utente.
1.  Login come admin.
2.  Vai su **User Settings** (Icona chiave inglese in alto a destra).
3.  Spunta "Dark Mode".
