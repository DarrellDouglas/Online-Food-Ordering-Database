-- Drop existing tables if they exist to avoid conflicts
DROP TABLE IF EXISTS tbl_employee_audit, tbl_employee, tbl_order_item, tbl_order, tbl_product, tbl_customer;

-- Create tbl_customer
CREATE TABLE tbl_customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    created_at DATE NOT NULL
);

-- Create tbl_product
CREATE TABLE tbl_product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    created_at DATE NOT NULL
);

-- Create tbl_order
CREATE TABLE tbl_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES tbl_customer(customer_id)
);

-- Create tbl_order_item
CREATE TABLE tbl_order_item (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES tbl_order(order_id),
    FOREIGN KEY (product_id) REFERENCES tbl_product(product_id)
);

-- Create tbl_employee
CREATE TABLE tbl_employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create tbl_employee_audit
CREATE TABLE tbl_employee_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    audit_data VARCHAR(255) NOT NULL
);

-- Create Insert Trigger for tbl_employee
DELIMITER //
CREATE TRIGGER trg_employee_insert
AFTER INSERT ON tbl_employee
FOR EACH ROW
BEGIN
    INSERT INTO tbl_employee_audit (audit_data)
    VALUES (CONCAT('New employee with ID = ', NEW.employee_id, ' was added on ', NOW()));
END;
//
DELIMITER ;

-- Create Delete Trigger for tbl_employee
DELIMITER //
CREATE TRIGGER trg_employee_delete
AFTER DELETE ON tbl_employee
FOR EACH ROW
BEGIN
    INSERT INTO tbl_employee_audit (audit_data)
    VALUES (CONCAT('Employee with ID = ', OLD.employee_id, ' was deleted on ', NOW()));
END;
//
DELIMITER ;
