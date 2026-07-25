/*==============================================================
  PHASE V -- TABLE IMPLEMENTATION
  Script 03: Business Rules & Constraint Verification
  Run as  : ECOMM_ADMIN
==============================================================*/

   SET SERVEROUTPUT ON;

pro    ============================================================;
pro    TEST 1: Unique Email Constraint (Should Fail with ORA-00001)
pro    ============================================================;
-- Attempt to insert a duplicate customer email
begin
   insert into customers (
      first_name,
      last_name,
      email,
      phone
   ) values
      ( 'Duplicate',
        'Test',
        'eric.mugisha@gmail.com',
        '+250788000999' );
   dbms_output.put_line('FAIL: Duplicate email was allowed!');
exception
   when others then
      dbms_output.put_line('SUCCESS: Blocked duplicate email. Error -> ' || sqlerrm);
end;
/

pro    ============================================================;
pro    TEST 2: Check Constraint on Unit Price (Should Fail with ORA-02290)
pro    ============================================================;
-- Attempt to insert a product with zero or negative price
begin
   insert into products (
      category_id,
      product_name,
      unit_price
   ) values
      ( 1,
        'Negative Price Item',
        - 500 );
   dbms_output.put_line('FAIL: Negative unit price was allowed!');
exception
   when others then
      dbms_output.put_line('SUCCESS: Blocked invalid unit price. Error -> ' || sqlerrm);
end;
/

pro    ============================================================;
pro    TEST 3: Check Constraint on Supplier Status (Should Fail with ORA-02290)
pro    ============================================================;
-- Attempt to insert a supplier with an invalid status code
begin
   insert into suppliers (
      supplier_name,
      status
   ) values
      ( 'Invalid Status Ltd',
        'PENDING' );
   dbms_output.put_line('FAIL: Invalid supplier status was allowed!');
exception
   when others then
      dbms_output.put_line('SUCCESS: Blocked invalid status. Error -> ' || sqlerrm);
end;
/

pro    ============================================================;
pro    TEST 4: Foreign Key Constraint (Should Fail with ORA-02291)
pro    ============================================================;
-- Attempt to create a product referencing a non-existent category_id (9999)
begin
   insert into products (
      category_id,
      product_name,
      unit_price
   ) values
      ( 9999,
        'Orphan Product',
        25000 );
   dbms_output.put_line('FAIL: Non-existent foreign key was allowed!');
exception
   when others then
      dbms_output.put_line('SUCCESS: Blocked foreign key violation. Error -> ' || sqlerrm);
end;
/

pro    ============================================================;
pro    TEST 5: Virtual Column Verification (Subtotal Calculation)
pro    ============================================================;
-- Insert a valid order item and verify calculated subtotal
insert into order_items (
   order_id,
   product_id,
   quantity,
   unit_price
) values
   ( 1,
     2,
     3,
     12000 );

select order_item_id,
       quantity,
       unit_price,
       subtotal
  from order_items
 where product_id = 2;

commit;