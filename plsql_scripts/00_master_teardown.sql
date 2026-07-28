/*==============================================================
  MASTER TEARDOWN RUNNER
  Project: Enterprise E-Commerce Database Architecture
  Author: Izihirwe-Majibu-Amicus
  Run as: ECOMM_ADMIN
  WARNING: Executing this script drops all schema objects!
==============================================================*/

   SET ECHO ON;
SET SERVEROUTPUT ON SIZE UNLIMITED;
SPOOL master_teardown_log.txt;

pro    =========================================================
pro     STARTING FULL DATABASE TEARDOWN (CLEANUP)
pro    =========================================================

pro    [1/5] Dropping Reporting Views...
drop view vw_bi_security_denials;
drop view vw_bi_top_customers;
drop view vw_bi_employee_activity;
drop view vw_bi_audit_daily;
drop view vw_bi_inventory_health;
drop view vw_bi_sales_overview;

pro    [2/5] Dropping Triggers...
drop trigger trg_inventory_low_stock_compound;
drop trigger trg_inventory_audit;
drop trigger trg_inventory_sec_chk;
drop trigger trg_payments_audit;
drop trigger trg_payments_sec_chk;
drop trigger trg_orders_audit;
drop trigger trg_orders_sec_chk;
drop trigger trg_products_price_check;

pro    [3/5] Dropping PL/SQL Packages...
drop package ecomm_order_pkg;
drop package ecomm_security_pkg;

pro    [4/5] Dropping Schema Tables (Cascading Constraints)...
drop table audit_log cascade constraints;
drop table payments cascade constraints;
drop table order_items cascade constraints;
drop table orders cascade constraints;
drop table inventory cascade constraints;
drop table products cascade constraints;
drop table product_categories cascade constraints;
drop table customers cascade constraints;
drop table employees cascade constraints;

pro    [5/5] Dropping Sequences...
drop sequence seq_audit_log;

pro    =========================================================
pro     TEARDOWN COMPLETE! Schema is completely clean.
pro    =========================================================

SPOOL OFF;