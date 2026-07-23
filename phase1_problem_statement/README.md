# Phase I: Problem Statement & System Definition

## 1. Problem Definition
Small and mid-sized retail businesses that sell products online often manage sales, stock levels, and staff activity using disconnected tools—spreadsheets for inventory, a separate order log, and no real audit trail of who changed what. This creates three concrete failures:
* **Stock Discrepancies:** A sale isn't reflected in inventory in real time.
* **No Accountability:** No record of which staff member modified a price, deleted a record, or processed a refund.
* **No Controlled Write-Access Policy:** Anyone with access can modify live data at any time, including outside approved hours (e.g., during peak evening traffic when errors are costliest to fix).

## 2. Context of Use
The system models the backend database of a retail e-commerce operation:
* Customers place orders through a storefront.
* Staff fulfill and manage those orders.
* Products are sourced from suppliers and tracked in inventory.
* Every write operation against the database is logged and time-restricted according to business policy.

*Note: This is the transactional and auditing backbone that any storefront, admin panel, or reporting tool would sit on top of.*

## 3. Target Users & Access Roles
* **Customers:** Indirectly through orders placed (data lives in the system; no direct DB access).
* **Sales/Fulfillment Staff (`app_staff` role):** Insert orders, view products/inventory; cannot delete records.
* **Administrators/Managers (`app_admin` role):** Full data management, supplier and inventory control, view audit logs.
* **Auditors/Instructors:** Read-only inspection of the audit trail as proof of control during project defense.

## 4. Project Objectives
1. **Design a normalized (3NF) relational schema** covering customers, products, suppliers, inventory, orders, and payments.
2. **Implement PL/SQL procedures, functions, packages, and cursors** to automate core business operations (e.g., placing an order updates inventory and creates a payment record in a single transaction).
3. **Enforce data-integrity and security policies** using triggers that block write operations outside an approved time window and on public holidays.
4. **Implement a full audit trail** capturing who did what, when, and from where at the database level.
5. **Visualize business performance** (sales, inventory health, audit activity) through a Power BI dashboard connected directly to the Oracle schema.

## 5. Expected Benefits
* **Real-time Inventory Accuracy:** Tied directly to order transactions with zero manual reconciliation.
* **Full Accountability:** Every insert, update, or delete is traceable to a specific employee, machine, and timestamp.
* **Enforced Governance:** Write access is restricted by policy at the database layer itself, bypassing application-level vulnerabilities.
* **Scalable Architecture:** A reusable schema and privilege model ready for small-business deployment.
