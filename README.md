<!-- ========================================================= -->
<!--                Retail E-Commerce Oracle Project            -->
<!-- ========================================================= -->
<img width="1983" height="793" alt="ChatGPT Image Jul 27, 2026, 03_21_22 PM" src="https://github.com/user-attachments/assets/cc680688-99a8-4fd0-9acc-93d2d25b1013" />

<div align="center">

# 🛒 Retail E-Commerce Sales, Inventory & Audit Management System

### Enterprise Oracle Database Programming Capstone Project

**DPR400210 — Database Programming with Oracle Database**

---

![Oracle](https://img.shields.io/badge/Oracle-19c%20%7C%20XE-F80000?style=for-the-badge&logo=oracle&logoColor=white)
![PLSQL](https://img.shields.io/badge/PL%2FSQL-Programming-orange?style=for-the-badge)
![SQL](https://img.shields.io/badge/SQL-Oracle-blue?style=for-the-badge)
![PowerBI](https://img.shields.io/badge/Power%20BI-Analytics-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![GitHub](https://img.shields.io/badge/GitHub-Version%20Control-black?style=for-the-badge&logo=github)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)

---

*A complete enterprise-level Oracle Database solution for managing retail e-commerce operations, integrating inventory management, order processing, customer management, auditing, database security, and business intelligence reporting.*

</div>

---

# 📖 Project Overview

Modern retail businesses depend on reliable database systems to manage products, customers, inventory, suppliers, orders, and financial transactions. Many small and medium-sized businesses, however, continue to rely on spreadsheets and disconnected software that cannot guarantee data consistency, security, or operational efficiency.

This project presents the design and implementation of a comprehensive **Retail E-Commerce Sales, Inventory & Audit Management System** developed using **Oracle Database** and **PL/SQL**. The solution automates core business processes while enforcing enterprise-grade business rules through stored procedures, packages, triggers, and security mechanisms.

Beyond traditional database implementation, the system incorporates advanced Oracle features such as autonomous transactions for audit logging, compound triggers to eliminate mutating table errors, custom security policies to restrict unauthorized database modifications, and analytical database views prepared for Microsoft Power BI.

The project demonstrates both theoretical understanding and practical implementation of Oracle Database Programming, following software engineering principles from requirements analysis through database design, implementation, testing, documentation, and reporting.
---

# 📑 Table of Contents

- [📖 Project Information](#-project-information)
- [🎯 Problem Statement](#-problem-statement)
- [🎯 Project Objectives](#-project-objectives)
- [✨ System Features](#-system-features)
- [🛠 Technologies Used](#-technologies-used)
- [🏗 System Architecture](#-system-architecture)
- [🗄 Database Design](#-database-design)
- [📊 Entity Relationship Diagram (ERD)](#-entity-relationship-diagram-erd)
- [⚙ Business Process Workflow](#-business-process-workflow)
- [📂 Repository Structure](#-repository-structure)
- [🚀 Development Phases](#-development-phases)
- [💾 Database Schema](#-database-schema)
- [📦 Oracle Packages](#-oracle-packages)
- [⚡ Stored Procedures](#-stored-procedures)
- [🧮 Functions](#-functions)
- [🔄 Cursors](#-cursors)
- [🔐 Security Implementation](#-security-implementation)
- [🛡 Trigger Implementation](#-trigger-implementation)
- [📝 Audit Trail](#-audit-trail)
- [📈 Power BI Integration](#-power-bi-integration)
- [📸 Screenshots & Verification](#-screenshots--verification)
- [⚙ Installation Guide](#-installation-guide)
- [▶ Running the Project](#-running-the-project)
- [🧪 Testing & Validation](#-testing--validation)
- [💡 Innovation Components](#-innovation-components)
- [📚 Learning Outcomes](#-learning-outcomes)
- [🚀 Future Improvements](#-future-improvements)
- [📜 License](#-license)
- [👨‍💻 Author](#-author)
- [🙏 Acknowledgements](#-acknowledgements)

---

# 📖 Project Information

| Item | Description |
|------|-------------|
| **Project Title** | Retail E-Commerce Sales, Inventory & Audit Management System |
| **Course Code** | DPR400210 |
| **Course Name** | Database Programming with Oracle Database |
| **Project Type** | Individual Capstone Project |
| **Student** | Izihirwe Majibu Amicus |
| **Student ID** | 30848/2025 |
| **Institution** | University of Lay Adventists of Kigali (UNILAK) |
| **Academic Year** | 2025–2026 |
| **Database Platform** | Oracle Database 19c / Oracle XE |
| **Programming Language** | SQL & PL/SQL |
| **Reporting Tool** | Microsoft Power BI |
| **Version Control** | Git & GitHub |
| **Project Status** | ✅ Completed |

---

# 🎯 Problem Statement

Retail businesses generate large volumes of operational data every day, including customer information, product inventories, supplier records, sales transactions, payment details, and shipping activities. When these processes are managed using spreadsheets or isolated applications, organizations often experience data duplication, inconsistent records, weak security controls, and limited visibility into business performance.

The absence of centralized database management also makes it difficult to monitor inventory levels accurately, track orders throughout their lifecycle, audit sensitive database operations, and enforce organizational policies. As transaction volumes increase, manual processes become inefficient and more prone to human error.

This project addresses these challenges by developing a secure, scalable, and enterprise-oriented Oracle database system capable of integrating all major retail operations into a single centralized database. Through Oracle SQL and PL/SQL programming, the system automates business workflows, maintains data integrity, enforces operational rules, records audit information, and provides analytical views for business intelligence reporting.

---

# 🎯 Project Objectives

## General Objective

To design, develop, and implement a secure Oracle Database solution that automates retail e-commerce operations while demonstrating advanced Oracle Database Programming concepts.

## Specific Objectives

- Design a fully normalized relational database in Third Normal Form (3NF).
- Implement secure Oracle database objects using SQL and PL/SQL.
- Manage customers, products, suppliers, inventory, and sales transactions efficiently.
- Automate business processes using stored procedures and Oracle packages.
- Develop reusable PL/SQL functions to support business logic.
- Implement explicit cursors for controlled data processing.
- Enforce business rules using row-level, statement-level, and compound triggers.
- Record all significant database activities through an autonomous audit trail.
- Restrict unauthorized database modifications using custom security policies.
- Create business intelligence views optimized for Microsoft Power BI.
- Demonstrate enterprise database programming practices suitable for real-world retail environments.

---
# ✨ System Features

The Retail E-Commerce Sales, Inventory & Audit Management System provides an integrated Oracle database solution that supports the complete operational lifecycle of a retail business. The system is designed with enterprise database programming principles, ensuring data integrity, security, scalability, and maintainability.

## Core Functional Modules

### 👥 Customer Management
- Register and maintain customer information.
- Store customer contact details securely.
- Track customer purchase history.
- Support customer order relationships.

---

### 📦 Product & Category Management
- Maintain product catalog.
- Organize products into categories.
- Record pricing information.
- Manage product availability.

---

### 🚚 Supplier Management
- Register suppliers.
- Store supplier contact information.
- Associate suppliers with products.
- Monitor supplier relationships.

---

### 📦 Inventory Management
- Track stock quantities.
- Detect low inventory levels.
- Prevent negative stock values.
- Monitor inventory movement.

---

### 🛒 Order Management
- Create customer orders.
- Process multiple order items.
- Calculate order totals.
- Maintain order status.

---

### 💳 Payment Processing
- Record customer payments.
- Track payment methods.
- Maintain payment history.
- Link payments with orders.

---

### 🚛 Shipping Management
- Record shipment details.
- Track delivery status.
- Manage shipping information.
- Associate shipments with customer orders.

---

### 🔒 Security & Access Control
- Restrict unauthorized database operations.
- Enforce business-hour DML policies.
- Generate custom Oracle exceptions.
- Protect sensitive business data.

---

### 📝 Audit Trail
- Record all important database operations.
- Capture successful and failed transactions.
- Store audit timestamps automatically.
- Preserve audit records using autonomous transactions.

---

### 📊 Business Intelligence
- Create analytical database views.
- Support Power BI dashboards.
- Provide management reporting.
- Monitor sales and inventory performance.

---

# 🛠 Technologies Used

The project combines Oracle database technologies with business intelligence tools to deliver a secure and scalable enterprise solution.

| Technology | Purpose |
|------------|---------|
| **Oracle Database 19c / XE** | Database management system |
| **SQL** | Database definition and manipulation |
| **PL/SQL** | Business logic implementation |
| **Oracle Packages** | Modular application programming |
| **Stored Procedures** | Business transaction processing |
| **Functions** | Reusable database calculations |
| **Explicit Cursors** | Controlled row processing |
| **Triggers** | Business rule enforcement |
| **Compound Triggers** | Prevent mutating table errors |
| **Exception Handling** | Error detection and recovery |
| **PRAGMA AUTONOMOUS_TRANSACTION** | Independent audit logging |
| **Power BI** | Reporting and analytics |
| **Git** | Version control |
| **GitHub** | Source code hosting and documentation |

---

# 🏗 System Architecture

The application follows a layered database architecture where each Oracle component performs a specific responsibility while working together as a unified system.

```text
                        ┌────────────────────────────┐
                        │        End Users           │
                        │ Administrator / Staff      │
                        └─────────────┬──────────────┘
                                      │
                                      ▼
                      ┌──────────────────────────────┐
                      │     Retail Business Rules     │
                      │      Oracle PL/SQL Layer      │
                      └─────────────┬────────────────┘
                                    │
          ┌─────────────────────────┼─────────────────────────┐
          │                         │                         │
          ▼                         ▼                         ▼
 ┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
 │ Stored          │      │ Oracle          │      │ Database         │
 │ Procedures      │      │ Packages        │      │ Functions        │
 └─────────────────┘      └─────────────────┘      └─────────────────┘
          │                         │                         │
          └──────────────┬──────────┴──────────┬──────────────┘
                         ▼                     ▼
                ┌──────────────────┐   ┌──────────────────┐
                │     Triggers      │   │     Cursors      │
                └─────────┬─────────┘   └─────────┬────────┘
                          │                       │
                          └───────────┬───────────┘
                                      ▼
                          ┌────────────────────────┐
                          │    Oracle Database     │
                          │   Tables & Relations   │
                          └─────────────┬──────────┘
                                        │
             ┌──────────────────────────┼─────────────────────────┐
             ▼                          ▼                         ▼
      Customer Data             Sales & Inventory          Audit Records
                                                     Security Logs
```

---

# 🗄 Database Design

The database was designed following relational database principles and normalized to **Third Normal Form (3NF)** to minimize redundancy while maintaining high data integrity.

## Design Principles

- Entity-Relationship (ER) modeling.
- Third Normal Form (3NF) normalization.
- Strong primary and foreign key relationships.
- Referential integrity enforcement.
- Data consistency through constraints.
- Modular Oracle object organization.
- Scalable schema design.
- Enterprise-oriented naming conventions.

---

## Major Database Entities

| Entity | Purpose |
|---------|---------|
| **CUSTOMERS** | Stores customer information |
| **PRODUCTS** | Stores products available for sale |
| **CATEGORIES** | Organizes products into categories |
| **SUPPLIERS** | Stores supplier information |
| **INVENTORY** | Tracks available stock |
| **ORDERS** | Stores customer orders |
| **ORDER_ITEMS** | Records products within each order |
| **PAYMENTS** | Stores payment transactions |
| **SHIPMENTS** | Tracks shipping information |
| **USERS** | Stores authorized system users |
| **AUDIT_LOG** | Maintains complete audit history |

---

## Database Design Goals

The database schema was designed to achieve the following objectives:

- Maintain data consistency.
- Eliminate unnecessary duplication.
- Support complex business transactions.
- Enforce referential integrity.
- Improve maintainability.
- Enable efficient reporting.
- Support future system expansion.
- Provide a secure foundation for enterprise database programming.

---
# 📊 Entity Relationship Diagram (ERD)

The Entity Relationship Diagram (ERD) represents the logical structure of the Retail E-Commerce Database. It illustrates how business entities interact through primary keys, foreign keys, and one-to-many relationships.

The design follows **Third Normal Form (3NF)** to eliminate redundancy while ensuring efficient data storage and retrieval.

## ERD Preview
The following Entity Relationship Diagram illustrates the logical design of the Retail E-Commerce database. It shows the entities, attributes, and relationships that support customer management, inventory control, order processing, payments, shipping, security, and auditing.

```text
docs/images/ERD.png
```

<img width="1536" height="1024" alt="ChatGPT Image Jul 27, 2026, 03_20_49 PM" src="https://github.com/user-attachments/assets/61f92972-9236-45fd-83c9-12e2f445e3ce" />


---

## Main Entity Relationships

| Parent Entity | Child Entity | Relationship |
|---------------|-------------|--------------|
| CUSTOMERS | ORDERS | One Customer → Many Orders |
| ORDERS | ORDER_ITEMS | One Order → Many Order Items |
| PRODUCTS | ORDER_ITEMS | One Product → Many Order Items |
| CATEGORIES | PRODUCTS | One Category → Many Products |
| SUPPLIERS | PRODUCTS | One Supplier → Many Products |
| PRODUCTS | INVENTORY | One Product → One Inventory Record |
| ORDERS | PAYMENTS | One Order → One or More Payments |
| ORDERS | SHIPMENTS | One Order → One Shipment |
| USERS | AUDIT_LOG | One User → Many Audit Records |

---

## Database Integrity

The database maintains integrity using:

- Primary Keys
- Foreign Keys
- NOT NULL Constraints
- UNIQUE Constraints
- CHECK Constraints
- Referential Integrity Rules
- Trigger-Based Validation
- PL/SQL Business Logic

---

# ⚙ Business Process Workflow

The system automates the complete retail business lifecycle, beginning with customer registration and ending with order delivery and reporting.

## Overall Business Workflow

```text
Customer Registration
          │
          ▼
Browse Products
          │
          ▼
Place Order
          │
          ▼
Inventory Validation
          │
          ▼
Payment Processing
          │
          ▼
Inventory Update
          │
          ▼
Shipping Process
          │
          ▼
Audit Logging
          │
          ▼
Business Intelligence Reporting
```

---

## Transaction Lifecycle

```text
Customer
    │
    ▼
Order Created
    │
    ▼
Order Items Added
    │
    ▼
Stock Availability Checked
    │
    ▼
Payment Recorded
    │
    ▼
Shipment Created
    │
    ▼
Order Completed
```

---

## Oracle Components During Processing

| Step | Oracle Component |
|------|------------------|
| Customer Registration | SQL INSERT |
| Product Search | SQL SELECT |
| Order Creation | Stored Procedure |
| Order Validation | Function |
| Inventory Update | Trigger |
| Payment Processing | Package |
| Shipment Recording | Procedure |
| Audit Logging | Autonomous Trigger |
| Dashboard Reporting | Power BI Views |

---

# 📂 Repository Structure

The repository is organized into development phases that follow the official Oracle Database Programming project lifecycle.

```text
30848_2025_Izihirwe_ECommerce_DB
│
├── phase1_problem_statement/
│
├── phase2_business_process/
│
├── phase3_logical_design/
│
├── phase4_database_creation/
│
├── phase5_table_implementation/
│
├── phase6_plsql/
│
├── phase7_triggers_security/
│
├── phase8_documentation/
│
├── sql_scripts/
│
├── plsql_scripts/
│
├── reports/
│
├── screenshots/
│
├── docs/
│   ├── images/
│   ├── diagrams/
│   └── presentation/
│
└── README.md
```

---

## Repository Organization

| Folder | Description |
|---------|-------------|
| phase1_problem_statement | Business problem, scope, requirements |
| phase2_business_process | UML, BPMN and process models |
| phase3_logical_design | ERD, normalization, data dictionary |
| phase4_database_creation | Oracle user, roles, schema creation |
| phase5_table_implementation | Tables, constraints, sample data |
| phase6_plsql | Packages, procedures, functions, cursors |
| phase7_triggers_security | Triggers, security and auditing |
| phase8_documentation | Final report, presentation and guides |
| sql_scripts | SQL implementation scripts |
| plsql_scripts | Standalone PL/SQL programs |
| reports | Project documentation |
| screenshots | Execution verification images |
| docs | Supporting diagrams and documentation |

---

# 🚀 Development Phases

The implementation follows a structured software development approach, where each phase builds upon the previous one.

| Phase | Description | Status |
|--------|-------------|--------|
| Phase I | Problem Statement & Requirements Analysis | ✅ Completed |
| Phase II | Business Process Modeling | ✅ Completed |
| Phase III | Logical Database Design | ✅ Completed |
| Phase IV | Oracle Database Creation | ✅ Completed |
| Phase V | Table Implementation & Sample Data | ✅ Completed |
| Phase VI | PL/SQL Programming | ✅ Completed |
| Phase VII | Triggers, Security & Auditing | ✅ Completed |
| Phase VIII | Documentation & Presentation | ✅ Completed |

---

## Development Timeline

```text
Requirements Analysis
          │
          ▼
Business Modeling
          │
          ▼
Logical Database Design
          │
          ▼
Physical Database Creation
          │
          ▼
PL/SQL Programming
          │
          ▼
Security & Auditing
          │
          ▼
Testing & Validation
          │
          ▼
Power BI Reporting
          │
          ▼
Final Documentation
```

---

# 💾 Database Schema Overview

The Oracle database schema consists of business entities that collectively support customer management, inventory control, sales processing, payment recording, shipment tracking, and audit monitoring.

## Schema Components

| Component | Description |
|-----------|-------------|
| Business Tables | Store operational business data |
| Lookup Tables | Store reference information |
| Constraints | Enforce data integrity |
| Views | Provide analytical reporting |
| Packages | Organize PL/SQL logic |
| Procedures | Execute business transactions |
| Functions | Perform reusable calculations |
| Triggers | Automate business rules |
| Audit Tables | Record database activities |

---

## Schema Characteristics

- Fully normalized to Third Normal Form (3NF).
- Strong referential integrity through foreign keys.
- Modular PL/SQL architecture.
- Automated business rule enforcement.
- Centralized audit logging.
- Enterprise-ready reporting views.
- Optimized for scalability and maintainability.

---
# 💾 Oracle Database Features

This project demonstrates advanced Oracle Database Programming concepts by combining SQL, PL/SQL, packages, procedures, functions, triggers, cursors, exception handling, autonomous transactions, and analytical views into a single enterprise-oriented solution.

The implementation follows Oracle development best practices by separating business logic from data storage, promoting modularity, maintainability, scalability, and security.

---

# 📦 Oracle Packages

Oracle Packages were used to group related procedures and functions into reusable modules. This approach improves code organization, simplifies maintenance, and encourages code reuse across multiple business operations.

## Implemented Packages

| Package | Purpose |
|---------|---------|
| **ECOMM_ORDER_PKG** | Handles customer orders and order processing. |
| **ECOMM_ADMIN_PKG** | Performs administrative operations and master data management. |
| **ECOMM_SECURITY_PKG** | Implements database security policies, validation, and access control. |

---

## Package Responsibilities

### 🛒 ECOMM_ORDER_PKG

This package contains business logic responsible for order processing throughout the retail system.

Typical operations include:

- Creating new customer orders
- Adding products to orders
- Calculating order totals
- Updating order status
- Completing sales transactions
- Coordinating inventory updates

---

### ⚙️ ECOMM_ADMIN_PKG

This package centralizes administrative functions used by system administrators.

Typical operations include:

- Product management
- Category management
- Supplier maintenance
- Inventory administration
- User administration
- Database maintenance utilities

---

### 🔐 ECOMM_SECURITY_PKG

This package enforces security policies and business rules designed to protect sensitive data.

Typical responsibilities include:

- Business hour validation
- Permission checking
- Database activity validation
- Security exception generation
- Access restriction

---

## Why Packages?

Oracle Packages provide several advantages:

- Better code organization
- Improved performance
- Reusable business logic
- Easier maintenance
- Better encapsulation
- Enterprise-level modularity

---

# ⚡ Stored Procedures

Stored Procedures automate business transactions and ensure that complex operations are executed consistently.

Instead of allowing users to perform multiple SQL statements manually, the application executes predefined procedures that maintain business rules and transactional integrity.

---

## Example Business Procedures

| Procedure | Purpose |
|-----------|---------|
| Create Customer | Registers a new customer |
| Create Product | Adds a new product |
| Create Order | Creates a customer order |
| Process Payment | Records payment information |
| Update Inventory | Adjusts stock quantities |
| Register Shipment | Creates shipment records |

---

## Benefits of Stored Procedures

- Centralized business logic
- Reduced application complexity
- Improved database performance
- Transaction consistency
- Reduced network traffic
- Enhanced security

---

# 🧮 User-Defined Functions

Functions provide reusable calculations and validation logic throughout the database.

Unlike procedures, functions always return a value, making them suitable for calculations, validations, and reporting.

---

## Typical Functions

| Function | Returns |
|----------|---------|
| Total Order Value | Total amount of an order |
| Available Inventory | Current stock quantity |
| Product Availability | Available / Out of Stock |
| Customer Purchase Count | Number of completed orders |
| Daily Sales Total | Total sales for a selected date |

---

## Function Benefits

Functions improve:

- Code reuse
- Readability
- Consistency
- Maintainability
- Reporting accuracy

---

# 🔄 Explicit Cursors

Explicit cursors are used whenever multiple records must be processed sequentially.

They provide complete control over record retrieval, allowing Oracle to process each row individually while applying business logic.

---

## Cursor Operations

Each cursor follows the standard Oracle processing sequence:

```text
OPEN Cursor
      │
      ▼
FETCH Record
      │
      ▼
Process Business Logic
      │
      ▼
More Records?
      │
 ┌────┴────┐
 │         │
Yes       No
 │         │
 ▼         ▼
FETCH    CLOSE Cursor
```

---

## Cursor Applications

Explicit cursors are used for:

- Inventory processing
- Customer reporting
- Daily sales summaries
- Batch order processing
- Administrative reports
- Audit record generation

---

## Advantages

- Controlled row-by-row processing
- Improved readability
- Better exception handling
- Flexible business processing

---

# 🚨 Exception Handling

A robust exception handling strategy has been implemented throughout the project to ensure database stability and provide meaningful feedback whenever an error occurs.

Instead of allowing Oracle to return generic system errors, the application raises descriptive exceptions that clearly explain the problem.

---

## Common Exception Types

| Exception | Purpose |
|-----------|---------|
| NO_DATA_FOUND | Requested data does not exist |
| TOO_MANY_ROWS | Query returned more than one row |
| DUP_VAL_ON_INDEX | Duplicate unique value detected |
| INVALID_NUMBER | Invalid numeric input |
| VALUE_ERROR | Invalid data conversion |
| OTHERS | Handles unexpected system errors |

---

## Custom Business Exceptions

The project also implements user-defined Oracle exceptions to enforce business policies.

Example:

```text
ORA-20001

Database modification is not permitted outside approved business hours.
```

Additional business validations include:

- Insufficient inventory
- Invalid payment information
- Duplicate customer registration
- Invalid shipment status
- Unauthorized user actions

---

# 🔐 Security Implementation

Protecting operational data is one of the primary objectives of this project.

Several Oracle security mechanisms have been implemented to ensure that only authorized operations are allowed.

---

## Security Features

- Business-hour DML restriction
- Trigger-based validation
- Custom Oracle exceptions
- Audit trail logging
- Transaction monitoring
- User activity tracking
- Data integrity enforcement
- Role-based privilege management

---

## Security Workflow

```text
User Attempts Database Operation
               │
               ▼
      Security Validation
               │
        ┌──────┴──────┐
        │             │
     Authorized   Unauthorized
        │             │
        ▼             ▼
 Execute DML     Raise ORA-20001
        │             │
        ▼             ▼
Audit Success   Audit Failure
```

---

## Enterprise Security Goals

The implemented security model ensures that:

- Sensitive data remains protected.
- Unauthorized modifications are prevented.
- Every database action is traceable.
- Business rules are enforced consistently.
- Audit information is permanently preserved.

---

> **Summary:**  
> This Oracle implementation demonstrates enterprise-level database programming by combining modular PL/SQL packages, reusable procedures and functions, explicit cursors, robust exception handling, and security controls into a maintainable and scalable retail e-commerce database solution.

---
# 🛡 Trigger Implementation

Triggers play a critical role in automating business rules and maintaining database integrity. They execute automatically in response to database events without requiring manual intervention from users or applications.

The project implements multiple types of Oracle triggers to ensure that business operations remain consistent, secure, and auditable.

---

## Trigger Categories

| Trigger Type | Purpose |
|--------------|---------|
| **BEFORE INSERT Trigger** | Validates incoming data before records are inserted. |
| **BEFORE UPDATE Trigger** | Enforces business rules before modifications occur. |
| **AFTER INSERT Trigger** | Records successful transactions in the audit log. |
| **AFTER UPDATE Trigger** | Tracks modifications for accountability. |
| **AFTER DELETE Trigger** | Logs deleted records for auditing purposes. |
| **Statement-Level Trigger** | Executes once for an entire SQL statement. |
| **Row-Level Trigger** | Executes once for every affected row. |
| **Compound Trigger** | Prevents mutating table errors during complex operations. |

---

## Trigger Responsibilities

The implemented triggers automatically perform tasks such as:

- Validating business rules before transactions
- Preventing unauthorized modifications
- Recording audit information
- Updating inventory after completed orders
- Maintaining data consistency
- Enforcing operational policies
- Tracking database activity

---

## Trigger Execution Flow

```text
User Executes SQL Statement
             │
             ▼
     BEFORE Trigger Executes
             │
             ▼
 Business Rule Validation
             │
      ┌──────┴──────┐
      │             │
  Validation      Validation
   Passed          Failed
      │             │
      ▼             ▼
 SQL Executes   Raise Exception
      │
      ▼
 AFTER Trigger Executes
      │
      ▼
 Audit Record Created
```

---

# 📝 Autonomous Audit Trail

A major innovation of this project is the implementation of an autonomous audit trail using Oracle's:

```plsql
PRAGMA AUTONOMOUS_TRANSACTION;
```

This feature allows audit information to be committed independently of the main transaction.

Even if the parent transaction fails or is rolled back, the audit record remains permanently stored, providing a complete history of attempted database operations.

---

## Why Autonomous Transactions?

Traditional audit logging is rolled back when the parent transaction fails.

Autonomous transactions solve this problem by committing audit information separately.

Benefits include:

- Permanent audit history
- Improved accountability
- Enhanced security
- Regulatory compliance
- Easier troubleshooting
- Reliable forensic analysis

---

## Audit Information Captured

Every important database event records information such as:

| Audit Field | Description |
|-------------|-------------|
| Audit ID | Unique audit record identifier |
| Username | User performing the operation |
| Database Table | Table affected |
| Operation Type | INSERT, UPDATE, DELETE |
| Date & Time | Timestamp of the action |
| Status | Allowed or Denied |
| Error Message | Oracle exception (if applicable) |
| Session Information | Oracle session details |

---

## Audit Workflow

```text
Database Operation
        │
        ▼
Trigger Activated
        │
        ▼
Audit Procedure Called
        │
        ▼
Autonomous Transaction
        │
        ▼
COMMIT Audit Record
        │
        ▼
Continue Parent Transaction
```

---

## Sample Audit Scenario

| User Action | Audit Result |
|-------------|--------------|
| Insert Product | Logged as Success |
| Update Inventory | Logged as Success |
| Delete Customer | Logged as Success |
| Unauthorized UPDATE | Logged as Denied |
| Business Hour Violation | Logged as Denied |
| Invalid Transaction | Logged with Error Details |

---

# 🔒 Business Rule Enforcement

The system enforces several enterprise business rules to protect operational data and maintain consistency.

Examples include:

- Inventory cannot become negative.
- Products must belong to a valid category.
- Orders cannot exist without customers.
- Payments must reference valid orders.
- Shipments cannot be created before an order exists.
- Duplicate primary records are prevented.
- Invalid foreign key relationships are rejected.
- Unauthorized DML operations are blocked.

---

# 🚨 Database Security Policy

To protect business data, the database enforces operational security policies directly within Oracle.

One important rule prevents users from modifying critical business tables outside approved business hours.

When an unauthorized operation is attempted, Oracle raises a custom application error such as:

```text
ORA-20001:
Database modification is not permitted outside approved business hours.
```

This policy demonstrates how PL/SQL can enforce organizational rules independently of any external application.

---

## Security Decision Flow

```text
User Requests INSERT / UPDATE / DELETE
                  │
                  ▼
        Check Security Policy
                  │
         ┌────────┴────────┐
         │                 │
     Authorized       Unauthorized
         │                 │
         ▼                 ▼
 Execute Statement   Raise ORA-20001
         │                 │
         └────────┬────────┘
                  ▼
           Write Audit Log
```

---

# 📈 Power BI Integration

The project includes a dedicated reporting layer designed specifically for Microsoft Power BI.

Instead of querying operational tables directly, Power BI connects to optimized database views that provide summarized and analysis-ready data.

This approach improves reporting performance while protecting transactional tables from unnecessary analytical workloads.

---

## Business Intelligence Views

| View | Purpose |
|------|---------|
| **VW_BI_SALES_OVERVIEW** | Sales performance analysis |
| **VW_BI_INVENTORY_HEALTH** | Inventory monitoring |
| **VW_BI_SECURITY_DENIALS** | Unauthorized activity reporting |
| **VW_BI_AUDIT_DAILY** | Daily audit activity summary |

---

## Dashboard Capabilities

The reporting layer enables dashboards that answer business questions such as:

- What are the daily, weekly, and monthly sales?
- Which products generate the highest revenue?
- Which products are running low in stock?
- Which customers purchase most frequently?
- How many security violations occurred?
- Which database tables receive the most updates?
- What audit activities occurred today?

---

## Power BI Data Flow

```text
Oracle Database
        │
        ▼
Analytical Views
(VW_BI_*)
        │
        ▼
Power BI Connection
        │
        ▼
Interactive Dashboards
        │
        ▼
Management Reports
```

---


## Verification Gallery

| Phase | Verification | Location |
|--------|-------------|----------|
| Phase IV | Oracle schema creation | `screenshots/phase04_physical_schema/` |
| Phase V | Tables and sample data | `screenshots/phase05_data_population/` |
| Phase VI | Valid PL/SQL packages | `screenshots/phase06_plsql_packages/` |
| Phase VII | Trigger execution | `screenshots/phase07_security_and_audit/` |
| Phase VII | Autonomous audit trail | `screenshots/phase07_security_and_audit/` |
| Phase VII | ORA-20001 security validation | `screenshots/phase07_security_and_audit/` |
| Phase VIII | Power BI reporting views | `screenshots/phase08_bi_views/` |

---

## Recommended Repository Images

To make the GitHub repository more engaging, include screenshots such as:

- Oracle SQL Developer connection
- Database schema explorer
- Entity Relationship Diagram (ERD)
- Table creation scripts
- Sample data after population
- Package compilation status (`VALID`)
- Trigger execution examples
- Audit log records
- Security policy demonstration
- Power BI dashboards

Organizing these images under the `screenshots/` directory allows readers, lecturers, and reviewers to verify each implementation phase visually.

---

> **Summary:**  
> This project demonstrates enterprise-grade Oracle database programming by combining automated trigger execution, autonomous audit logging, security policy enforcement, and business intelligence integration. Together, these components provide a secure, traceable, and scalable foundation for managing retail e-commerce operations.

---
# ⚙️ Installation Guide

The following steps describe how to set up and execute the project in a new Oracle Database environment.

## Prerequisites

Before running the project, ensure the following software is installed:

| Software | Version |
|----------|---------|
| Oracle Database | 21c / Oracle XE |
| Oracle SQL Developer | Latest Version |
| Microsoft Power BI Desktop | Latest Version (Optional) |
| Git | Latest Version |
| GitHub Desktop (Optional) | Latest Version |

---

## Step 1 — Clone the Repository

```bash
git clone https://github.com/your-username/30848_2025_Izihirwe_ECommerce_DB.git
```

or download the repository as a ZIP file and extract it.

---

## Step 2 — Create the Oracle User

Run the scripts located in:

```text
phase4_database_creation/
```

These scripts will create:

- Database User
- Tablespace
- Roles
- Required Privileges

---

## Step 3 — Create Database Objects

Execute the SQL scripts inside:

```text
phase5_table_implementation/
```

This creates:

- Tables
- Primary Keys
- Foreign Keys
- Constraints
- Indexes
- Sample Data

---

## Step 4 — Compile PL/SQL Components

Execute the scripts inside:

```text
phase6_plsql/
```

Compile:

- Packages
- Package Bodies
- Procedures
- Functions
- Cursors

Ensure all objects compile successfully with **VALID** status.

---

## Step 5 — Configure Security & Triggers

Execute:

```text
phase7_triggers_security/
```

This installs:

- Triggers
- Audit Tables
- Security Policies
- Autonomous Audit Logic

---

## Step 6 — Configure Power BI (Optional)

Open Microsoft Power BI Desktop.

Connect to the Oracle database and import the reporting views:

- VW_BI_SALES_OVERVIEW
- VW_BI_INVENTORY_HEALTH
- VW_BI_SECURITY_DENIALS
- VW_BI_AUDIT_DAILY

Create dashboards using the imported views.

---

# ▶️ Running the Project

After installation:

1. Connect to the Oracle database.
2. Verify all objects compile successfully.
3. Execute sample INSERT, UPDATE, and DELETE statements.
4. Test stored procedures and package functions.
5. Verify audit records.
6. Test business-hour security restrictions.
7. Query the reporting views.
8. Visualize data using Power BI.

---

# 🧪 Testing & Validation

The project was tested to ensure that every component functions correctly and satisfies the specified business requirements.

## Functional Testing

| Component | Status |
|-----------|--------|
| Table Creation | ✅ Passed |
| Constraints | ✅ Passed |
| Relationships | ✅ Passed |
| Sample Data | ✅ Passed |
| Stored Procedures | ✅ Passed |
| Functions | ✅ Passed |
| Packages | ✅ Passed |
| Explicit Cursors | ✅ Passed |
| Triggers | ✅ Passed |
| Compound Triggers | ✅ Passed |
| Audit Logging | ✅ Passed |
| Security Policies | ✅ Passed |
| Power BI Views | ✅ Passed |

---

## Validation Scenarios

The following scenarios were successfully verified:

- Customer registration
- Product creation
- Supplier registration
- Inventory updates
- Order processing
- Payment recording
- Shipment management
- Audit logging
- Security restriction enforcement
- Reporting view generation

---

# 💡 Innovation Highlights

This project extends beyond the minimum course requirements by incorporating advanced Oracle Database features commonly found in enterprise systems.

## Key Innovations

### 📝 Autonomous Audit Trail

Every transaction attempt is permanently logged using:

```plsql
PRAGMA AUTONOMOUS_TRANSACTION;
```

Audit records remain intact even when the parent transaction fails or is rolled back.

---

### 🛡 Advanced Trigger Framework

The project implements:

- Statement-Level Triggers
- Row-Level Triggers
- Compound Triggers

to automate business logic and maintain data integrity.

---

### 🔐 Security Enforcement

Sensitive database operations are protected through custom security rules that:

- Restrict unauthorized DML operations.
- Validate business hours.
- Raise meaningful Oracle exceptions.
- Record every security event.

---

### 📈 Business Intelligence Integration

The system exposes dedicated reporting views optimized for Microsoft Power BI, enabling interactive dashboards without affecting transactional performance.

---

### 🏗 Modular PL/SQL Architecture

Business logic is organized into reusable packages, procedures, and functions, promoting maintainability, scalability, and clean system design.

---

# 📚 Learning Outcomes

This capstone project demonstrates practical knowledge and skills gained throughout the Oracle Database Programming course.

## Technical Skills Demonstrated

- Oracle Database Administration
- SQL Programming
- Advanced PL/SQL Programming
- Database Normalization (3NF)
- Relational Database Design
- Oracle Packages
- Stored Procedures
- User-Defined Functions
- Explicit Cursors
- Trigger Development
- Compound Triggers
- Exception Handling
- Autonomous Transactions
- Database Security
- Audit Logging
- Data Integrity Enforcement
- Business Intelligence Reporting
- Power BI Integration
- Version Control using Git and GitHub

---

## Professional Skills Developed

- Problem Analysis
- Logical Thinking
- Database Modeling
- Software Documentation
- Project Organization
- Debugging and Troubleshooting
- Code Reusability
- System Testing
- Technical Communication

---

# 🚀 Future Improvements

Although the current implementation satisfies the project requirements, future versions could include additional enterprise features such as:

- REST API integration
- Oracle APEX web interface
- Customer authentication and authorization
- Barcode and QR code support
- Product image management
- Email notifications
- SMS order tracking
- Real-time inventory synchronization
- Mobile application integration
- AI-based sales forecasting
- Automated supplier purchase recommendations
- Cloud deployment using Oracle Cloud Infrastructure (OCI)

---

# 📜 License

This repository was developed as an academic capstone project for:

**DPR400210 – Database Programming with Oracle Database**

at the
**University of Lay Adventists of Kigali (UNILAK)**

The project is submitted for educational and academic evaluation purposes. It may be referenced for learning and demonstration, but should not be submitted as original work by other students.

---

# 👨‍💻 Author

| | |
|---|---|
| **Student** | Izihirwe Majibu Amicus |
| **Student ID** | 30848/2025 |
| **Course** | DPR400210 – Database Programming with Oracle Database |
| **Institution** | University of Lay Adventists of Kigali (UNILAK) |
| **Academic Year** | 2025–2026 |
| **Project Type** | Individual Capstone Project |

---

# 🙏 Acknowledgements

I would like to express my sincere appreciation to:

- The University of Lay Adventists of Kigali (UNILAK) for providing an environment that supports academic growth and practical learning.
- The lecturers of the Database Programming with Oracle Database course for their guidance and continuous support throughout this project.
- Oracle Corporation for providing a robust database platform and comprehensive documentation that facilitated the successful implementation of this project.
- My classmates and peers for their collaboration, discussions, and encouragement during the development process.

---

# 📌 Project Status

<div align="center">

## ✅ Project Successfully Completed

**Retail E-Commerce Sales, Inventory & Audit Management System**

**Oracle Database Programming Capstone Project**

**Status:** Completed ✔️

**Development Phases:** I – VIII ✔️

**Database Objects:** Successfully Compiled ✔️

**Testing:** Successfully Validated ✔️

**Documentation:** Complete ✔️

**Power BI Integration:** Ready ✔️

---


