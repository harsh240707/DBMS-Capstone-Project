
from backend.auth import authenticate
from backend.hr_operations import hr_menu
from backend.employee_operations import employee_menu


def main():
    print("\n========================================")
    print("   PAYROLL & ATTENDANCE MANAGEMENT")
    print("========================================")

    while True:
        user = authenticate()

        if user is None:
            print("\nLogin unsuccessful or application exited.")
            break

        if user["role"] == "hr":
            hr_menu()

        elif user["role"] == "employee":
            employee_menu(user["employee_id"])

        print("\nReturning to login menu...")


if __name__ == "__main__":
    main()
