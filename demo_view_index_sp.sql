-- =============================================================================
-- BÀI TẬP: TỔNG HỢP VIEW, INDEX VÀ STORED PROCEDURE
-- CSDL: demo
-- =============================================================================

-- -----------------------------------------------------------------------------
-- BƯỚC 1 & 2: TẠO CSDL, BẢNG PRODUCTS VÀ CHÈN DỮ LIỆU MẪU
-- -----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS demo;
USE demo;

DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(20) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(12,2) NOT NULL,
    productAmount INT NOT NULL DEFAULT 0,
    productDescription TEXT,
    productStatus VARCHAR(20) DEFAULT 'Active'
);

-- Chèn dữ liệu mẫu
INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES 
    ('P001', 'Laptop Dell XPS 13', 25000000.00, 10, 'Mỏng nhẹ, cao cấp', 'Active'),
    ('P002', 'iPhone 15 Pro Max', 30000000.00, 15, 'Màn hình ProMotion 120Hz', 'Active'),
    ('P003', 'Samsung Galaxy S24', 22000000.00, 20, 'Tích hợp Galaxy AI', 'Active'),
    ('P004', 'Bàn phím cơ Keychron', 2000000.00, 50, 'Kết nối Bluetooth/Wireless', 'Active'),
    ('P005', 'Chuột Logitech MX Master 3S', 2500000.00, 30, 'Cuộn siêu tốc, yên tĩnh', 'Inactive');

-- -----------------------------------------------------------------------------
-- BƯỚC 3: TẠO INDEX VÀ KIỂM TRA HIỆU NĂNG BẰNG EXPLAIN
-- -----------------------------------------------------------------------------

-- 3.1. Kiểm tra EXPLAIN trước khi đánh Index (Full Table Scan)
EXPLAIN SELECT * FROM Products WHERE productCode = 'P002';
EXPLAIN SELECT * FROM Products WHERE productName = 'iPhone 15 Pro Max' AND productPrice = 30000000.00;

-- 3.2. Tạo Unique Index trên cột productCode
CREATE UNIQUE INDEX idx_productCode ON Products(productCode);

-- 3.3. Tạo Composite Index trên 2 cột (productName, productPrice)
CREATE INDEX idx_name_price ON Products(productName, productPrice);

-- 3.4. Kiểm tra EXPLAIN sau khi đã tạo Index
-- Kết quả kỳ vọng: type = 'const' / 'ref', key = 'idx_productCode' / 'idx_name_price', rows = 1
EXPLAIN SELECT * FROM Products WHERE productCode = 'P002';
EXPLAIN SELECT * FROM Products WHERE productName = 'iPhone 15 Pro Max' AND productPrice = 30000000.00;

-- -----------------------------------------------------------------------------
-- BƯỚC 4: TẠO, SỬA ĐỔI VÀ XÓA VIEW
-- -----------------------------------------------------------------------------

-- 4.1. Tạo View lấy các trường cơ bản
CREATE VIEW view_products AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;

-- Truy vấn qua View
SELECT * FROM view_products;

-- 4.2. Cập nhật/Sửa đổi View (Bổ sung cột productAmount)
CREATE OR REPLACE VIEW view_products AS
SELECT productCode, productName, productPrice, productAmount, productStatus
FROM Products
WHERE productStatus = 'Active';

-- Kiểm tra lại kết quả View sau khi sửa
SELECT * FROM view_products;

-- 4.3. Xóa View
DROP VIEW IF EXISTS view_products;

-- -----------------------------------------------------------------------------
-- BƯỚC 5: TẠO CÁC STORED PROCEDURE (CRUD)
-- -----------------------------------------------------------------------------

-- 5.1. SP Lấy tất cả thông tin sản phẩm
DELIMITER //
DROP PROCEDURE IF EXISTS sp_getAllProducts//
CREATE PROCEDURE sp_getAllProducts()
BEGIN
    SELECT * FROM Products;
END //
DELIMITER ;

-- 5.2. SP Thêm một sản phẩm mới
DELIMITER //
DROP PROCEDURE IF EXISTS sp_addProduct//
CREATE PROCEDURE sp_addProduct(
    IN p_code VARCHAR(20),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(12,2),
    IN p_amount INT,
    IN p_desc TEXT,
    IN p_status VARCHAR(20)
)
BEGIN
    INSERT INTO Products(productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (p_code, p_name, p_price, p_amount, p_desc, p_status);
END //
DELIMITER ;

-- 5.3. SP Sửa thông tin sản phẩm theo Id
DELIMITER //
DROP PROCEDURE IF EXISTS sp_updateProductById//
CREATE PROCEDURE sp_updateProductById(
    IN p_id INT,
    IN p_code VARCHAR(20),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(12,2),
    IN p_amount INT,
    IN p_desc TEXT,
    IN p_status VARCHAR(20)
)
BEGIN
    UPDATE Products
    SET 
        productCode = p_code,
        productName = p_name,
        productPrice = p_price,
        productAmount = p_amount,
        productDescription = p_desc,
        productStatus = p_status
    WHERE Id = p_id;
END //
DELIMITER ;

-- 5.4. SP Xóa sản phẩm theo Id
DELIMITER //
DROP PROCEDURE IF EXISTS sp_deleteProductById//
CREATE PROCEDURE sp_deleteProductById(
    IN p_id INT
)
BEGIN
    DELETE FROM Products WHERE Id = p_id;
END //
DELIMITER ;

-- -----------------------------------------------------------------------------
-- TEST CÁC STORED PROCEDURE VỪA TẠO
-- -----------------------------------------------------------------------------
-- 1. Lấy toàn bộ sản phẩm
CALL sp_getAllProducts();

-- 2. Thêm mới 1 sản phẩm
CALL sp_addProduct('P006', 'Tai nghe Sony WH-1000XM5', 8000000.00, 12, 'Chống ồn chủ động', 'Active');

-- 3. Cập nhật sản phẩm vừa thêm (Id = 6)
CALL sp_updateProductById(6, 'P006', 'Tai nghe Sony WH-1000XM5 Premium', 7500000.00, 15, 'Giảm giá cực sốc', 'Active');

-- 4. Xóa sản phẩm (Id = 6)
CALL sp_deleteProductById(6);

-- 5. Kiểm tra lại danh sách
CALL sp_getAllProducts();
