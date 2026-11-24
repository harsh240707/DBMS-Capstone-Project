
USE payroll_attendance;

DELIMITER $$

-- 1. Validate attendance before inserting a record
DROP TRIGGER IF EXISTS validate_attendance_insert$$

CREATE TRIGGER validate_attendance_insert
BEFORE INSERT ON attendance
FOR EACH ROW
BEGIN
    IF NEW.late_minutes < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Late minutes cannot be negative';
    END IF;

    IF NEW.check_in IS NOT NULL
       AND NEW.check_out IS NOT NULL
       AND NEW.check_out <= NEW.check_in THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Check-out must be after check-in';
    END IF;
END$$


-- 2. Validate attendance before updating a record
DROP TRIGGER IF EXISTS validate_attendance_update$$

CREATE TRIGGER validate_attendance_update
BEFORE UPDATE ON attendance
FOR EACH ROW
BEGIN
    IF NEW.late_minutes < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Late minutes cannot be negative';
    END IF;

    IF NEW.check_in IS NOT NULL
       AND NEW.check_out IS NOT NULL
       AND NEW.check_out <= NEW.check_in THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Check-out must be after check-in';
    END IF;
END$$


-- 3. Prevent overlapping approved leave during insertion
DROP TRIGGER IF EXISTS validate_leave_insert$$

CREATE TRIGGER validate_leave_insert
BEFORE INSERT ON leave_requests
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT DEFAULT 0;

    IF NEW.end_date < NEW.start_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Leave end date cannot be before start date';
    END IF;

    IF NEW.leave_status = 'Approved' THEN

        SELECT COUNT(*)
        INTO overlap_count
        FROM leave_requests
        WHERE employee_id = NEW.employee_id
          AND leave_status = 'Approved'
          AND NEW.start_date <= end_date
          AND NEW.end_date >= start_date;

        IF overlap_count > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Overlapping approved leave already exists';
        END IF;

    END IF;
END$$


-- 4. Prevent overlapping approved leave during updates
DROP TRIGGER IF EXISTS validate_leave_update$$

CREATE TRIGGER validate_leave_update
BEFORE UPDATE ON leave_requests
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT DEFAULT 0;

    IF NEW.end_date < NEW.start_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Leave end date cannot be before start date';
    END IF;

    IF NEW.leave_status = 'Approved' THEN

        SELECT COUNT(*)
        INTO overlap_count
        FROM leave_requests
        WHERE employee_id = NEW.employee_id
          AND leave_status = 'Approved'
          AND leave_id <> OLD.leave_id
          AND NEW.start_date <= end_date
          AND NEW.end_date >= start_date;

        IF overlap_count > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Overlapping approved leave already exists';
        END IF;

    END IF;
END$$

DELIMITER ;
