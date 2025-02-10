
-- Insert data into tbl_customer
INSERT INTO tbl_customer (first_name, last_name, email, phone, created_at)
VALUES 
('John', 'Doe', 'johndoe@example.com', '1234567890', '2025-02-01'),
('Jane', 'Smith', 'janesmith@example.com', '0987654321', '2025-02-01');

-- Insert data into tbl_product
INSERT INTO tbl_product (product_name, price, stock_quantity, created_at)
VALUES 
('Protein Shake', 10.99, 50, '2025-02-01'),
('Yoga Mat', 20.00, 30, '2025-02-01'),
('Dumbbells Set', 50.00, 20, '2025-02-01'),
('Resistance Bands', 15.00, 40, '2025-02-01');

-- Insert data into tbl_order
INSERT INTO tbl_order (customer_id, order_date, total_amount)
VALUES 
(1, '2025-02-02', 35.99),
(2, '2025-02-02', 75.00);

-- Insert data into tbl_order_item
INSERT INTO tbl_order_item (order_id, product_id, quantity, price)
VALUES 
(1, 1, 2, 21.98), 
(1, 2, 1, 20.00), 
(2, 3, 1, 50.00), 
(2, 4, 2, 30.00);

-- Insert data into tbl_employee
INSERT INTO tbl_employee (first_name, last_name, position)
VALUES 
('Mike', 'Thompson', 'Manager'),
('Lisa', 'Brown', 'Cashier');

-- Delete an employee to trigger the audit log
DELETE FROM tbl_employee WHERE employee_id = 1;

-- Verify the employee audit log
SELECT * FROM tbl_employee_audit;
