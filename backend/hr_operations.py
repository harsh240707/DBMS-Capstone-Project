
from backend.db_connection import get_connection


def view_employees():
    conn = get_connection("hr")
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT employee_id, first_name, last_name, email,
               department, designation, employment_status
        FROM employees
        ORDER BY employee_id
    """)

    for employee in cursor.fetchall():
        print(employee)

    cursor.close()
    conn.close()


def view_attendance():
    conn = get_connection("hr")
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT e.employee_id,
               CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
               a.attendance_date,
               a.attendance_status,
               a.late_minutes
        FROM attendance a
        JOIN employees e ON a.employee_id = e.employee_id
        ORDER BY a.attendance_date DESC, e.employee_id
    """)

    for record in cursor.fetchall():
        print(record)

    cursor.close()
    conn.close()


def generate_monthly_payroll():
    month = int(input("Enter payroll month (1-12): "))
    year = int(input("Enter payroll year: "))

    if not 1 <= month <= 12:
        print("Invalid month.")
        return

    conn = get_connection("hr")
    cursor = conn.cursor()

    try:
        cursor.callproc("generate_payroll", [month, year])
        conn.commit()
        print("Payroll generation completed successfully!")

    except Exception as error:
        conn.rollback()
        print("Payroll error:", error)

    finally:
        cursor.close()
        conn.close()


def view_payroll():
    conn = get_connection("hr")
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT p.payroll_id, p.employee_id,
               CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
               p.payroll_month, p.payroll_year,
               p.gross_salary, p.tax_amount,
               p.other_deductions, p.net_salary,
               p.payment_status
        FROM payroll p
        JOIN employees e ON p.employee_id = e.employee_id
        ORDER BY p.payroll_year DESC, p.payroll_month DESC
    """)

    for record in cursor.fetchall():
        print(record)

    cursor.close()
    conn.close()


def hr_menu():
    while True:
        print("\n========== HR / ADMIN DASHBOARD ==========")
        print("1. View Employees")
        print("2. View Attendance")
        print("3. Generate Monthly Payroll")
        print("4. View Payroll Records")
        print("5. Logout")

        choice = input("Enter your choice: ")

        if choice == "1":
            view_employees()
        elif choice == "2":
            view_attendance()
        elif choice == "3":
            generate_monthly_payroll()
        elif choice == "4":
            view_payroll()
        elif choice == "5":
            print("HR/Admin logged out.")
            break
        else:
            print("Invalid choice.")
