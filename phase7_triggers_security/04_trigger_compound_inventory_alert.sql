/*==============================================================
  PHASE VII -- TRIGGERS, SECURITY & AUDITING
  Script 04: Compound Trigger for Batch Inventory Alerting
  Run as  : ECOMM_ADMIN
==============================================================*/

create or replace trigger trg_inventory_low_stock_compound for
   update of quantity_on_hand on inventory
compound trigger
   type t_low_stock_rec is record (
         product_id    inventory.product_id%type,
         new_qty       inventory.quantity_on_hand%type,
         reorder_level inventory.reorder_level%type
   );
   type t_low_stock_list is
      table of t_low_stock_rec index by pls_integer;
   g_low_stock_items t_low_stock_list;
   before statement is begin
      g_low_stock_items.delete;
   end before statement;
   after each row is
      v_idx               pls_integer;
      v_effective_reorder number;
   begin
    -- Use NEW reorder level, fall back to OLD, or default to 10
      v_effective_reorder := nvl(
         :new.reorder_level,
         nvl(
                 :old.reorder_level,
                 10
              )
      );

    -- Queue alert if new quantity drops below reorder level
      if :new.quantity_on_hand < v_effective_reorder then
         v_idx := g_low_stock_items.count + 1;
         g_low_stock_items(v_idx).product_id := :new.product_id;
         g_low_stock_items(v_idx).new_qty := :new.quantity_on_hand;
         g_low_stock_items(v_idx).reorder_level := v_effective_reorder;
      end if;
   end after each row;
   after statement is begin
      for i in 1..g_low_stock_items.count loop
         ecomm_security_pkg.log_audit_event(
            p_table_name     => 'INVENTORY',
            p_operation_type => 'UPDATE',
            p_record_pk      => to_char(g_low_stock_items(i).product_id),
            p_old_value      => null,
            p_new_value      => 'LOW_STOCK_ALERT: Qty='
                           || g_low_stock_items(i).new_qty
                           || ', ReorderThreshold='
                           || g_low_stock_items(i).reorder_level,
            p_action_status  => 'ALERT'
         );
      end loop;

      g_low_stock_items.delete;
   end after statement;
end trg_inventory_low_stock_compound;
/
SHOW ERRORS TRIGGER trg_inventory_low_stock_compound;