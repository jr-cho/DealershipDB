# DATABASE Folder Overview

This folder contains all SQL-related scripts that define, populate, and interact with your relational database for the dealership project.

---

## 📄 schema.sql  
Defines the structure of your database — tables, columns, keys, data types, and relationships.

**Includes**:
- CREATE TABLE statements
- Primary and foreign keys
- Constraints like NOT NULL, AUTO_INCREMENT

---

## 📄 insert_test_data.sql  
Populates your database with sample data.

**Includes**:
- INSERT INTO statements for Customer, Vehicle, Sale, etc.

---

## 📄 views.sql  
Contains SQL CREATE VIEW statements for reusable virtual tables.

**Includes**:
- Views like SalesSummaryView or CustomerPurchaseHistoryView

---

## 📄 procedures.sql  
Holds reusable stored procedures for dynamic operations.

**Includes**:
- CREATE PROCEDURE statements for operations that involve joining and filtering

---

## 📁 queries/  
This folder contains individual queries required for the final assignment.

### Files:
- query_invoice_by_customer_date.sql
- query_products_sold_date_range.sql
- query_products_by_type.sql
- query_invoice_frequency.sql
- query_subquery_arithmetic.sql
- query_five_table_join.sql
- virtual_table_output.sql

---

## 📄 data_dictionary.sql  
SQL query to output metadata about your database schema from information_schema.

---

## 📄 mysqldump_output.sql  
Final export of the entire database using mysqldump. This file is used for restoring or submitting the full database.

---
