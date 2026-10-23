USE ecommerce_db;


CREATE ROLE IF NOT EXISTS 'admin_role';
CREATE ROLE IF NOT EXISTS 'customer_role';


GRANT ALL PRIVILEGES ON ecommerce_db.* TO 'admin_role';
GRANT SELECT ON ecommerce_db.Products TO 'customer_role';
GRANT SELECT ON ecommerce_db.Categories TO 'customer_role';
GRANT INSERT, SELECT ON ecommerce_db.Orders TO 'customer_role';

FLUSH PRIVILEGES;