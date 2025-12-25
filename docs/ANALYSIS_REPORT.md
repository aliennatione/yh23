# 🧐 Self-Analysis & Improvement Plan

## Analysis of Current Solution

| Requirement | Implementation Status | Quality Check | Gap / Risk |
| :--- | :--- | :--- | :--- |
| **Idempotency** | ✅ Implemented | High | `yunohost app list` checks are robust. |
| **Logic Bridge** | ✅ Implemented | Medium | SQL injection for Dolibarr assumes DB name is `dolibarr`. **Risk:** Installation might use `dolibarr_2`. |
| **Customization** | ✅ Implemented | Medium | Theme Assets are copied once. **Risk:** YunoHost updates could overwrite `/usr/share/ssowat` assets. |
| **Dev Stack** | ✅ Implemented | High | Repo creation via API is safe. Admin creation uses CLI which might vary path. |
| **Documentation** | ✅ Implemented | High | Comprehensive. |

## Proposed Improvements ("Senior Architect" Touches)

### 1. Dynamic Dolibarr Configuration
**Issue:** Hardcoded database name `dolibarr` in `roles/bridge_config/tasks/main.yml`.
**Fix:** Use `yunohost app setting dolibarr mysql_db` to retrieve the actual database name before running SQL queries.

### 2. Upgrade-Proof Theming (Persistence)
**Issue:** YunoHost system updates often reset the SSOWat portal assets.
**Fix:** Install a **YunoHost Hook** (`post_app_upgrade` or similar) that automatically re-applies the custom CSS after an update.

### 3. Safer Forgejo Execution
**Issue:** Assuming `forgejo` binary path.
**Fix:** Use `yunohost app shell forgejo` or locate binary dynamically.

## Action Plan
1.  **Refactor `bridge_config`**: Add task to fetch db name.
2.  **Create `hooks` role**: Deploy a bash script to `/etc/yunohost/hooks.d/` to ensure the theme survives SWAT updates.
