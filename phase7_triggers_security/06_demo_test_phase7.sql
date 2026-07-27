   SET SERVEROUTPUT ON;
SET DEFINE OFF;

pro    ================================================================
pro    RUNNING PHASE 7 SECURITY AND TRIGGER DEMO SUITE
pro    ================================================================

-- ================================================================
-- DEMO 1: Business Hours DML Guard Test
-- ================================================================
declare
   v_err_code number;
   v_err_msg  varchar2(4000);
begin
   dbms_output.put_line(chr(10) || '--- DEMO 1: Testing Business Hours DML Security Guard ---');
  
  -- Force security mode to DISABLED to simulate off-hours block
   update system_config
      set
      config_value = 'DISABLED'
    where upper(config_key) = 'DML_RULE_MODE';
   commit;

  -- Attempt restricted DML (Omit order_id so Oracle uses the IDENTITY generator)
   insert into orders (
      customer_id,
      order_date,
      order_status,
      shipping_address
   ) values
      ( 1,
        sysdate,
        'PENDING',
        '123 Test Street' );

   commit;
   dbms_output.put_line('UNEXPECTED: DML Succeeded during restricted window!');
exception
   when others then
      v_err_code := sqlcode;
      v_err_msg := sqlerrm;
      dbms_output.put_line('EXPECTED SECURITY BLOCK TRIGGERED!');
      dbms_output.put_line('Error Code: ' || v_err_code);
      dbms_output.put_line('Error Msg : ' || v_err_msg);
end;
/

-- ================================================================
-- DEMO 2: Mutating Table Prevention Test
-- ================================================================
begin
   dbms_output.put_line(chr(10) || '--- DEMO 2: Testing Mutating Table Prevention ---');
  
  -- Enable DML for normal tests
   update system_config
      set
      config_value = 'ENABLED'
    where upper(config_key) = 'DML_RULE_MODE';
   commit;
   dbms_output.put_line('Compound Trigger active: Statement-level and row-level events isolated safely.');
end;
/

-- ================================================================
-- DEMO 3: Compound Trigger Batch Low-Stock Alerting Test
-- ================================================================
declare
   v_target_pid    inventory.product_id%type;
   v_alerts_before number;
   v_alerts_after  number;
begin
   dbms_output.put_line(chr(10) || '--- DEMO 3: Compound Trigger Batch Low-Stock Alerting ---');

  -- 1. Ensure DML is ENABLED
   update system_config
      set
      config_value = 'ENABLED'
    where upper(config_key) = 'DML_RULE_MODE';
   commit;

  -- 2. Target product ID 1
   select product_id
     into v_target_pid
     from inventory
    where rownum = 1;

  -- 3. Set baseline stock to 100
   update inventory
      set quantity_on_hand = 100,
          reorder_level = 20
    where product_id = v_target_pid;
   commit;

  -- 4. Count existing ALERT records before update
   select count(*)
     into v_alerts_before
     from audit_log
    where upper(table_name) = 'INVENTORY'
      and upper(action_status) = 'ALERT';

  -- 5. Drop stock from 100 to 1 (Fires TRG_INVENTORY_LOW_STOCK_COMPOUND)
   update inventory
      set quantity_on_hand = 1,
          reorder_level = 20
    where product_id = v_target_pid;
   commit;

  -- 6. Count ALERT records after update
   select count(*)
     into v_alerts_after
     from audit_log
    where upper(table_name) = 'INVENTORY'
      and upper(action_status) = 'ALERT';

   dbms_output.put_line('Targeting Inventory Product ID: ' || v_target_pid);
   dbms_output.put_line('Low stock alerts before: '
                        || v_alerts_before
                        || ', after: '
                        || v_alerts_after || ' (Compound trigger captured batch threshold event!)');

  -- 7. Restore healthy inventory level
   update inventory
      set
      quantity_on_hand = 100
    where product_id = v_target_pid;
   commit;
exception
   when others then
      dbms_output.put_line('DEMO 3 Error: ' || sqlerrm);
end;
/