# Pubblicare la Documentazione su GitHub Pages

Questa documentazione è costruita con **MkDocs**. Puoi pubblicarla gratuitamente su GitHub Pages.

## Prerequisiti
*   Una repository GitHub.
*   Permessi di amministrazione sulla repo (per attivare Pages).

## Metodo Automatico (GitHub Actions)

1.  Crea un file `.github/workflows/docs.yml` nella tua repository con questo contenuto:

```yaml
name: Publish Docs
on:
  push:
    branches:
      - main
permissions:
  contents: write
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v4
        with:
          python-version: 3.x
      - run: pip install mkdocs-material
      - run: mkdocs gh-deploy --force
```

2.  Pusha il file sulla branch `main`.
3.  Vai su GitHub > Settings > Pages.
4.  Assicurati che "Source" sia impostato su `gh-pages` branch (verrà creata automaticamente dal workflow).

## Metodo Manuale

Se hai Python installato localmente:

1.  Installa MkDocs e il tema Material:
    ```bash
    pip install mkdocs-material
    ```
2.  Costruisci e deploya:
    ```bash
    mkdocs gh-deploy
    ```

Il tuo sito sarà visibile su `https://<tuo-username>.github.io/<nome-repo>/`.
