/*==============================================================
  PHASE V -- TABLE IMPLEMENTATION
  Script 02: Seed Data Insertion
  Run as  : ECOMM_ADMIN
==============================================================*/

-- 1. Product Categories
insert into product_categories (
   category_name,
   description
) values
   ( 'Electronics',
     'Smartphones, laptops, and consumer electronic accessories' );

insert into product_categories (
   category_name,
   description
) values
   ( 'Computing',
     'Desktop hardware, peripherals, and storage solutions' );

insert into product_categories (
   category_name,
   description
) values
   ( 'Office Supplies',
     'Stationery, desk items, and office gear' );


-- 2. Suppliers
insert into suppliers (
   supplier_name,
   contact_person,
   phone,
   email,
   address,
   status
) values
   ( 'Kigali Tech Imports',
     'Jean Luc Habimana',
     '+250788111222',
     'sales@kigalitech.rw',
     'Kigali, Nyarugenge',
     'ACTIVE' );

insert into suppliers (
   supplier_name,
   contact_person,
   phone,
   email,
   address,
   status
) values
   ( 'Great Lakes Electronics',
     'Aline Uwase',
     '+250788333444',
     'info@greatlakeselec.rw',
     'Kigali, Gasabo',
     'ACTIVE' );


-- 3. Customers
insert into customers (
   first_name,
   last_name,
   email,
   phone,
   address,
   city,
   country,
   status
) values
   ( 'Eric',
     'Mugisha',
     'eric.mugisha@gmail.com',
     '+250789000111',
     'KN 5 Rd',
     'Kigali',
     'Rwanda',
     'ACTIVE' );

insert into customers (
   first_name,
   last_name,
   email,
   phone,
   address,
   city,
   country,
   status
) values
   ( 'Divine',
     'Iradukunda',
     'divine.ira@yahoo.com',
     '+250789222333',
     'KG 11 Ave',
     'Kigali',
     'Rwanda',
     'ACTIVE' );


-- 4. Employees
insert into employees (
   first_name,
   last_name,
   position,
   db_username,
   email,
   phone,
   status
) values
   ( 'Admin',
     'User',
     'ADMIN',
     'ECOMM_ADMIN',
     'admin@ecommerce.rw',
     '+250788555666',
     'ACTIVE' );

insert into employees (
   first_name,
   last_name,
   position,
   db_username,
   email,
   phone,
   status
) values
   ( 'Keza',
     'Aline',
     'SALES_STAFF',
     'STAFF_KEZA',
     'keza.sales@ecommerce.rw',
     '+250788777888',
     'ACTIVE' );


-- 5. Public Holidays
insert into public_holidays (
   holiday_date,
   holiday_name,
   is_recurring_yearly
) values
   ( to_date('2026-01-01','YYYY-MM-DD'),
     'New Year Day',
     'Y' );

insert into public_holidays (
   holiday_date,
   holiday_name,
   is_recurring_yearly
) values
   ( to_date('2026-07-01','YYYY-MM-DD'),
     'Independence Day',
     'Y' );


-- 6. System Configuration
insert into system_config (
   config_key,
   config_value,
   description
) values
   ( 'TAX_RATE',
     '0.18',
     'Standard Value Added Tax (VAT) rate of 18%' );

insert into system_config (
   config_key,
   config_value,
   description
) values
   ( 'CURRENCY',
     'RWF',
     'Base operating currency' );


-- 7. Products
insert into products (
   category_id,
   product_name,
   description,
   unit_price,
   status
) values
   ( 1,
     'Wireless Ergonomic Mouse',
     '2.4GHz optical rechargeable mouse',
     15000,
     'ACTIVE' );

insert into products (
   category_id,
   product_name,
   description,
   unit_price,
   status
) values
   ( 2,
     '64GB USB 3.0 Flash Drive',
     'High-speed USB drive',
     12000,
     'ACTIVE' );


-- 8. Inventory
insert into inventory (
   product_id,
   quantity_on_hand,
   reorder_level,
   last_restock_date
) values
   ( 1,
     50,
     10,
     sysdate );

insert into inventory (
   product_id,
   quantity_on_hand,
   reorder_level,
   last_restock_date
) values
   ( 2,
     100,
     20,
     sysdate );


-- 9. Supplier Products
insert into supplier_products (
   supplier_id,
   product_id,
   supply_price,
   lead_time_days
) values
   ( 1,
     1,
     10000,
     3 );

insert into supplier_products (
   supplier_id,
   product_id,
   supply_price,
   lead_time_days
) values
   ( 2,
     2,
     7500,
     5 );


-- 10. Orders
insert into orders (
   customer_id,
   employee_id,
   order_date,
   order_status,
   shipping_address
) values
   ( 1,
     2,
     sysdate,
     'CONFIRMED',
     'KN 5 Rd, House 12, Kigali' );


-- 11. Order Items
insert into order_items (
   order_id,
   product_id,
   quantity,
   unit_price
) values
   ( 1,
     1,
     2,
     15000 );


-- 12. Payments
insert into payments (
   order_id,
   payment_date,
   amount,
   payment_method,
   payment_status
) values
   ( 1,
     sysdate,
     30000,
     'MOBILE_MONEY',
     'SUCCESS' );


commit;