
USE payroll_attendance;

-- Create roles
CREATE ROLE IF NOT EXISTS 'hr_admin_role';
CREATE ROLE IF NOT EXISTS 'employee_role';


-- HR/Admin receives full database permissions
GRANT ALL PRIVILEGES
ON payroll_attendance.*
TO 'hr_admin_role';


-- Employee receives read-only access
GRANT SELECT
ON payroll_attendance.*
TO 'employee_role';


-- Create database users
CREATE USER IF NOT EXISTS 'hr_admin'@'localhost'
IDENTIFIED BY 'HR_Project@2026';

CREATE USER IF NOT EXISTS 'employee_user'@'localhost'
IDENTIFIED BY 'Employee_Project@2026';


-- Assign roles
GRANT 'hr_admin_role'
TO 'hr_admin'@'localhost';

GRANT 'employee_role'
TO 'employee_user'@'localhost';


-- Set default roles
SET DEFAULT ROLE ALL
TO 'hr_admin'@'localhost';

SET DEFAULT ROLE ALL
TO 'employee_user'@'localhost';


-- Verify permissions
SHOW GRANTS FOR 'hr_admin'@'localhost';

SHOW GRANTS FOR 'employee_user'@'localhost';
