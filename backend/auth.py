
import os
from dotenv import load_dotenv
from backend.db_connection import get_connection

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
load_dotenv(os.path.join(BASE_DIR, ".env"))


def authenticate():
    print("\n========== PAYROLL MANAGEMENT SYSTEM ==========")
    print("1. HR / Admin Login")
    print("2. Employee Login")
    print("3. Exit")

    choice = input("Enter your choice: ")

    if choice == "1":
        password = input("Enter HR/Admin password: ")
        correct_password = os.getenv("HR_LOGIN_PASSWORD")

        if password == correct_password and correct_password:
            print("HR/Admin login successful!")
            return {"role": "hr", "employee_id": None}

        print("Invalid HR/Admin password.")
        return None

    elif choice == "2":
        email = input("Enter your employee email: ")
        password = input("Enter employee login password: ")
        correct_password = os.getenv("EMPLOYEE_LOGIN_PASSWORD")

        if not correct_password or password != correct_password:
            print("Invalid employee login password.")
            return None

        connection = None
        cursor = None

        try:
            connection = get_connection("employee")
            cursor = connection.cursor(dictionary=True)

            cursor.execute(
                """
                SELECT employee_id, first_name, last_name
                FROM employees
                WHERE email = %s AND employment_status = 'Active'
                """,
                (email,)
            )

            employee = cursor.fetchone()

            if employee:
                print("Employee login successful!")
                return {
                    "role": "employee",
                    "employee_id": employee["employee_id"]
                }

            print("Employee not found or inactive.")
            return None

        except Exception as error:
            print("Login error:", error)
            return None

        finally:
            if cursor:
                cursor.close()
            if connection and connection.is_connected():
                connection.close()

    elif choice == "3":
        print("Exiting application.")
        return None

    else:
        print("Invalid choice.")
        return None
