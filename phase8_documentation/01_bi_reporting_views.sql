/*==============================================================
  PHASE VIII -- INNOVATION: POWER BI SUPPORT VIEWS
  Run as: ECOMM_ADMIN
==============================================================*/

-- ---------------------------------------------------------------
-- 1. Sales trend -- line/area chart over time
-- ---------------------------------------------------------------
create or replace view vw_bi_sales_overview as
   select trunc(o.order_date) as order_day,
          count(distinct o.order_id) as order_count,
          sum(oi.subtotal) as total_revenue,
          round(
             sum(oi.subtotal) / nullif(
                count(distinct o.order_id),
                0
             ),
             2
          ) as avg_order_value
     from orders o
     join order_items oi
   on oi.order_id = o.order_id
    where o.order_status not in ( 'REJECTED',
                                  'CANCELLED' )
    group by trunc(o.order_date);

-- ---------------------------------------------------------------
-- 2. Inventory health -- table/card visual with conditional formatting
-- ---------------------------------------------------------------
create or replace view vw_bi_inventory_health as
   select p.product_id,
          p.product_name,
          pc.category_name,
          i.quantity_on_hand,
          i.reorder_level,
          case
             when i.quantity_on_hand < i.reorder_level then
                'LOW STOCK'
             else
                'OK'
          end as stock_status,
          round(
             i.quantity_on_hand / nullif(
                i.reorder_level,
                0
             ) * 100,
             1
          ) as pct_of_reorder_level
     from inventory i
     join products p
   on p.product_id = i.product_id
     join product_categories pc
   on pc.category_id = p.category_id;

-- ---------------------------------------------------------------
-- 3. Audit activity by day/table/outcome
-- ---------------------------------------------------------------
create or replace view vw_bi_audit_daily as
   select trunc(action_timestamp) as activity_date,
          table_name,
          action_status,
          count(*) as event_count
     from audit_log
    group by trunc(action_timestamp),
             table_name,
             action_status;

-- ---------------------------------------------------------------
-- 4. Employee accountability
-- ---------------------------------------------------------------
create or replace view vw_bi_employee_activity as
   select e.employee_id,
          e.first_name
          || ' '
          || e.last_name as employee_name,
          e.position,
          a.table_name,
          a.operation_type,
          a.action_status,
          count(*) as event_count,
          max(a.action_timestamp) as last_activity
     from audit_log a
     join employees e
   on e.db_username = a.db_username
    group by e.employee_id,
             e.first_name,
             e.last_name,
             e.position,
             a.table_name,
             a.operation_type,
             a.action_status;

-- ---------------------------------------------------------------
-- 5. Top customers by lifetime spend
-- ---------------------------------------------------------------
create or replace view vw_bi_top_customers as
   select c.customer_id,
          c.first_name
          || ' '
          || c.last_name as customer_name,
          c.city,
          count(distinct o.order_id) as order_count,
          sum(oi.subtotal) as lifetime_spend
     from customers c
     join orders o
   on o.customer_id = c.customer_id
     join order_items oi
   on oi.order_id = o.order_id
    where o.order_status not in ( 'REJECTED',
                                  'CANCELLED' )
    group by c.customer_id,
             c.first_name,
             c.last_name,
             c.city;

-- ---------------------------------------------------------------
-- 6. THE CENTERPIECE: denied DML attempts
-- ---------------------------------------------------------------
create or replace view vw_bi_security_denials as
   select trunc(action_timestamp) as denial_date,
          to_char(
             action_timestamp,
             'HH24'
          ) as denial_hour,
          to_char(
             action_timestamp,
             'DY',
             'NLS_DATE_LANGUAGE=ENGLISH'
          ) as denial_day_of_week,
          table_name,
          operation_type,
          db_username,
          count(*) as denial_count
     from audit_log
    where action_status = 'DENIED'
    group by trunc(action_timestamp),
             to_char(
                action_timestamp,
                'HH24'
             ),
             to_char(
                action_timestamp,
                'DY',
                'NLS_DATE_LANGUAGE=ENGLISH'
             ),
             table_name,
             operation_type,
             db_username;

-- ---------------------------------------------------------------


-- Verify
select view_name
  from user_views
 where view_name like 'VW_BI_%'
 order by view_name;