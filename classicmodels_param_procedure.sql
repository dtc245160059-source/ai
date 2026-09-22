-- =============================================================================
-- THỰC HÀNH: TRUYỀN THAM SỐ VÀO STORED PROCEDURE TRONG MYSQL
-- CSDL MẪU: classicmodels
-- =============================================================================

USE classicmodels;

-- -----------------------------------------------------------------------------
-- PHẦN 1: THAM SỐ DẠNG IN (Tham số đầu vào - Mặc định)
-- Truyền giá trị vào thủ tục, thủ tục không làm thay đổi giá trị biến bên ngoài
-- -----------------------------------------------------------------------------
DELIMITER //

DROP PROCEDURE IF EXISTS getCusById//

CREATE PROCEDURE getCusById (
    IN cusNum INT
)
BEGIN
    SELECT * 
    FROM customers 
    WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Gọi Stored Procedure dạng IN với mã khách hàng = 175
CALL getCusById(175);


-- -----------------------------------------------------------------------------
-- PHẦN 2: THAM SỐ DẠNG OUT (Tham số đầu ra)
-- Nhận kết quả từ trong thủ tục trả ra ngoài biến session (có tiền tố @)
-- -----------------------------------------------------------------------------
DELIMITER //

DROP PROCEDURE IF EXISTS GetCustomersCountByCity//

CREATE PROCEDURE GetCustomersCountByCity (
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Gọi Stored Procedure dạng OUT với thành phố 'Lyon' và truyền biến nhận @total
CALL GetCustomersCountByCity('Lyon', @total);

-- Hiển thị giá trị biến đầu ra @total
SELECT @total AS TotalCustomersInLyon;


-- -----------------------------------------------------------------------------
-- PHẦN 3: THAM SỐ DẠNG INOUT (Tham số vừa vào vừa ra)
-- Truyền giá trị vào thủ tục, thủ tục tính toán và cập nhật lại chính biến đó
-- -----------------------------------------------------------------------------
DELIMITER //

DROP PROCEDURE IF EXISTS SetCounter//

CREATE PROCEDURE SetCounter (
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Khởi tạo biến session @counter = 1
SET @counter = 1;

-- Gọi lần 1: @counter = 1 + 1 = 2
CALL SetCounter(@counter, 1);

-- Gọi lần 2: @counter = 2 + 1 = 3
CALL SetCounter(@counter, 1);

-- Gọi lần 3: @counter = 3 + 5 = 8
CALL SetCounter(@counter, 5);

-- Hiển thị kết quả cuối cùng của biến @counter
SELECT @counter AS FinalCounter;
