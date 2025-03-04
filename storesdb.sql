-- Intro: 
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


SELECT *
FROM employees


-- Question 1: 
-- Which Products Should We Order More of or Less of?

WITH low_stock_product AS (
    SELECT 
        p.productCode, 
        ROUND(SUM(od.quantityOrdered) * 1.0 / p.quantityInStock * 1.0, 2) AS low_stock 
    FROM 
        products p
    JOIN 
        orderDetails od ON p.productCode = od.productCode
    GROUP BY 
        p.productCode
    ORDER BY 
        low_stock DESC
    LIMIT 10
),

product_performance AS (    
    SELECT 
        productCode, 
        SUM(quantityOrdered * priceEach) AS productPerformance
    FROM 
        orderDetails
    WHERE 
        productCode IN (SELECT productCode FROM low_stock_product)
    GROUP BY 
        productCode
    ORDER BY 
        productPerformance DESC
    LIMIT 10
)

SELECT 
    productCode, 
    productName, 
    productLine
FROM 
    products
WHERE 
    productCode IN (SELECT productCode FROM product_performance);

-- Question 2: 
-- How Should We Match Marketing and Communication Strategies to Customer Behavior?

SELECT 
    o.customerNumber AS customerNumber,
    SUM(od.quantityOrdered * (od.priceEach - p.buyPrice)) AS profit
FROM 
    orders o
JOIN 
    orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN 
    products p ON od.productCode = p.productCode
GROUP BY 
    customerNumber
ORDER BY 
    profit DESC;

-- Question 3:
-- Finding the VIP customers

WITH profit_per_customer AS (
    SELECT 
        o.customerNumber, 
        SUM(quantityOrdered * (priceEach - buyPrice)) AS profit
    FROM 
        products p
    JOIN 
        orderdetails od ON p.productCode = od.productCode
    JOIN 
        orders o ON o.orderNumber = od.orderNumber
    GROUP BY 
        o.customerNumber
)

SELECT 
    c.contactLastName, 
    c.contactFirstName, 
    c.city, 
    c.country
FROM 
    customers c
JOIN 
    profit_per_customer ppc ON c.customerNumber = ppc.customerNumber
ORDER BY 
    ppc.profit DESC
LIMIT 
    5;

-- Finding the least engaged customers

-- Current step of DataQuest course: https://app.dataquest.io/c/111/m/600/guided-project%3A-customers-and-products-analysis-using-sql/6/finding-the-vip-and-less-engaged-customers
