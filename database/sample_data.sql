
USE payroll_attendance;

-- EMPLOYEE DATA
INSERT INTO employees
(first_name, last_name, email, phone, department,
 designation, joining_date, employment_status)
VALUES
('Aarav','Sharma','aarav@company.com','9876543210','IT','Software Engineer','2023-01-10','Active'),
('Priya','Verma','priya@company.com','9876543211','HR','HR Executive','2022-03-15','Active'),
('Rahul','Singh','rahul@company.com','9876543212','IT','Backend Developer','2023-05-20','Active'),
('Ananya','Gupta','ananya@company.com','9876543213','Finance','Accountant','2021-07-12','Active'),
('Vikram','Patel','vikram@company.com','9876543214','IT','Frontend Developer','2022-11-01','Active'),
('Sneha','Kumar','sneha@company.com','9876543215','HR','HR Manager','2020-06-10','Active'),
('Arjun','Mehta','arjun@company.com','9876543216','IT','Data Analyst','2023-02-18','Active'),
('Neha','Reddy','neha@company.com','9876543217','Finance','Financial Analyst','2021-09-05','Active'),
('Rohan','Das','rohan@company.com','9876543218','IT','DevOps Engineer','2022-04-22','Active'),
('Kavya','Joshi','kavya@company.com','9876543219','IT','UI/UX Designer','2023-08-14','Active');

-- SALARY DATA
INSERT INTO salary
(employee_id,basic_salary,allowances,other_deductions,tax_rate)
VALUES
(1,40000,5000,1000,10),
(2,35000,4000,500,10),
(3,45000,6000,1000,10),
(4,38000,4000,800,10),
(5,42000,5000,1000,10),
(6,55000,7000,1500,10),
(7,40000,5000,800,10),
(8,39000,4000,700,10),
(9,48000,6000,1200,10),
(10,36000,4500,500,10);

-- ATTENDANCE: OCTOBER 2026
INSERT INTO attendance
(employee_id,attendance_date,check_in,check_out,
 attendance_status,late_minutes)
VALUES
(1,'2026-10-01','09:05','18:00','Present',5),
(2,'2026-10-01','09:00','18:00','Present',0),
(3,'2026-10-01','09:20','18:00','Present',20),
(4,'2026-10-01','09:10','18:00','Present',10),
(5,'2026-10-01','09:00','18:00','Present',0),
(6,'2026-10-01','09:15','18:00','Present',15),
(7,'2026-10-01','09:00','18:00','Present',0),
(8,'2026-10-01','09:08','18:00','Present',8),
(9,'2026-10-01','09:00','18:00','Present',0),
(10,'2026-10-01','09:12','18:00','Present',12);

-- ATTENDANCE: NOVEMBER 2026
INSERT INTO attendance
(employee_id,attendance_date,check_in,check_out,
 attendance_status,late_minutes)
SELECT employee_id,'2026-11-02','09:00','18:00',
       'Present',0
FROM employees;

-- ATTENDANCE: DECEMBER 2026
INSERT INTO attendance
(employee_id,attendance_date,check_in,check_out,
 attendance_status,late_minutes)
SELECT employee_id,'2026-12-01','09:10','18:00',
       'Present',10
FROM employees;

-- LEAVE REQUESTS
INSERT INTO leave_requests
(employee_id,leave_type,start_date,end_date,reason,leave_status)
VALUES
(1,'Casual','2026-10-10','2026-10-11','Personal work','Approved'),
(2,'Sick','2026-11-05','2026-11-06','Medical reasons','Pending'),
(3,'Casual','2026-12-10','2026-12-10','Personal work','Approved'),
(4,'Earned','2026-10-20','2026-10-21','Family function','Approved');

-- VERIFY DATA
SELECT COUNT(*) AS total_employees FROM employees;
SELECT COUNT(*) AS total_attendance FROM attendance;
SELECT COUNT(*) AS total_salary_records FROM salary;
SELECT COUNT(*) AS total_leave_records FROM leave_requests;
