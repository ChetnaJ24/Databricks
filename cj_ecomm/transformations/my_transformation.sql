-- s3://jpmctraining/pipeline_input/sales
-- piepline(streaming table, materialized view)

create streaming table sales_pl
select * from stream read_files("s3://jpmctraining/pipeline_input/sales",format => 'csv');



create streaming table products_pl select * from stream read_files("s3://jpmctraining/pipeline_input/products",format => 'csv');


create streaming table customers_pl
select * from stream read_files("s3://jpmctraining/pipeline_input/customers",format => 'csv');
