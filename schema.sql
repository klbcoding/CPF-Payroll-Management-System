-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose
-- creates an employees table to record all current employees in the company.
CREATE TABLE employees (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    department_id INTEGER,
    position_id INTEGER,
    join_date TEXT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(id),
    FOREIGN KEY (position_id) REFERENCES positions(id)
);

-- creates a table with the departments that this company has.
CREATE TABLE departments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    department TEXT NOT NULL
);

-- creates a table with the positions that this company has.
CREATE TABLE positions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    position TEXT NOT NULL
);

-- creates a table of salaries. Every month, the administrator will insert into this table the employees' salaries.
CREATE TABLE salaries (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    employee_id INTEGER,
    gross_salary INTEGER,
    employee_pct REAL,
    employer_pct REAL,
    pay_date DATE DEFAULT (DATE('now')),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

--creating index for pay_date as date is the column most filtered
CREATE INDEX pay_date_index ON salaries (pay_date);

-- creates an overview of the cpf contributions. Auto-updates.
CREATE VIEW cpf_check AS
SELECT name,
age,
FORMAT('$%.2f', gross_salary) AS salary,
CONCAT(employee_pct, '%') AS employee_pct,
CONCAT(employer_pct, '%') AS employer_pct,
FORMAT('$%.2f',(gross_salary * ((100-employee_pct)/100))) AS take_home,
FORMAT('$%.2f',(gross_salary * (employee_pct/100))) AS employee_contr,
FORMAT('$%.2f', (gross_salary * (employer_pct/100))) AS employer_contr,
pay_date
FROM salaries
JOIN employees ON salaries.employee_id = employees.id;

-- Initialising departments
INSERT INTO departments (department)
VALUES ('HR'),
('IT'),
('Accounting and Finance'),
('Marketing');

-- Initialising positions
INSERT INTO positions (position)
VALUES ('HR manager'),
('Administrator'),
('Recruiter'),
('IT project manager'),
('Software developer'),
('Network adminstrator'),
('Financial manager'),
('Accountant'),
('Financial analyst'),
('Marketing manager'),
('Marketing specialist');
