# Contributing to Smart Bar Cortex

First off, thanks for taking the time to contribute! 🎉

The following is a set of guidelines for contributing to Smart Bar Cortex. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## 🛠️ Development Workflow

1.  **Fork the repository**.
2.  **Clone your fork** locally.
3.  **Create a branch** for your feature or fix (`git checkout -b feature/amazing-feature`).
4.  **Make your changes**.
    *   Ensure your code is **idempotent**.
    *   Follow the existing **Ansible role structure**.
    *   Test your changes on a virtualized YunoHost instance if possible.
5.  **Commit your changes** (`git commit -m 'Add some amazing feature'`).
6.  **Push to the branch** (`git push origin feature/amazing-feature`).
7.  **Open a Pull Request**.

## 📐 Coding Standards

### Ansible
*   **Idempotency**: Every task must be able to run multiple times without side effects.
*   **Check First**: Use `command` or `shell` checking (e.g., `yunohost app list --json`) before attempting installs.
*   **Variables**: Use `group_vars` for global configuration. Avoid hardcoding paths or domains in roles.
*   **Tags**: Tag your roles appropriately (e.g., `tags: ['apps', 'forgejo']`) to allow partial deployments.

### Security
*   **Secrets**: NEVER commit plain text passwords. Always use `ansible-vault` for `group_vars/all/secrets.yml`.
*   **Permissions**: Follow the "Least Privilege" principle. Use the `sso_security` role to manage YunoHost permissions explicitly.

## 📝 Documentation

*   Update `README.md` if you change the project structure.
*   Update `docs/MANUAL_STEPS.md` if your change requires manual intervention after deployment.
*   If you add a new role, document its purpose in `docs/ARCHITECTURE.md`.

## 🤝 Community

*   Be respectful and inclusive.
*   Provide constructive feedback in Code Reviews.
*   If you find a security vulnerability, please open a Draft PR or contact the maintainers directly instead of opening a public issue.

Thank you for building with us!
