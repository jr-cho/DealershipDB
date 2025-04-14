
---

```
- Each vehicle must have a unique VIN.
- A vehicle can only be sold once.
- Each customer can purchase multiple vehicles.
- Total sale price must match or exceed the price of all vehicles included in the sale.
- Customers must have personal information stored, such as name, contact, and email.
- Only employees with a role of 'Sales' can be associated with a sale.
- Employees must have a unique ID and contact details.
- Each sale must be linked to exactly one customer and one salesperson.
- Each sale may optionally have a related financing record.
- Each sale may optionally have a related insurance record.
- Each vehicle can have zero or more service records.
- Inventory must be updated in real-time after a sale is completed.
- Each vehicle must belong to a product category/subtype.
- Invoices must capture sale date, customer, salesperson, and product(s).
- Each invoice should support multiple products (via a bridge table).
- Derived fields such as TotalPrice should be computed, not manually entered.
- Every product entered must have a vendor associated.
```
