# Payroll & Attendance Management System

A complete DBMS-based application developed for managing employee records, attendance, leave requests, salary calculations and monthly payroll operations in a mid-sized IT organization.

## Project Overview

This project integrates all four DBMS lab concepts into one complete application:

- Data Modeling and Database Design
- SQL Queries and Procedural Implementation
- Transactions and Role-Based Security
- Query Optimization and Reporting

The application provides separate access for HR/Admin and Employees.

## Technologies Used

| Component | Technology |
|---|---|
| Database | MySQL 8.0 |
| Backend | Python |
| Database Connectivity | MySQL Connector |
| Query Language | SQL |
| Interface | Python CLI |
| Version Control | Git and GitHub |

## Database Structure

The application contains five main relational tables:

1. employees
2. attendance
3. leave_requests
4. salary
5. payroll

## Main Features

### HR/Admin
- Add and manage employees.
- Manage attendance records.
- Approve or reject leave requests.
- Maintain employee salary details.
- Generate monthly payroll.
- Calculate tax deductions.
- View attendance and salary reports.

### Employee
- View personal profile.
- View personal attendance records.
- View leave information.
- View personal salary slips.

## DBMS Concepts Implemented

- Entity Relationship Modeling
- Normalization up to 3NF
- Primary and Foreign Keys
- SQL Constraints
- Stored Procedures
- Stored Functions
- Database Triggers
- Joins and Aggregate Queries
- Indexing and Query Optimization
- Role-Based Access Control
- Transaction Management
- COMMIT and ROLLBACK

## Project Folder Structure

```text
Payroll-Attendance-Management-System/
│
├── database/
│   ├── schema.sql
│   ├── sample_data.sql
│   ├── procedures.sql
│   ├── triggers.sql
│   ├── reports.sql
│   └── security.sql
│
├── backend/
│   ├── db_connection.py
│   ├── auth.py
│   ├── hr_operations.py
│   ├── employee_operations.py
│   └── main.py
│
├── screenshots/
├── docs/
├── README.md
├── requirements.txt
└── .gitignore
```

## Installation

### Prerequisites
- Python 3.x
- MySQL Server 8.0.16 or later
- MySQL Workbench
- Git

### Step 1: Clone the repository

```bash
git clone YOUR_REPOSITORY_URL
cd Payroll-Attendance-Management-System
```

### Step 2: Install dependencies

```bash
pip install -r requirements.txt
```

### Step 3: Create the database

Execute the SQL files in the following order:

1. database/schema.sql
2. database/sample_data.sql
3. database/procedures.sql
4. database/triggers.sql
5. database/reports.sql
6. database/security.sql

### Step 4: Configure the database connection

Update the database connection settings using your local MySQL credentials. Use environment variables for passwords.

### Step 5: Run the application

```bash
python backend/main.py
```

## Testing

The project includes test cases for:

- Valid employee registration.
- Duplicate employee email.
- Duplicate attendance.
- Negative salary validation.
- Overlapping leave requests.
- Monthly payroll generation.
- Unauthorized database operations.
- Transaction rollback.

## Future Scope

- Web-based employee dashboard.
- Automated payslip generation.
- Overtime and bonus management.
- Department-wise analytics.
- Cloud database deployment.
- Advanced payroll reporting.

## Conclusion

The Payroll & Attendance Management System demonstrates the practical integration of DBMS concepts into a single application. It provides centralized employee management, automated payroll calculations, attendance tracking, secure data access and optimized reporting.

## Academic Project

**Project:** DBMS Final Assignment  
**Domain:** Payroll and Attendance Management  
**Database:** MySQL  
**Backend:** Python