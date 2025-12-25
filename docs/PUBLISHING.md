# Publishing Documentation to GitHub Pages

This documentation is built with **MkDocs**. You can host it for free on GitHub Pages.

## Prerequisites
*   A GitHub repository.
*   Admin permissions on the repo (to enable Pages).

## Automatic Method (GitHub Actions)

1.  Create a file `.github/workflows/docs.yml` in your repository with the following content:

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

2.  Push this file to your `main` branch.
3.  Go to GitHub > Settings > Pages.
4.  Ensure "Source" is set to the `gh-pages` branch (it will be created automatically by the workflow).

## Manual Method

If you have Python installed locally:

1.  Install MkDocs and Material theme:
    ```bash
    pip install mkdocs-material
    ```
2.  Build and deploy:
    ```bash
    mkdocs gh-deploy
    ```

Your site will be live at `https://<your-username>.github.io/<repo-name>/`.
