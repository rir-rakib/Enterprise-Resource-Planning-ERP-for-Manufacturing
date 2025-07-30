
-- queries.sql

-- 1. Top 3 suppliers by total quantity supplied (from materials used)
SELECT s.name, COUNT(pod.material_id) AS total_supplied
FROM suppliers s
JOIN materials m ON s.supplier_id = m.supplier_id
JOIN production_order_details pod ON m.material_id = pod.material_id
GROUP BY s.name
ORDER BY total_supplied DESC
LIMIT 3;

-- 2. Monthly material usage
SELECT DATE_TRUNC('month', po.start_date) AS month, m.name, SUM(pod.quantity_used) AS total_used
FROM production_order_details pod
JOIN production_orders po ON pod.order_id = po.order_id
JOIN materials m ON pod.material_id = m.material_id
GROUP BY month, m.name
ORDER BY month;

-- 3. Total production cost per order
SELECT order_id, total_cost FROM production_orders;

-- 4. Employees with average production time > 2 days
SELECT e.name, AVG(po.end_date - po.start_date) AS avg_days
FROM employees e
JOIN production_orders po ON e.employee_id = po.employee_id
GROUP BY e.name
HAVING AVG(po.end_date - po.start_date) > 2;

-- 5. Inventory stock value by material category
SELECT m.category, SUM(i.stock_quantity * m.unit_cost) AS total_value
FROM inventory i
JOIN materials m ON i.material_id = m.material_id
GROUP BY m.category;

-- 6. Materials not used in any production order
SELECT m.name FROM materials m
LEFT JOIN production_order_details pod ON m.material_id = pod.material_id
WHERE pod.material_id IS NULL;

-- 7. Shipments delayed more than 3 days
SELECT * FROM shipments
WHERE delivery_date - shipped_on > 3;

-- 8. Average lead time between order end and shipment
SELECT ROUND(AVG(s.shipped_on - po.end_date), 2) AS avg_lead_time
FROM shipments s
JOIN production_orders po ON s.order_id = po.order_id;

-- 9. Materials with highest scrap percentage
SELECT m.name, ROUND(AVG(pod.wastage / NULLIF(pod.quantity_used, 0)), 2) AS avg_scrap_pct
FROM production_order_details pod
JOIN materials m ON pod.material_id = m.material_id
GROUP BY m.name
ORDER BY avg_scrap_pct DESC
LIMIT 5;

-- 10. Most efficient employee (lowest avg days per order)
SELECT e.name, ROUND(AVG(po.end_date - po.start_date), 2) AS avg_days
FROM employees e
JOIN production_orders po ON e.employee_id = po.employee_id
GROUP BY e.name
ORDER BY avg_days ASC
LIMIT 1;

-- 11. Top 5 production orders with lowest wastage
SELECT po.order_id, SUM(pod.wastage) AS total_waste
FROM production_orders po
JOIN production_order_details pod ON po.order_id = pod.order_id
GROUP BY po.order_id
ORDER BY total_waste ASC
LIMIT 5;

-- 12. Materials below reorder threshold
SELECT m.name, i.stock_quantity, i.reorder_threshold
FROM inventory i
JOIN materials m ON i.material_id = m.material_id
WHERE i.stock_quantity < i.reorder_threshold;

-- 13. Total shipped items by month and material type
SELECT DATE_TRUNC('month', s.shipped_on) AS ship_month, m.category, COUNT(*) AS total_shipments
FROM shipments s
JOIN production_orders po ON s.order_id = po.order_id
JOIN production_order_details pod ON po.order_id = pod.order_id
JOIN materials m ON pod.material_id = m.material_id
GROUP BY ship_month, m.category;

-- 14. Most frequently produced material in last 6 months
SELECT m.name, COUNT(*) AS times_used
FROM production_order_details pod
JOIN production_orders po ON pod.order_id = po.order_id
JOIN materials m ON pod.material_id = m.material_id
WHERE po.start_date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY m.name
ORDER BY times_used DESC
LIMIT 1;

-- 15. Production orders in process for more than 7 days
SELECT * FROM production_orders
WHERE status = 'In Progress' AND CURRENT_DATE - start_date > 7;
