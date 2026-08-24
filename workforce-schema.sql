CREATE DATABASE IF NOT EXISTS company_hr_db;
USE company_hr_db;

-- departments table
CREATE TABLE departments (
    department_code VARCHAR(20) PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

-- employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    other_name VARCHAR(255),
    last_name VARCHAR(255) NOT NULL,
    age INT,
    department_code VARCHAR(20),
    position VARCHAR(100),
    date_joined DATE,
    phone_number BIGINT UNSIGNED,
    email_address VARCHAR(150) UNIQUE,
    gender VARCHAR(20),
    employee_status VARCHAR(50),

    CONSTRAINT fk_employees_department
        FOREIGN KEY (department_code)
        REFERENCES departments(department_code)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- education
CREATE TABLE education (
    education_record_id INT PRIMARY KEY,
    employee_id INT NOT NULL,
    institution_country VARCHAR(100),
    education_level VARCHAR(50),
    institution_name VARCHAR(255),
    degree_title VARCHAR(100),
    field_of_study VARCHAR(100),
    graduation_date DATE,

    CONSTRAINT fk_education_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- health_records
CREATE TABLE health_records (
    health_id VARCHAR(50) PRIMARY KEY,
    employee_id INT NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    medical_leave_eligible VARCHAR(10),
    insurance_status VARCHAR(50),
    insurance_provider VARCHAR(100),
    policy_number VARCHAR(100) UNIQUE,
    insurance_plan_type VARCHAR(50),
    medical_leave_balance INT,

    CONSTRAINT fk_health_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- finance_records
CREATE TABLE finance_records (
    finance_id VARCHAR(50) PRIMARY KEY,
    staff_id INT NOT NULL,
    basic_salary DECIMAL(12,2),
    tax_id VARCHAR(50),
    account_number VARCHAR(50),
    allowances DECIMAL(12,2),
    bank_name VARCHAR(255),

    CONSTRAINT fk_finance_employee
        FOREIGN KEY (staff_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- employee_performance
CREATE TABLE employee_performance (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    year INT NOT NULL,
    performance_score DECIMAL(5,2),
    projects_completed INT,
    training_hours INT,
    attendance_rate_percent DECIMAL(5,2),
    bonus_awarded VARCHAR(20),

    CONSTRAINT fk_employee_performance_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- department_performance
CREATE TABLE department_performance (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100),
    department_code VARCHAR(20) NOT NULL,
    year INT NOT NULL,
    average_performance_score DECIMAL(5,2),
    total_revenue_generated DECIMAL(15,2),
    total_cost DECIMAL(15,2),
    training_hours_completed INT,

    CONSTRAINT fk_department_performance_department
        FOREIGN KEY (department_code)
        REFERENCES departments(department_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);