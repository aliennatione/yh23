# Manual Customization Steps

While Ansible automates 95% of the infrastructure, some application-specific customizations require manual intervention due to internal database structures or lack of CLI APIs.

## Trilium Notes - Custom Theme

Trilium uses an internal "Note" system for themes. We cannot easily inject this via SQL without risking database corruption.

### Steps to Apply "Smart Bar Dark":

1.  **Login** to your Trilium instance (e.g., `https://wiki.bar.lan`).
2.  **Create a New Note**:
    *   Title: `SmartBarTheme`
    *   Type: `Code` (Select "CSS" from the dropdown in the editor).
3.  **Add Attributes** (Top right "Attributes" panel):
    *   Add label: `#appTheme`
    *   Value for label: `smartbar`
4.  **Paste CSS Content**:
    Copy the content below into the note:

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

5.  **Activate**:
    *   Go to **Options** (Menu top left) -> **Appearance**.
    *   Select `smartbar` from the Theme dropdown.
    *   Reload the page.

### Steps to Publish "Project Guide":

1.  **Create a Root Note**:
    *   Title: `Smart Bar Guide`
    *   Content: Copy/Paste content from `docs/PROJECT_MANUAL_FOR_TRILIUM.md`.
2.  **Enable Public Access**:
    *   Click the **"Share"** icon (top right) or "Attributes".
    *   Add attribute: `promoted` (Promote to public site) or toggle "Share this note" switch.
    *   (Optional) Set a "Custom URL alias" like `guide`.
3.  **Verify**:
    *   Visit `https://wiki.bar.lan/share/guide` (or your equivalent public URL).

## Grocy - Dark Mode

Grocy has a built-in Dark Mode setting per user.
1.  Login as admin.
2.  Go to **User Settings** (Top right wrench icon).
3.  Check "Dark Mode".
