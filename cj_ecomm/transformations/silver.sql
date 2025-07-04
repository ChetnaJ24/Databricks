create streaming table auto.chetna_silver.sales_cleaned_pl 
(constraint valid_order_id EXPECT(order_id is not null) on violation drop row) as
select distinct * from stream sales_pl;


CREATE OR REFRESH STREAMING TABLE auto.chetna_silver.products_cleaned_pl;

CREATE FLOW products_flow AS AUTO CDC INTO
  auto.chetna_silver.products_cleaned_pl
FROM
  stream(products_pl)
KEYS
  (product_id)
APPLY AS DELETE WHEN
  operation = "DELETE"
SEQUENCE BY
  seqNum
COLUMNS * EXCEPT
  (operation, seqNum, _rescued_data)
STORED AS
  SCD TYPE 1;

CREATE OR REFRESH STREAMING TABLE auto.chetna_silver.customer_cleaned_pl;

CREATE FLOW customer_flow AS AUTO CDC INTO
  auto.chetna_silver.customer_cleaned_pl
FROM
  stream(customers_pl)
KEYS
  (customer_id)
APPLY AS DELETE WHEN
  operation = "DELETE"
SEQUENCE BY
  sequenceNum
COLUMNS * EXCEPT
  (operation, sequenceNum, _rescued_data)
STORED AS
  SCD TYPE 2;