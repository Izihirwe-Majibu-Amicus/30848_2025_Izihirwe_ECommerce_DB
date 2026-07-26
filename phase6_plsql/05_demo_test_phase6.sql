/*==============================================================
  PHASE VI -- PL/SQL DEVELOPMENT
  Script 05: Demonstration / Test Suite
  Run as  : ECOMM_ADMIN
==============================================================*/

   SET SERVEROUTPUT ON SIZE UNLIMITED

-- ================================================================
-- DEMO 1: PLACE_ORDER -- Valid multi-item transaction
-- ================================================================
declare
   v_items    ecomm_order_pkg.t_order_item_list;
   v_order_id orders.order_id%type;
begin
   dbms_output.put_line(chr(10) || '--- DEMO 1: PLACE_ORDER (expected: success) ---');
   v_items(1).product_id := 1; -- Wireless Ergonomic Mouse
   v_items(1).quantity := 2;
   v_items(2).product_id := 2; -- 64GB USB 3.0 Flash Drive
   v_items(2).quantity := 1;
   ecomm_order_pkg.place_order(
      p_customer_id      => 1,
      p_employee_id      => 1,
      p_shipping_address => 'Kigali, Nyarugenge',
      p_items            => v_items,
      p_order_id         => v_order_id
   );

   dbms_output.put_line('Order created: order_id = '
                        || v_order_id
                        || ', total = ' || ecomm_order_pkg.calculate_order_total(v_order_id));
end;
/

-- ================================================================
-- DEMO 2: PLACE_ORDER with insufficient stock (proves ROLLBACK)
-- ================================================================
declare
   v_items         ecomm_order_pkg.t_order_item_list;
   v_order_id      orders.order_id%type;
   v_orders_before number;
   v_orders_after  number;
begin
   dbms_output.put_line(chr(10) || '--- DEMO 2: PLACE_ORDER (expected: FAIL, insufficient stock) ---');
   select count(*)
     into v_orders_before
     from orders;

   v_items(1).product_id := 1;
   v_items(1).quantity := 999999; -- Beyond available stock

   begin
      ecomm_order_pkg.place_order(
         p_customer_id      => 1,
         p_employee_id      => null,
         p_shipping_address => 'Kigali, Gasabo',
         p_items            => v_items,
         p_order_id         => v_order_id
      );
   exception
      when others then
         dbms_output.put_line('Caught expected error: ' || sqlerrm);
   end;

   select count(*)
     into v_orders_after
     from orders;
   dbms_output.put_line('Orders before: '
                        || v_orders_before
                        || ', after: '
                        || v_orders_after || ' (EQUAL counts prove atomic ROLLBACK)');
end;
/

-- ================================================================
-- DEMO 3: GET_CUSTOMER_ORDERS -- Consuming a REF CURSOR
-- ================================================================
declare
   v_cursor     sys_refcursor;
   v_order_id   orders.order_id%type;
   v_order_date orders.order_date%type;
   v_status     orders.order_status%type;
   v_total      number;
begin
   dbms_output.put_line(chr(10) || '--- DEMO 3: GET_CUSTOMER_ORDERS (Customer 1) ---');
   v_cursor := ecomm_order_pkg.get_customer_orders(1);
   loop
      fetch v_cursor into
         v_order_id,
         v_order_date,
         v_status,
         v_total;
      exit when v_cursor%notfound;
      dbms_output.put_line('Order '
                           || v_order_id
                           || ' | '
                           || to_char(
         v_order_date,
         'YYYY-MM-DD'
      )
                           || ' | '
                           || v_status
                           || ' | Total: ' || v_total);
   end loop;
   close v_cursor;
end;
/

-- ================================================================
-- DEMO 4 & 5: LOW_STOCK_REPORT
-- ================================================================
begin
   dbms_output.put_line(chr(10) || '--- DEMO 4: LOW_STOCK_REPORT (default threshold) ---');
   ecomm_admin_pkg.low_stock_report;
end;
/

begin
   dbms_output.put_line(chr(10) || '--- DEMO 5: LOW_STOCK_REPORT (override threshold = 100) ---');
   ecomm_admin_pkg.low_stock_report(p_threshold_override => 100);
end;
/

-- ================================================================
-- DEMO 6: CANCEL_ORDER -- Restores inventory
-- ================================================================
declare
   v_order_id   orders.order_id%type;
   v_qty_before number;
   v_qty_after  number;
begin
   dbms_output.put_line(chr(10) || '--- DEMO 6: CANCEL_ORDER ---');
   select max(order_id)
     into v_order_id
     from orders
    where order_status = 'PENDING';

   v_qty_before := ecomm_order_pkg.get_stock_level(1);
   ecomm_order_pkg.cancel_order(v_order_id);
   v_qty_after := ecomm_order_pkg.get_stock_level(1);
   dbms_output.put_line('Product 1 stock before cancel: '
                        || v_qty_before
                        || ', after cancel: '
                        || v_qty_after || ' (stock restored)');
end;
/

-- ================================================================
-- DEMO 7: PROCESS_PAYMENT
-- ================================================================
declare
   v_order_id orders.order_id%type;
   v_status   payments.payment_status%type;
begin
   dbms_output.put_line(chr(10) || '--- DEMO 7: PROCESS_PAYMENT ---');
   select min(order_id)
     into v_order_id
     from orders;

   ecomm_order_pkg.process_payment(
      p_order_id => v_order_id,
      p_amount   => ecomm_order_pkg.calculate_order_total(v_order_id),
      p_method   => 'MOBILE_MONEY',
      p_status   => v_status
   );

   dbms_output.put_line('Payment status for order '
                        || v_order_id
                        || ': ' || v_status);
end;
/

-- ================================================================
-- DEMO 8: RESTOCK_PRODUCT
-- ================================================================
begin
   dbms_output.put_line(chr(10) || '--- DEMO 8: RESTOCK_PRODUCT ---');
   restock_product(
      p_product_id => 2,
      p_quantity   => 50
   );
end;
/

-- ================================================================
-- DEMO 9: ARCHIVE_AUDIT_LOG
-- ================================================================
begin
   dbms_output.put_line(chr(10) || '--- DEMO 9: ARCHIVE_AUDIT_LOG ---');
   ecomm_admin_pkg.archive_audit_log(sysdate);
end;
/

-- ================================================================
-- DEMO 10: GET_PRODUCT_PRICE
-- ================================================================
declare
   v_price number;
begin
   dbms_output.put_line(chr(10) || '--- DEMO 10: GET_PRODUCT_PRICE ---');
   v_price := get_product_price(1);
   dbms_output.put_line('Product 1 unit price: ' || v_price);
end;
/