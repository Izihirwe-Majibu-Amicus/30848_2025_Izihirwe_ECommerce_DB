/*==============================================================
  PHASE V -- TABLE IMPLEMENTATION
  Script 01: CREATE TABLE statements in strict dependency order
  Run as  : ECOMM_ADMIN
==============================================================*/

alter session set container = pdb_30848_ecommerce;

-- ============================================================
-- LEVEL 0: Tables with no foreign key dependencies
-- ============================================================

create table product_categories (
   category_id   number generated always as identity,
   category_name varchar2(50) not null,
   description   varchar2(200),
   constraint pk_product_categories primary key ( category_id ),
   constraint uq_category_name unique ( category_name )
);

create table suppliers (
   supplier_id    number generated always as identity,
   supplier_name  varchar2(100) not null,
   contact_person varchar2(100),
   phone          varchar2(20),
   email          varchar2(100),
   address        varchar2(200),
   status         varchar2(10) default 'ACTIVE',
   constraint pk_suppliers primary key ( supplier_id ),
   constraint chk_supplier_status check ( status in ( 'ACTIVE',
                                                      'INACTIVE' ) )
);

create table customers (
   customer_id       number generated always as identity,
   first_name        varchar2(50) not null,
   last_name         varchar2(50) not null,
   email             varchar2(100) not null,
   phone             varchar2(20),
   address           varchar2(200),
   city              varchar2(50),
   country           varchar2(50) default 'Rwanda',
   registration_date date default sysdate,
   status            varchar2(10) default 'ACTIVE',
   constraint pk_customers primary key ( customer_id ),
   constraint uq_customer_email unique ( email ),
   constraint chk_customer_status check ( status in ( 'ACTIVE',
                                                      'INACTIVE' ) )
);

create table employees (
   employee_id number generated always as identity,
   first_name  varchar2(50) not null,
   last_name   varchar2(50) not null,
   position    varchar2(50),
   db_username varchar2(30) not null,
   email       varchar2(100),
   phone       varchar2(20),
   hire_date   date default sysdate,
   status      varchar2(10) default 'ACTIVE',
   constraint pk_employees primary key ( employee_id ),
   constraint uq_employee_dbuser unique ( db_username ),
   constraint uq_employee_email unique ( email ),
   constraint chk_employee_position check ( position in ( 'ADMIN',
                                                          'SALES_STAFF' ) ),
   constraint chk_employee_status check ( status in ( 'ACTIVE',
                                                      'INACTIVE' ) )
);

create table public_holidays (
   holiday_id          number generated always as identity,
   holiday_date        date not null,
   holiday_name        varchar2(100) not null,
   is_recurring_yearly char(1) default 'N',
   constraint pk_public_holidays primary key ( holiday_id ),
   constraint uq_holiday_date unique ( holiday_date ),
   constraint chk_recurring check ( is_recurring_yearly in ( 'Y',
                                                             'N' ) )
);

create table system_config (
   config_key   varchar2(50),
   config_value varchar2(200) not null,
   description  varchar2(200),
   updated_date date default sysdate,
   constraint pk_system_config primary key ( config_key )
);

-- ============================================================
-- LEVEL 1: Depends on Level 0
-- ============================================================

create table products (
   product_id   number generated always as identity,
   category_id  number not null,
   product_name varchar2(100) not null,
   description  varchar2(500),
   unit_price   number(10,2) not null,
   status       varchar2(10) default 'ACTIVE',
   created_date date default sysdate,
   constraint pk_products primary key ( product_id ),
   constraint fk_products_category foreign key ( category_id )
      references product_categories ( category_id ),
   constraint chk_unit_price check ( unit_price > 0 ),
   constraint chk_product_status check ( status in ( 'ACTIVE',
                                                     'DISCONTINUED' ) )
);

-- ============================================================
-- LEVEL 2: Depends on Level 1
-- ============================================================

create table inventory (
   inventory_id      number generated always as identity,
   product_id        number not null,
   quantity_on_hand  number default 0 not null,
   reorder_level     number default 10,
   last_restock_date date,
   constraint pk_inventory primary key ( inventory_id ),
   constraint fk_inventory_product foreign key ( product_id )
      references products ( product_id ),
   constraint uq_inventory_product unique ( product_id ),
   constraint chk_qty_nonneg check ( quantity_on_hand >= 0 )
);

create table supplier_products (
   supplier_id    number not null,
   product_id     number not null,
   supply_price   number(10,2),
   lead_time_days number(3),
   constraint pk_supplier_products primary key ( supplier_id,
                                                 product_id ),
   constraint fk_supprod_supplier foreign key ( supplier_id )
      references suppliers ( supplier_id ),
   constraint fk_supprod_product foreign key ( product_id )
      references products ( product_id ),
   constraint chk_supply_price check ( supply_price > 0 )
);

-- ============================================================
-- LEVEL 3: Depends on Customers/Employees (Level 0) + Products
-- ============================================================

create table orders (
   order_id         number generated always as identity,
   customer_id      number not null,
   employee_id      number,
   order_date       date default sysdate not null,
   order_status     varchar2(20) default 'PENDING',
   shipping_address varchar2(200) not null,
   constraint pk_orders primary key ( order_id ),
   constraint fk_orders_customer foreign key ( customer_id )
      references customers ( customer_id ),
   constraint fk_orders_employee foreign key ( employee_id )
      references employees ( employee_id ),
   constraint chk_order_status
      check ( order_status in ( 'PENDING',
                                'CONFIRMED',
                                'SHIPPED',
                                'DELIVERED',
                                'CANCELLED',
                                'REJECTED' ) )
);

-- ============================================================
-- LEVEL 4: Depends on Orders + Products
-- ============================================================

create table order_items (
   order_item_id number generated always as identity,
   order_id      number not null,
   product_id    number not null,
   quantity      number not null,
   unit_price    number(10,2) not null,
   subtotal      number(12,2) generated always as ( quantity * unit_price ) virtual,
   constraint pk_order_items primary key ( order_item_id ),
   constraint fk_oi_order foreign key ( order_id )
      references orders ( order_id ),
   constraint fk_oi_product foreign key ( product_id )
      references products ( product_id ),
   constraint chk_oi_qty check ( quantity > 0 ),
   constraint chk_oi_price check ( unit_price > 0 )
);

create table payments (
   payment_id     number generated always as identity,
   order_id       number not null,
   payment_date   date default sysdate,
   amount         number(12,2) not null,
   payment_method varchar2(20),
   payment_status varchar2(20) default 'PENDING',
   constraint pk_payments primary key ( payment_id ),
   constraint fk_payments_order foreign key ( order_id )
      references orders ( order_id ),
   constraint chk_payment_amount check ( amount > 0 ),
   constraint chk_payment_method
      check ( payment_method in ( 'CARD',
                                  'MOBILE_MONEY',
                                  'BANK_TRANSFER',
                                  'CASH' ) ),
   constraint chk_payment_status
      check ( payment_status in ( 'PENDING',
                                  'SUCCESS',
                                  'FAILED',
                                  'REFUNDED' ) )
);

-- ============================================================
-- LEVEL 0 (Standalone Audit Table)
-- ============================================================

create table audit_log (
   audit_id         number generated always as identity,
   table_name       varchar2(30) not null,
   operation_type   varchar2(10) not null,
   record_pk        varchar2(50),
   db_username      varchar2(30) not null,
   os_username      varchar2(30),
   host_machine     varchar2(100),
   ip_address       varchar2(45),
   module_name      varchar2(100),
   action_timestamp timestamp default systimestamp not null,
   old_value        clob,
   new_value        clob,
   action_status    varchar2(20) default 'SUCCESS',
   constraint pk_audit_log primary key ( audit_id ),
   constraint chk_audit_operation
      check ( operation_type in ( 'INSERT',
                                  'UPDATE',
                                  'DELETE' ) ),
   constraint chk_audit_status check ( action_status in ( 'SUCCESS',
                                                          'DENIED' ) )
);

-- Verify all 13 tables are created
select table_name
  from user_tables
 order by table_name;