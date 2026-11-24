
USE payroll_attendance;

DELIMITER //

-- FUNCTION: CALCULATE TAX
CREATE FUNCTION calculate_tax(
    p_gross DECIMAL(10,2),
    p_rate DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
NO SQL
BEGIN
    RETURN ROUND(p_gross * p_rate / 100, 2);
END //

-- PROCEDURE: GENERATE MONTHLY PAYROLL
CREATE PROCEDURE generate_payroll(
    IN p_month TINYINT,
    IN p_year SMALLINT
)
BEGIN
    INSERT INTO payroll (
        employee_id,
        payroll_month,
        payroll_year,
        gross_salary,
        tax_amount,
        other_deductions,
        net_salary,
        payment_status
    )
    SELECT
        s.employee_id,
        p_month,
        p_year,
        s.basic_salary + s.allowances,
        calculate_tax(
            s.basic_salary + s.allowances,
            s.tax_rate
        ),
        s.other_deductions,
        (s.basic_salary + s.allowances)
        - calculate_tax(
            s.basic_salary + s.allowances,
            s.tax_rate
        )
        - s.other_deductions,
        'Pending'
    FROM salary s
    JOIN employees e
        ON s.employee_id = e.employee_id
    WHERE e.employment_status = 'Active';
END //

-- PROCEDURE: UPDATE SALARY WITH TRANSACTION
CREATE PROCEDURE update_employee_salary(
    IN p_employee_id INT,
    IN p_new_salary DECIMAL(10,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF p_new_salary <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be positive';
    END IF;

    UPDATE salary
    SET basic_salary = p_new_salary
    WHERE employee_id = p_employee_id;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary record not found';
    END IF;

    COMMIT;
END //

DELIMITER ;

-- TEST TAX FUNCTION
SELECT calculate_tax(45000,10) AS calculated_tax;

-- GENERATE PAYROLL
CALL generate_payroll(10,2026);
CALL generate_payroll(11,2026);
CALL generate_payroll(12,2026);

-- CHECK PAYROLL
SELECT * FROM payroll;
