
CREATE DATABASE IF NOT EXISTS payroll_attendance;
USE payroll_attendance;

-- 1. EMPLOYEES
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    department VARCHAR(50) NOT NULL,
    designation VARCHAR(50) NOT NULL,
    joining_date DATE NOT NULL,
    employment_status VARCHAR(20) NOT NULL
);

-- 2. ATTENDANCE
CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    check_in TIME,
    check_out TIME,
    attendance_status VARCHAR(20) NOT NULL,
    late_minutes INT NOT NULL DEFAULT 0,

    CONSTRAINT fk_attendance_employee
    FOREIGN KEY (employee_id)
    REFERENCES employees(employee_id),

    CONSTRAINT uq_employee_attendance
    UNIQUE (employee_id, attendance_date),

    CONSTRAINT chk_late_minutes
    CHECK (late_minutes >= 0),

    CONSTRAINT chk_attendance_status
    CHECK (attendance_status IN
    ('Present','Absent','Half-Day','On Leave')),

    CONSTRAINT chk_attendance_time
    CHECK (
        check_out IS NULL OR check_in IS NULL
        OR check_out > check_in
    )
);

-- 3. LEAVE REQUESTS
CREATE TABLE leave_requests (
    leave_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    leave_type VARCHAR(30) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    reason VARCHAR(255),
    leave_status VARCHAR(20) NOT NULL DEFAULT 'Pending',

    CONSTRAINT fk_leave_employee
    FOREIGN KEY (employee_id)
    REFERENCES employees(employee_id),

    CONSTRAINT chk_leave_dates
    CHECK (end_date >= start_date),

    CONSTRAINT chk_leave_status
    CHECK (leave_status IN
    ('Pending','Approved','Rejected'))
);

-- 4. SALARY
CREATE TABLE salary (
    employee_id INT PRIMARY KEY,
    basic_salary DECIMAL(10,2) NOT NULL,
    allowances DECIMAL(10,2) NOT NULL DEFAULT 0,
    other_deductions DECIMAL(10,2) NOT NULL DEFAULT 0,
    tax_rate DECIMAL(5,2) NOT NULL DEFAULT 10.00,

    CONSTRAINT fk_salary_employee
    FOREIGN KEY (employee_id)
    REFERENCES employees(employee_id),

    CONSTRAINT chk_basic_salary
    CHECK (basic_salary > 0),

    CONSTRAINT chk_allowances
    CHECK (allowances >= 0),

    CONSTRAINT chk_other_deductions
    CHECK (other_deductions >= 0),

    CONSTRAINT chk_tax_rate
    CHECK (tax_rate BETWEEN 0 AND 100)
);

-- 5. PAYROLL
CREATE TABLE payroll (
    payroll_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    payroll_month TINYINT NOT NULL,
    payroll_year SMALLINT NOT NULL,
    gross_salary DECIMAL(10,2) NOT NULL,
    tax_amount DECIMAL(10,2) NOT NULL,
    other_deductions DECIMAL(10,2) NOT NULL,
    net_salary DECIMAL(10,2) NOT NULL,
    payment_date DATE,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'Pending',

    CONSTRAINT fk_payroll_employee
    FOREIGN KEY (employee_id)
    REFERENCES employees(employee_id),

    CONSTRAINT uq_employee_payroll
    UNIQUE (employee_id, payroll_month, payroll_year),

    CONSTRAINT chk_payroll_month
    CHECK (payroll_month BETWEEN 1 AND 12),

    CONSTRAINT chk_payroll_year
    CHECK (payroll_year BETWEEN 2000 AND 2100),

    CONSTRAINT chk_payroll_amounts
    CHECK (
        gross_salary >= 0 AND
        tax_amount >= 0 AND
        other_deductions >= 0 AND
        net_salary >= 0
    ),

    CONSTRAINT chk_payment_status
    CHECK (payment_status IN
    ('Pending','Paid','Failed'))
);

SHOW TABLES;
