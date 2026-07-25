/*==============================================================
  PHASE V -- TABLE IMPLEMENTATION
  Script 04: Useful Business Views & Reporting
  Run as  : ECOMM_ADMIN
==============================================================*/

-- 1. View: Product Inventory Status
create or replace view vw_inventory_status as
   select p.product_id,
          p.product_name,
          pc.category_name,
          p.unit_price,
          i.quantity_on_hand,
          i.reorder_level,
          case
             when i.quantity_on_hand <= i.reorder_level then
                'RESTOCK REQUIRED'
             else
                'SUFFICIENT'
          end as stock_status
     from products p
     join product_categories pc
   on p.category_id = pc.category_id
     join inventory i
   on p.product_id = i.product_id;

-- 2. View: Order Summary & Revenue Tracking
create or replace view vw_order_summary as
   select o.order_id,
          c.first_name
          || ' '
          || c.last_name as customer_name,
          c.email as customer_email,
          o.order_date,
          o.order_status,
          count(oi.order_item_id) as total_items,
          nvl(
             sum(oi.subtotal),
             0
          ) as total_order_amount,
          p.payment_status,
          p.payment_method
     from orders o
     join customers c
   on o.customer_id = c.customer_id
     left join order_items oi
   on o.order_id = oi.order_id
     left join payments p
   on o.order_id = p.order_id
    group by o.order_id,
             c.first_name,
             c.last_name,
             c.email,
             o.order_date,
             o.order_status,
             p.payment_status,
             p.payment_method;

-- Query the views to verify
pro    ============================================================;
pro    VIEW 1: vw_inventory_status
pro    ============================================================;
select *
  from vw_inventory_status;

pro    ============================================================;
pro    VIEW 2: vw_order_summary
pro    ============================================================;
select *
  from vw_order_summary;