USE retail_analysis;
GO

-- ============================================================
-- QUERY 1: Total Sales Revenue
-- ============================================================
SELECT 
    ROUND(SUM(quantity * list_price * (1 - discount)), 2) AS total_revenue,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders
FROM order_items;
GO

-- ============================================================
-- QUERY 2: Top 10 Best Selling Products
-- ============================================================
SELECT TOP 10
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;
GO

-- ============================================================
-- QUERY 3: Sales by Store
-- ============================================================
SELECT 
    s.store_name,
    s.city,
    s.state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_revenue
FROM orders o
JOIN stores s ON o.store_id = s.store_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY s.store_name, s.city, s.state
ORDER BY total_revenue DESC;
GO

-- ============================================================
-- QUERY 4: Sales by Category
-- ============================================================
SELECT 
    c.category_name,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;
GO

-- ============================================================
-- QUERY 5: Sales by Brand
-- ============================================================
SELECT 
    b.brand_name,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN brands b ON p.brand_id = b.brand_id
GROUP BY b.brand_name
ORDER BY revenue DESC;
GO

-- ============================================================
-- QUERY 6: Monthly Sales Trend
-- ============================================================
SELECT 
    YEAR(o.order_date)  AS year,
    MONTH(o.order_date) AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY year, month;
GO

-- ============================================================
-- QUERY 7: Top 10 Customers by Spending
-- ============================================================
SELECT TOP 10
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    c.city,
    c.state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city, c.state
ORDER BY total_spent DESC;
GO

-- ============================================================
-- QUERY 8: Staff Performance
-- ============================================================
SELECT 
    st.first_name + ' ' + st.last_name AS staff_name,
    s.store_name,
    COUNT(DISTINCT o.order_id) AS orders_handled,
    ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS revenue_generated
FROM staffs st
JOIN orders o ON st.staff_id = o.staff_id
JOIN stores s ON st.store_id = s.store_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY st.first_name, st.last_name, s.store_name
ORDER BY revenue_generated DESC;
GO

-- ============================================================
-- QUERY 9: Inventory Stock Levels by Store
-- ============================================================
SELECT 
    s.store_name,
    p.product_name,
    b.brand_name,
    c.category_name,
    st.quantity AS stock_quantity
FROM stocks st
JOIN stores s ON st.store_id = s.store_id
JOIN products p ON st.product_id = p.product_id
JOIN brands b ON p.brand_id = b.brand_id
JOIN categories c ON p.category_id = c.category_id
ORDER BY s.store_name, st.quantity ASC;
GO

-- ============================================================
-- QUERY 10: Low Stock Products (quantity < 10)
-- ============================================================
SELECT 
    s.store_name,
    p.product_name,
    b.brand_name,
    st.quantity AS stock_quantity
FROM stocks st
JOIN stores s ON st.store_id = s.store_id
JOIN products p ON st.product_id = p.product_id
JOIN brands b ON p.brand_id = b.brand_id
WHERE st.quantity < 10
ORDER BY st.quantity ASC;
GO

-- ============================================================
-- QUERY 11: Order Shipping Status
-- ============================================================
SELECT 
    order_status,
    CASE order_status
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Processing'
        WHEN 3 THEN 'Rejected'
        WHEN 4 THEN 'Completed'
    END AS status_name,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY order_status;
GO