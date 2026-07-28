/*==============================================================
  EXECUTIVE BI ANALYTICS REPORT
  Project: Enterprise E-Commerce Database Architecture
  Author: Izihirwe-Majibu-Amicus
  Run as: ECOMM_ADMIN
==============================================================*/

   SET LINESIZE 200;
SET PAGESIZE 100;
SET FEEDBACK ON;

pro    =========================================================
pro     REPORT 1: DAILY REVENUE & ORDER TRENDS
pro    =========================================================
select order_day,
       order_count,
       to_char(
          total_revenue,
          '$999,999.00'
       ) as formatted_revenue,
       to_char(
          avg_order_value,
          '$999,999.00'
       ) as formatted_aov
  from vw_bi_sales_overview
 order by order_day desc;


pro    =========================================================
pro     REPORT 2: CRITICAL INVENTORY & REORDER ALERTS
pro    =========================================================
select product_id,
       product_name,
       category_name,
       quantity_on_hand,
       reorder_level,
       stock_status,
       pct_of_reorder_level || '%' as stock_health_pct
  from vw_bi_inventory_health
 where stock_status = 'LOW STOCK'
 order by pct_of_reorder_level asc;


pro    =========================================================
pro     REPORT 3: TOP 5 CUSTOMERS BY LIFETIME SPEND
pro    =========================================================
select customer_id,
       customer_name,
       city,
       order_count,
       to_char(
          lifetime_spend,
          '$999,999.00'
       ) as total_spend
  from vw_bi_top_customers
 order by lifetime_spend desc
 fetch first 5 rows only;


pro    =========================================================
pro     REPORT 4: SECURITY DENIAL BREAKDOWN (OFF-HOURS & THREATS)
pro    =========================================================
select denial_date,
       denial_hour || ':00' as hour_of_day,
       denial_day_of_week,
       table_name,
       operation_type,
       db_username,
       denial_count
  from vw_bi_security_denials
 order by denial_date desc,
          denial_count desc;


pro    =========================================================
pro     REPORT 5: EMPLOYEE ACCOUNTABILITY AUDIT
pro    =========================================================
select employee_id,
       employee_name,
       position,
       table_name,
       operation_type,
       action_status,
       event_count,
       to_char(
          last_activity,
          'YYYY-MM-DD HH24:MI:SS'
       ) as last_active
  from vw_bi_employee_activity
 order by last_activity desc;