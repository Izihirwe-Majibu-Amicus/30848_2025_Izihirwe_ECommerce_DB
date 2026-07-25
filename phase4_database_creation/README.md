# Phase IV — Database Creation & Execution Guide

**Project:** 30848_2025_Izihirwe_ECommerce_DB
**Oracle Object Names:** PDB `PDB_30848_ECOMMERCE`, Schema Owner `ECOMM_30848_IZIHIRWE`
**Edition:** Oracle Database 21c Express Edition (XE)

## 📌 Identifier Naming Architecture
The required project folder name (`30848_2025_Izihirwe_ECommerce_DB`) begins with a numeric digit. To prevent using double-quoted case-sensitive identifiers in Oracle, letter-prefixed names (`PDB_30848_ECOMMERCE` and `ECOMM_30848_IZIHIRWE`) are used for the database objects while maintaining full directory structure alignment on GitHub.

## 🔐 Accounts and Roles Summary
* **`ECOMM_30848_IZIHIRWE`**: Schema owner (holds table definitions and logic).
* **`app_admin` / `app_staff`**: Role-based access control containers.
* **`jmugisha`**: Operational Staff account (`app_staff`).
* **`akarenzi`**: Operational Admin account (`app_admin`).

## 📜 Script Execution Flow
1. `00_check_environment.sql`: Read-only environment check.
2. `01_create_pluggable_database.sql`: PDB initialization.
3. `02_create_tablespaces.sql`: Physical storage allocation (`ECOMM_DATA`, `ECOMM_TEMP`).
4. `03_create_schema_owner.sql`: Root schema owner creation.
5. `04_create_app_roles.sql`: Application role definitions.
6. `05_create_employee_accounts.sql`: Operational user setup.
7. `06_verify_phase4.sql`: Comprehensive Phase IV verification script.