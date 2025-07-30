
-- schema.sql

DROP TABLE IF EXISTS shipments, inventory, production_order_details, production_orders, materials, suppliers, employees CASCADE;

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE materials (
    material_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    unit_cost NUMERIC(10,2),
    supplier_id INT NOT NULL
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50),
    hire_date DATE
);

CREATE TABLE production_orders (
    order_id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL,
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    total_cost NUMERIC(10,2)
);

CREATE TABLE production_order_details (
    detail_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    material_id INT NOT NULL,
    quantity_used INT,
    wastage NUMERIC(5,2)
);

CREATE TABLE inventory (
    material_id INT PRIMARY KEY,
    stock_quantity INT,
    reorder_threshold INT
);

CREATE TABLE shipments (
    shipment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    shipped_on DATE,
    delivery_date DATE,
    delayed BOOLEAN
);

-- Foreign Keys
ALTER TABLE materials ADD CONSTRAINT fk_material_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id);
ALTER TABLE production_orders ADD CONSTRAINT fk_order_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE production_order_details ADD CONSTRAINT fk_detail_order FOREIGN KEY (order_id) REFERENCES production_orders(order_id);
ALTER TABLE production_order_details ADD CONSTRAINT fk_detail_material FOREIGN KEY (material_id) REFERENCES materials(material_id);
ALTER TABLE inventory ADD CONSTRAINT fk_inventory_material FOREIGN KEY (material_id) REFERENCES materials(material_id);
ALTER TABLE shipments ADD CONSTRAINT fk_shipment_order FOREIGN KEY (order_id) REFERENCES production_orders(order_id);
