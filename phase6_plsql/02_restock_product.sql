/*==============================================================
  PHASE VI -- PL/SQL DEVELOPMENT
  Script 02: Standalone parameterized procedure
  Run as  : ECOMM_ADMIN

  Demonstrates: parameterized procedure, UPDATE ... RETURNING,
  SQL%ROWCOUNT, and clean exception handling with ROLLBACK.
==============================================================*/

create or replace procedure restock_product (
   p_product_id in inventory.product_id%type,
   p_quantity   in number
) is
   v_new_qty inventory.quantity_on_hand%type;
begin
   if p_quantity <= 0 then
      raise_application_error(
         -20002,
         'Restock quantity must be positive.'
      );
   end if;
   update inventory
      set quantity_on_hand = quantity_on_hand + p_quantity,
          last_restock_date = sysdate
    where product_id = p_product_id returning quantity_on_hand into v_new_qty;

  -- SQL%ROWCOUNT detects if zero rows matched the UPDATE
   if sql%rowcount = 0 then
      raise_application_error(
         -20003,
         'No inventory record found for product_id ' || p_product_id
      );
   end if;

   commit;
   dbms_output.put_line('Product '
                        || p_product_id
                        || ' restocked. New quantity: ' || v_new_qty);
exception
   when others then
      rollback;
      raise;
end restock_product;
/

SHOW ERRORS PROCEDURE restock_product;

-- Smoke test execution
SET SERVEROUTPUT ON;
EXEC restock_product(p_product_id => 1, p_quantity => 20);