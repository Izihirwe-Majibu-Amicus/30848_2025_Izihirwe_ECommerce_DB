# 🛡️ Enterprise Security & Autonomous Audit Infrastructure

<div align="center">

![Oracle](https://img.shields.io/badge/Oracle-21c-red?style=for-the-badge&logo=oracle)
![PLSQL](https://img.shields.io/badge/PL%2FSQL-Enterprise-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Production%20Ready-success?style=for-the-badge)
![Security](https://img.shields.io/badge/Security-Audited-darkgreen?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-lightgrey?style=for-the-badge)

Enterprise-grade Oracle Database Security, Auditing, Transaction Management, and Business Intelligence infrastructure for a modern E-Commerce platform.

</div>

---

# 📑 Table of Contents

- Executive Summary
- Project Overview
- System Architecture
- Security Architecture
- Core Features
- Security & Compliance
- Business Rules Enforcement
- Power BI Reporting Views
- Technology Stack
- Database Objects
- Repository Structure
- Installation
- Testing
- Performance Highlights
- Future Improvements
- Conclusion

---

# 📖 Executive Summary

This project implements a secure Oracle Database architecture designed for an enterprise-scale E-Commerce platform.

Instead of depending solely on application-level validation, critical business rules, auditing, and security policies are enforced directly inside the Oracle Database using PL/SQL packages, triggers, constraints, and autonomous transactions.

The result is a highly reliable architecture capable of:

- Preventing unauthorized database modifications
- Preserving immutable audit records
- Protecting inventory integrity
- Enforcing financial business rules
- Supporting executive analytics through Power BI

---

# 🏗 Project Overview

| Property | Value |
|----------|-------|
| **Project** | Enterprise E-Commerce Database Architecture |
| **Author** | Izihirwe-Majibu-Amicus |
| **Institution** | University of Lay Adventists of Kigali (UNILAK) |
| **Faculty** | Computing & Information Sciences |
| **Program** | Software Engineering |
| **Database** | Oracle Database 21c XE |
| **Language** | Oracle SQL & PL/SQL |

---

# 🏛 System Architecture

```text
                Client Application
                        │
                        ▼
              Oracle Database 21c XE
                        │
     ┌──────────────────┼──────────────────┐
     │                  │                  │
     ▼                  ▼                  ▼
 Business Rules     Security Layer     Audit Layer
 (Packages)          (Triggers)        (Autonomous)
     │                  │                  │
     └──────────────► AUDIT_LOG ◄──────────┘
                        │
                        ▼
                Power BI Reporting Views
```

---

# 🔒 Security Architecture

## Security Package

```
ECOMM_SECURITY_PKG
```

Responsibilities:

- User authorization
- Business-hour validation
- Weekend access restriction
- Audit logging
- Security exception handling

---

## Trigger Framework

The project uses multiple trigger types:

- BEFORE INSERT
- BEFORE UPDATE
- AFTER INSERT
- AFTER UPDATE
- AFTER DELETE
- Compound Triggers

These triggers enforce business policies before invalid data reaches the database.

---

# 🛡 Executive Security Overview

## Unauthorized Access Protection

The system prevents DML operations outside business hours:

```
Monday – Friday
08:00 → 18:00
```

Attempts outside this window immediately generate:

```
ORA-20001
Unauthorized operation.
```

The transaction is rejected before any data modification occurs.

---

## Autonomous Audit Logging

Security events are written using:

```plsql
PRAGMA AUTONOMOUS_TRANSACTION;
```

Benefits include:

- Rollback-independent logging
- Non-repudiation
- Immutable audit history
- Regulatory compliance

---

## Compound Trigger Protection

Inventory updates utilize compound triggers to eliminate:

```
ORA-04091
Mutating table error
```

Buffered processing enables:

- High-volume inventory updates
- Batch audit logging
- Improved scalability

---

# ⚙ Core Enterprise Features

✅ Secure Order Processing

✅ Inventory Management

✅ Autonomous Audit Logging

✅ Financial Validation

✅ Business Rule Enforcement

✅ Employee Activity Monitoring

✅ Low Stock Detection

✅ Transaction Rollback Protection

✅ Power BI Reporting

---

# 📊 Security & Compliance

## Audit Coverage

The following tables are fully audited:

- ORDERS
- PAYMENTS
- INVENTORY

Every

- INSERT
- UPDATE
- DELETE

creates a corresponding audit event.

---

## Rollback Independence

Unauthorized transactions generating:

```
ORA-20001
```

still produce permanent records inside:

```
AUDIT_LOG
```

Status:

```
DENIED
```

---

# 💰 Business Rule Enforcement

## Product Pricing

The trigger:

```
TRG_PRODUCTS_PRICE_CHECK
```

validates:

- Product price must be positive
- Prevents discounts exceeding 80%
- Protects against accidental pricing mistakes
- Detects malicious price manipulation

---

## Atomic Checkout

The package

```
ECOMM_ORDER_PKG
```

performs:

1. Stock validation
2. Order creation
3. Order items
4. Payment authorization
5. Inventory deduction

inside a **single database transaction**, ensuring ACID compliance.

---

# 📈 Business Intelligence Views

| View | Description |
|-------|-------------|
| VW_BI_SECURITY_DENIALS | Security violations |
| VW_BI_SALES_OVERVIEW | Revenue analytics |
| VW_BI_INVENTORY_HEALTH | Low stock monitoring |
| VW_BI_TOP_CUSTOMERS | Customer ranking |
| VW_BI_EMPLOYEE_ACTIVITY | Employee DML activity |
| VW_BI_AUDIT_DAILY | Daily audit statistics |

These views are optimized for Power BI dashboards and executive reporting.

---

# 🧰 Technology Stack

| Technology | Purpose |
|------------|---------|
| Oracle Database 21c XE | Database Engine |
| Oracle SQL | Schema Design |
| PL/SQL | Business Logic |
| Triggers | Event Processing |
| Packages | Enterprise Logic |
| Power BI | Business Intelligence |
| SQL Developer | Development |

---

# 📂 Repository Structure

```
Enterprise-ECommerce-Database/
│
├── README.md
├── schema.sql
├── packages.sql
├── procedures.sql
├── triggers.sql
├── views.sql
├── seed_data.sql
├── test_cases.sql
├── screenshots/
├── docs/
└── diagrams/
```

---

# 🚀 Installation

```sql
@schema.sql
@packages.sql
@procedures.sql
@triggers.sql
@views.sql
@seed_data.sql
@test_cases.sql
```

All objects should compile successfully.

Verify using:

```sql
SELECT object_name, status
FROM user_objects;
```

Expected:

```
STATUS = VALID
```

---

# 🧪 Testing

The project includes validation for:

- Authorized transactions
- Unauthorized access
- Audit logging
- Rollback handling
- Inventory updates
- Order processing
- Payment processing
- Power BI reporting views

---

# 📈 Performance Highlights

- 100% audited DML operations
- Rollback-independent audit logging
- Compound trigger optimization
- Atomic transaction processing
- Enterprise-ready reporting views
- Oracle ACID compliance

---

# 🔮 Future Improvements

- Oracle Fine-Grained Auditing (FGA)
- Oracle Database Vault
- Transparent Data Encryption (TDE)
- Row-Level Security (VPD)
- JWT authentication integration
- REST API integration
- Real-time alerting
- Email notifications
- SIEM integration
- Oracle Cloud deployment

---

# 📋 Recommendations

- Archive historical audit logs periodically.
- Monitor audit growth for long-term performance.
- Connect `VW_BI_SECURITY_DENIALS` directly to Power BI or a SIEM platform.
- Implement partitioning for large audit tables.

---

# 🎯 Conclusion

This project demonstrates how enterprise database systems can enforce security, business rules, auditing, and analytics entirely within Oracle Database.

By combining PL/SQL packages, autonomous transactions, compound triggers, and reporting views, the architecture provides a secure, scalable, and maintainable foundation for modern E-Commerce applications.

It serves as an academic demonstration of enterprise Oracle database development while following many best practices used in production environments.

---

## 👨‍💻 Author

**Izihirwe-Majibu-Amicus**

Software Engineering Student

University of Lay Adventists of Kigali (UNILAK)

Oracle Database • PL/SQL • Database Security • Enterprise Systems

---