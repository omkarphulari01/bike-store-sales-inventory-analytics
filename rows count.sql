USE retail_analysis;
GO

SELECT 'brands'      AS table_name, COUNT(*) AS row_count FROM brands
UNION ALL
SELECT 'categories',               COUNT(*) FROM categories
UNION ALL
SELECT 'stores',                   COUNT(*) FROM stores
UNION ALL
SELECT 'customers',                COUNT(*) FROM customers
UNION ALL
SELECT 'staffs',                   COUNT(*) FROM staffs
UNION ALL
SELECT 'products',                 COUNT(*) FROM products
UNION ALL
SELECT 'orders',                   COUNT(*) FROM orders
UNION ALL
SELECT 'order_items',              COUNT(*) FROM order_items
UNION ALL
SELECT 'stocks',                   COUNT(*) FROM stocks;
