/*==============================================================
  PHASE VI -- PL/SQL DEVELOPMENT
  Script 03: ECOMM_ORDER_PKG -- Order Lifecycle Package
  Run as  : ECOMM_ADMIN

  Implements atomic transaction processing (PLACE_ORDER) with
  concurrency locking (FOR UPDATE) and complete ROLLBACK on error.
==============================================================*/

------------------------------------------------------------------
-- PACKAGE SPECIFICATION
------------------------------------------------------------------
create or replace package ecomm_order_pkg is

  -- Collection type for order line items
   type t_order_item_rec is record (
         product_id order_items.product_id%type,
         quantity   order_items.quantity%type
   );
   type t_order_item_list is
      table of t_order_item_rec index by pls_integer;
   e_insufficient_stock exception;
   e_empty_order exception;
   procedure place_order (
      p_customer_id      in customers.customer_id%type,
      p_employee_id      in employees.employee_id%type default null,
      p_shipping_address in orders.shipping_address%type,
      p_items            in t_order_item_list,
      p_order_id         out orders.order_id%type
   );

   procedure add_order_item (
      p_order_id   in order_items.order_id%type,
      p_product_id in order_items.product_id%type,
      p_quantity   in order_items.quantity%type
   );

   procedure cancel_order (
      p_order_id in orders.order_id%type
   );

   procedure process_payment (
      p_order_id in orders.order_id%type,
      p_amount   in payments.amount%type,
      p_method   in payments.payment_method%type,
      p_status   out payments.payment_status%type
   );

   function calculate_order_total (
      p_order_id in orders.order_id%type
   ) return number;
   function get_stock_level (
      p_product_id in products.product_id%type
   ) return number;
   function get_customer_orders (
      p_customer_id in customers.customer_id%type
   ) return sys_refcursor;

end ecomm_order_pkg;
/

SHOW ERRORS PACKAGE ecomm_order_pkg;

------------------------------------------------------------------
-- PACKAGE BODY
------------------------------------------------------------------
create or replace package body ecomm_order_pkg is

  -- PRIVATE HELPER: encapsulated inventory check and decrement
   procedure p_apply_order_item (
      p_order_id   in order_items.order_id%type,
      p_product_id in order_items.product_id%type,
      p_quantity   in order_items.quantity%type
   ) is
      v_stock      inventory.quantity_on_hand%type;
      v_unit_price products.unit_price%type;
   begin
    -- Locks inventory row for current transaction
      select quantity_on_hand
        into v_stock
        from inventory
       where product_id = p_product_id
      for update;

      if v_stock < p_quantity then
         raise e_insufficient_stock;
      end if;
      select unit_price
        into v_unit_price
        from products
       where product_id = p_product_id;

      insert into order_items (
         order_id,
         product_id,
         quantity,
         unit_price
      ) values
         ( p_order_id,
           p_product_id,
           p_quantity,
           v_unit_price );

      update inventory
         set
         quantity_on_hand = quantity_on_hand - p_quantity
       where product_id = p_product_id;

   exception
      when no_data_found then
         raise_application_error(
            -20011,
            'Product ID '
            || p_product_id
            || ' not found in catalog or inventory.'
         );
   end p_apply_order_item;


   procedure place_order (
      p_customer_id      in customers.customer_id%type,
      p_employee_id      in employees.employee_id%type default null,
      p_shipping_address in orders.shipping_address%type,
      p_items            in t_order_item_list,
      p_order_id         out orders.order_id%type
   ) is
   begin
      if p_items.count = 0 then
         raise e_empty_order;
      end if;
      insert into orders (
         customer_id,
         employee_id,
         shipping_address
      ) values
         ( p_customer_id,
           p_employee_id,
           p_shipping_address )
      returning order_id into p_order_id;

      for i in p_items.first..p_items.last loop
         p_apply_order_item(
            p_order_id,
            p_items(i).product_id,
            p_items(i).quantity
         );
      end loop;

      commit;
   exception
      when e_empty_order then
         rollback;
         raise_application_error(
            -20012,
            'PLACE_ORDER requires at least one item.'
         );
      when e_insufficient_stock then
         rollback;
         raise_application_error(
            -20013,
            'PLACE_ORDER failed: insufficient stock for one or more items.'
         );
      when others then
         rollback;
         raise_application_error(
            -20099,
            'PLACE_ORDER failed: ' || sqlerrm
         );
   end place_order;


   procedure add_order_item (
      p_order_id   in order_items.order_id%type,
      p_product_id in order_items.product_id%type,
      p_quantity   in order_items.quantity%type
   ) is
      v_status orders.order_status%type;
   begin
      select order_status
        into v_status
        from orders
       where order_id = p_order_id
      for update;

      if v_status <> 'PENDING' then
         raise_application_error(
            -20014,
            'Cannot add items to an order that is not PENDING (current status: '
            || v_status
            || ').'
         );
      end if;

      p_apply_order_item(
         p_order_id,
         p_product_id,
         p_quantity
      );
      commit;
   exception
      when e_insufficient_stock then
         rollback;
         raise_application_error(
            -20013,
            'ADD_ORDER_ITEM failed: insufficient stock.'
         );
      when no_data_found then
         rollback;
         raise_application_error(
            -20015,
            'Order ID '
            || p_order_id
            || ' not found.'
         );
      when others then
         rollback;
         raise_application_error(
            -20099,
            'ADD_ORDER_ITEM failed: ' || sqlerrm
         );
   end add_order_item;


   procedure cancel_order (
      p_order_id in orders.order_id%type
   ) is
      cursor c_items is
      select product_id,
             quantity
        from order_items
       where order_id = p_order_id;
      v_status orders.order_status%type;
   begin
      select order_status
        into v_status
        from orders
       where order_id = p_order_id
      for update;

      if v_status in ( 'SHIPPED',
                       'DELIVERED' ) then
         raise_application_error(
            -20016,
            'Cannot cancel an order that has already shipped or been delivered.'
         );
      end if;

      for item_rec in c_items loop
         update inventory
            set
            quantity_on_hand = quantity_on_hand + item_rec.quantity
          where product_id = item_rec.product_id;
      end loop;

      update orders
         set
         order_status = 'CANCELLED'
       where order_id = p_order_id;
      commit;
   exception
      when no_data_found then
         rollback;
         raise_application_error(
            -20015,
            'Order ID '
            || p_order_id
            || ' not found.'
         );
      when others then
         rollback;
         raise_application_error(
            -20099,
            'CANCEL_ORDER failed: ' || sqlerrm
         );
   end cancel_order;


   procedure process_payment (
      p_order_id in orders.order_id%type,
      p_amount   in payments.amount%type,
      p_method   in payments.payment_method%type,
      p_status   out payments.payment_status%type
   ) is
      v_exists number;
   begin
      select count(*)
        into v_exists
        from orders
       where order_id = p_order_id;
      if v_exists = 0 then
         raise_application_error(
            -20015,
            'Order ID '
            || p_order_id
            || ' not found.'
         );
      end if;

      if p_amount <= 0 then
         raise_application_error(
            -20017,
            'Payment amount must be positive.'
         );
      end if;
      insert into payments (
         order_id,
         amount,
         payment_method,
         payment_status
      ) values
         ( p_order_id,
           p_amount,
           p_method,
           'SUCCESS' )
      returning payment_status into p_status;

      update orders
         set
         order_status = 'CONFIRMED'
       where order_id = p_order_id
         and order_status = 'PENDING';

      commit;
   exception
      when others then
         rollback;
         p_status := 'FAILED';
         raise;
   end process_payment;


   function calculate_order_total (
      p_order_id in orders.order_id%type
   ) return number is
      v_total number(
         12,
         2
      );
   begin
      select nvl(
         sum(subtotal),
         0
      )
        into v_total
        from order_items
       where order_id = p_order_id;
      return v_total;
   end calculate_order_total;


   function get_stock_level (
      p_product_id in products.product_id%type
   ) return number is
      v_qty number;
   begin
      select quantity_on_hand
        into v_qty
        from inventory
       where product_id = p_product_id;
      return v_qty;
   exception
      when no_data_found then
         raise_application_error(
            -20011,
            'No inventory record for product_id ' || p_product_id
         );
   end get_stock_level;


   function get_customer_orders (
      p_customer_id in customers.customer_id%type
   ) return sys_refcursor is
      v_cursor sys_refcursor;
   begin
      open v_cursor for select o.order_id,
                               o.order_date,
                               o.order_status,
                               calculate_order_total(o.order_id) as total_amount
                                            from orders o
                         where o.customer_id = p_customer_id
                         order by o.order_date desc;
      return v_cursor;
   end get_customer_orders;

end ecomm_order_pkg;
/

SHOW ERRORS PACKAGE BODY ecomm_order_pkg;