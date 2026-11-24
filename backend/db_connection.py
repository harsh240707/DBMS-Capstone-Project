
import os
import mysql.connector
from dotenv import load_dotenv

# Load environment variables from the project root
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
load_dotenv(os.path.join(BASE_DIR, ".env"))


def get_connection(role="hr"):
    """
    Connect to MySQL using the selected database account.
    role can be 'hr' or 'employee'.
    """

    if role == "hr":
        user = os.getenv("HR_DB_USER")
        password = os.getenv("HR_DB_PASSWORD")

    elif role == "employee":
        user = os.getenv("EMPLOYEE_DB_USER")
        password = os.getenv("EMPLOYEE_DB_PASSWORD")

    else:
        raise ValueError("Invalid database role")

    if not user or not password:
        raise RuntimeError("Database credentials are missing in .env")

    connection = mysql.connector.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=int(os.getenv("DB_PORT", "3306")),
        user=user,
        password=password,
        database="payroll_attendance"
    )

    return connection


if __name__ == "__main__":
    try:
        conn = get_connection("hr")

        if conn.is_connected():
            print("MySQL connection successful!")
            print("Database: payroll_attendance")

        conn.close()

    except mysql.connector.Error as error:
        print("MySQL connection failed:", error)

    except Exception as error:
        print("Error:", error)
