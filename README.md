
# 🏭 ERP Manufacturing Database (PostgreSQL Project)

This is an advanced PostgreSQL database project simulating an ERP (Enterprise Resource Planning) system for a manufacturing company.

## 📂 Tables

- `suppliers`: Supplier information
- `materials`: Raw materials with cost and category
- `employees`: Factory employees handling production
- `production_orders`: Orders executed by employees
- `production_order_details`: Materials used in orders
- `inventory`: Current stock and reorder thresholds
- `shipments`: Shipment info for fulfilled orders

## 🧩 Features

- 7 interrelated tables with proper indexing
- Explicit foreign key constraints via `ALTER TABLE`
- Composite analytics using JOINs, CTEs, and Aggregates
- Ready for portfolio showcase or job interview use

## 🚀 Usage

1. Import `schema.sql` into your PostgreSQL instance.
2. Use `\COPY` or any tool to load the CSV files.
3. Run the queries from `queries.sql` to explore advanced SQL logic.

## 🎯 Advanced Query Topics

- Inventory analysis
- Material scrap tracking
- Employee efficiency measurement
- Shipment and lead-time tracking
- Multi-level joins and filtering

---


