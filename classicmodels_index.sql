-- =============================================================================
-- THỰC HÀNH: CHỈ MỤC (INDEX) TRONG MYSQL
-- CSDL MẪU: classicmodels
-- =============================================================================

USE classicmodels;

-- -----------------------------------------------------------------------------
-- BƯỚC 1: ĐÁNH GIÁ HIỆU NĂNG TRƯỚC KHI TẠO INDEX (FULL TABLE SCAN)
-- -----------------------------------------------------------------------------
-- Quan sát các chỉ số trong lệnh EXPLAIN:
-- - type: ALL (MySQL phải duyệt qua toàn bộ bản ghi trong bảng)
-- - key: NULL (Chưa có chỉ mục nào được sử dụng)
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';


-- -----------------------------------------------------------------------------
-- BƯỚC 2: TẠO CHỈ MỤC ĐƠN (SINGLE-COLUMN INDEX) TRÊN CỘT customerName
-- -----------------------------------------------------------------------------
ALTER TABLE customers ADD INDEX idx_customerName(customerName);

-- Kiểm tra lại kế hoạch thực thi (Execution Plan) sau khi tạo chỉ mục:
-- - type: ref (MySQL đã sử dụng B-Tree Index để nhảy trực tiếp tới dữ liệu)
-- - key: idx_customerName (Chỉ mục vừa tạo đã được kích hoạt)
-- - rows: Giảm đáng kể số lượng dòng phải tìm kiếm (chỉ còn ~1 dòng)
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';


-- -----------------------------------------------------------------------------
-- BƯỚC 3: TẠO CHỈ MỤC PHỨC HỢP (COMPOSITE INDEX)
-- -----------------------------------------------------------------------------
-- Tạo index kết hợp trên 2 cột: contactFirstName và contactLastName
ALTER TABLE customers ADD INDEX idx_full_name(contactFirstName, contactLastName);

-- Kiểm tra truy vấn lọc theo cột nằm trong chỉ mục phức hợp:
EXPLAIN SELECT * FROM customers 
WHERE contactFirstName = 'Jean' OR contactFirstName = 'King';


-- -----------------------------------------------------------------------------
-- BƯỚC 4: XÓA CHỈ MỤC (DROP INDEX)
-- -----------------------------------------------------------------------------
-- Khi không cần sử dụng hoặc cần tối ưu lại, tiến hành xóa chỉ mục
ALTER TABLE customers DROP INDEX idx_full_name;
ALTER TABLE customers DROP INDEX idx_customerName;
