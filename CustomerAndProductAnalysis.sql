-- General information about the database

SELECT 'employees' AS table_name, 
       (SELECT COUNT() FROM PRAGMA_TABLE_INFO('employees')) AS number_of_attributes, 
       COUNT(*) AS number_of_rows
  FROM employees
UNION ALL 
SELECT 'customers' AS table_name, 
       (SELECT COUNT() FROM PRAGMA_TABLE_INFO('customers')) AS number_of_attributes, 
       COUNT(*) AS number_of_rows
  FROM customers
UNION ALL
SELECT 'payments' AS table_name, 
       (SELECT COUNT() FROM PRAGMA_TABLE_INFO('payments')) AS number_of_attributes, 
       COUNT(*) AS number_of_rows
  FROM payments
UNION ALL
SELECT 'orders' AS table_name, 
       (SELECT COUNT() FROM PRAGMA_TABLE_INFO('orders')) AS number_of_attributes, 
       COUNT(*) AS number_of_rows
  FROM orders
UNION ALL
SELECT 'orderdetails' AS table_name, 
       (SELECT COUNT() FROM PRAGMA_TABLE_INFO('orderdetails')) AS number_of_attributes, 
       COUNT(*) AS number_of_rows
  FROM orderdetails
UNION ALL
SELECT 'products' AS table_name, 
       (SELECT COUNT() FROM PRAGMA_TABLE_INFO('products')) AS number_of_attributes, 
       COUNT(*) AS number_of_rows
  FROM products
UNION ALL
SELECT 'productlines' AS table_name, 
       (SELECT COUNT() FROM PRAGMA_TABLE_INFO('productlines')) AS number_of_attributes, 
       COUNT(*) AS number_of_rows
  FROM productlines
UNION ALL
SELECT 'offices' AS table_name, 
       (SELECT COUNT() FROM PRAGMA_TABLE_INFO('offices')) AS number_of_attributes, 
       COUNT(*) AS number_of_rows
  FROM offices;

