
from backend.db_connection import get_connection


def view_my_details(employee_id):
    conn = get_connection("employee")
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT employee_id, first_name, last_name, email,
               department, designation, joining_date
        FROM employees
        WHERE employee_id = %s
    """, (employee_id,))

    record = cursor.fetchone()
    print("\n========== MY DETAILS ==========")
    print(record if record else "Employee not found.")

    cursor.close()
    conn.close()


def view_my_attendance(employee_id):
    conn = get_connection("employee")
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT attendance_date, check_in, check_out,
               attendance_status, late_minutes
        FROM attendance
        WHERE employee_id = %s
        ORDER BY attendance_date DESC
    """, (employee_id,))

    print("\n========== MY ATTENDANCE ==========")
    for record in cursor.fetchall():
        print(record)

    cursor.close()
    conn.close()


def view_my_leaves(employee_id):
    conn = get_connection("employee")
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT leave_type, start_date, end_date, reason, leave_status
        FROM leave_requests
        WHERE employee_id = %s
        ORDER BY start_date DESC
    """, (employee_id,))

    print("\n========== MY LEAVE RECORDS ==========")
    for record in cursor.fetchall():
        print(record)

    cursor.close()
    conn.close()


def view_my_salary(employee_id):
    conn = get_connection("employee")
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT payroll_month, payroll_year, gross_salary,
               tax_amount, other_deductions, net_salary,
               payment_date, payment_status
        FROM payroll
        WHERE employee_id = %s
        ORDER BY payroll_year DESC, payroll_month DESC
    """, (employee_id,))

    print("\n========== MY SALARY SLIPS ==========")
    for record in cursor.fetchall():
        print(record)

    cursor.close()
    conn.close()


def employee_menu(employee_id):
    while True:
        print("\n========== EMPLOYEE DASHBOARD ==========")
        print("1. View My Details")
        print("2. View My Attendance")
        print("3. View My Leave Records")
        print("4. View My Salary Slips")
        print("5. Logout")

        choice = input("Enter your choice: ")

        try:
            if choice == "1":
                view_my_details(employee_id)
            elif choice == "2":
                view_my_attendance(employee_id)
            elif choice == "3":
                view_my_leaves(employee_id)
            elif choice == "4":
                view_my_salary(employee_id)
            elif choice == "5":
                print("Employee logged out.")
                break
            else:
                print("Invalid choice.")

        except Exception as error:
            print("Operation failed:", error)
