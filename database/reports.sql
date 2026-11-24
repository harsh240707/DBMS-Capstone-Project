
USE payroll_attendance;


-- 1. Monthly attendance summary
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    COUNT(a.attendance_id) AS total_records,
    SUM(a.attendance_status = 'Present') AS present_days,
    SUM(a.attendance_status = 'Absent') AS absent_days,
    SUM(a.attendance_status = 'Half-Day') AS half_days,
    SUM(a.late_minutes > 0) AS late_days
FROM employees e
LEFT JOIN attendance a
    ON e.employee_id = a.employee_id
    AND a.attendance_date >= '2026-10-01'
    AND a.attendance_date < '2026-11-01'
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY e.employee_id;


-- 2. Employee salary slip for October 2026
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    p.payroll_month,
    p.payroll_year,
    p.gross_salary,
    p.tax_amount,
    p.other_deductions,
    p.net_salary,
    p.payment_status,
    p.payment_date
FROM payroll p
JOIN employees e
    ON p.employee_id = e.employee_id
WHERE p.employee_id = 1
  AND p.payroll_month = 10
  AND p.payroll_year = 2026;


-- 3. Late marks report
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    a.attendance_date,
    a.check_in,
    a.late_minutes
FROM attendance a
JOIN employees e
    ON a.employee_id = e.employee_id
WHERE a.late_minutes > 0
ORDER BY a.attendance_date, e.employee_id;


-- 4. Explain query before adding index
EXPLAIN
SELECT *
FROM attendance
WHERE attendance_date = '2026-10-01';


-- 5. Create indexes
-- Execute these CREATE INDEX statements only once.
CREATE INDEX idx_attendance_date
ON attendance(attendance_date);

CREATE INDEX idx_attendance_employee_date
ON attendance(employee_id, attendance_date);

CREATE INDEX idx_payroll_employee_month
ON payroll(employee_id, payroll_year, payroll_month);


-- 6. Explain query after adding index
EXPLAIN
SELECT *
FROM attendance
WHERE attendance_date = '2026-10-01';


-- 7. Display created indexes
SHOW INDEX FROM attendance;
SHOW INDEX FROM payroll;
