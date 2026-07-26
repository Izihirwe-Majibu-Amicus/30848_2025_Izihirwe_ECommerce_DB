/*==============================================================
  PHASE VI -- PL/SQL DEVELOPMENT
  Script 01: Standalone parameterized function
  Run as  : ECOMM_ADMIN
==============================================================*/

create or replace function get_product_price (
   p_product_id in products.product_id%type
) return number is
   v_price products.unit_price%type;
begin
   select unit_price
     into v_price
     from products
    where product_id = p_product_id;

   return v_price;
exception
   when no_data_found then
      raise_application_error(
         -20001,
         'Product ID '
         || p_product_id
         || ' does not exist.'
      );
end get_product_price;
/

SHOW ERRORS FUNCTION get_product_price;

-- Quick test query
select product_id,
       product_name,
       get_product_price(product_id) as price
  from products
 where rownum <= 3;