-- =============================================================================
-- THỰC HÀNH: TẠO VÀ SỬ DỤNG TRIGGER TRONG MYSQL
-- CSDL: company
-- =============================================================================

-- -----------------------------------------------------------------------------
-- BƯỚC 1: KHỞI TẠO CƠ SỞ DỮ LIỆU VÀ BẢNG EMPLOYEES
-- -----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS company;
USE company;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

-- -----------------------------------------------------------------------------
-- BƯỚC 2: TẠO TRIGGER TỰ ĐỘNG PHÂN PHÒNG BAN THEO MỨC LƯƠNG
-- Thời điểm: BEFORE INSERT (Chỉnh sửa trực tiếp dữ liệu NEW trước khi lưu đĩa)
-- -----------------------------------------------------------------------------
DELIMITER //

DROP TRIGGER IF EXISTS update_department//

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';
    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';
    ELSE
        SET NEW.department = 'Support';
    END IF;
END //

DELIMITER ;

-- -----------------------------------------------------------------------------
-- BƯỚC 3: KIỂM THỬ TÍNH NĂNG CỦA TRIGGER
-- Chèn bản ghi với giá trị tạm thời department = 'A'
-- -----------------------------------------------------------------------------
INSERT INTO employees (name, department, salary)
VALUES 
    ('John Doe', 'A', 3500),       -- Kỳ vọng: Sales
    ('Jane Smith', 'A', 2000),      -- Kỳ vọng: Support
    ('David Johnson', 'A', 6000);   -- Kỳ vọng: Management

-- -----------------------------------------------------------------------------
-- BƯỚC 4: XÁC NHẬN KẾT QUẢ
-- -----------------------------------------------------------------------------
SELECT * FROM employees;
