/*==============================================================
  PHASE VII -- TRIGGERS, SECURITY & AUDITING
  Script 05: Business Rule Enforcement Triggers
  Run as  : ECOMM_ADMIN

  Guards data integrity for products, payments, and inventory.
==============================================================*/

------------------------------------------------------------------
-- 1. PRODUCTS Price Integrity Trigger
------------------------------------------------------------------
create or replace trigger trg_products_price_check before
   insert or update of unit_price on products
   for each row
begin
   if :new.unit_price <= 0 then
      raise_application_error(
         -20060,
         'Product unit_price must be greater than zero.'
      );
   end if;

  -- Prevent accidental price reductions exceeding 80% in a single update
   if
      updating
      and :new.unit_price < ( :old.unit_price * 0.20 )
   then
      raise_application_error(
         -20061,
         'Price reduction exceeds maximum allowed threshold (80%).'
      );
   end if;
end;
/
SHOW ERRORS TRIGGER trg_products_price_check;

------------------------------------------------------------------
-- 2. PAYMENTS Amount Validation Trigger
------------------------------------------------------------------
create or replace trigger trg_payments_amount_check before
   insert or update of amount on payments
   for each row
begin
   if :new.amount <= 0 then
      raise_application_error(
         -20062,
         'Payment amount must be greater than zero.'
      );
   end if;
end;
/
SHOW ERRORS TRIGGER trg_payments_amount_check;

------------------------------------------------------------------
-- 3. INVENTORY Non-Negative Stock Check Trigger
------------------------------------------------------------------
create or replace trigger trg_inventory_negative_check before
   insert or update of quantity_on_hand on inventory
   for each row
begin
   if :new.quantity_on_hand < 0 then
      raise_application_error(
         -20063,
         'Inventory quantity_on_hand cannot be negative.'
      );
   end if;
end;
/
SHOW ERRORS TRIGGER trg_inventory_negative_check;