{% docs src_sec_sales_desc %}

A raw database layer of Distributor Management System source system in Snowflake database for Secondary Sales.

Secondary sales data is managed by all the distributors in a common external application system. The data is stored by the application in relational MSSQL database.

The main purpose of DMS, is:
1. to manage customer sales orders
2. to manage inventory stock freshness
3. to manage salesman visit route planning

{% enddocs %}

{% docs sales_invoice_discount_settlement %}

## Discount Settlement

This Discount Settlement is derived based on distributor, customer and product.

| Table Name.   |   Description.              |
|---------------|-----------------------------|
| Distributor   | Secondary Sales Distributor |
| Customer      | Secondary Sales Customer    |
| Product       | Secondary Sales Product     |
| Sales Invoice | Secondary Sales Invoice     |

**Calculation Criteria:**

1. The customer has no return sales the prior month.
2. The month range bucket the distributor has been selling to the customer.
3. The product quantity in a single order is more than or equal to 500 Cartoons.

**Example:**

### Case A
```
customer_no_return = true
customer_sales_retention_months = 6
product_sales_qty = 500
base_price_amount = 1000
```

> (6 / 500) * 1000

Promotional Discount & Unconditional Discount is added with the above amount.


### Case B

```
customer_no_return = true
customer_sales_retention_months = 18
product_sales_qty = 500
base_price_amount = 1000
```

>> ((18 - 12) / 500) * 1000

Promotional Discount & Unconditional Discount is added with the above amount.

For complete calculation please refer to the google sheet [Calculation of Discount Settlement](https://docs.google.com/spreadsheets/d/abcdef123456)

{% enddocs %}
