-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Viewing the payroll for a specific time period (change the WHERE statement accordingly)
SELECT *
FROM cpf_check
WHERE pay_date BETWEEN '2024-09-01' AND '2024-09-30';

--Viewing the total employer contributions in that particular month
SELECT FORMAT('$%.2f', SUM(gross_salary * (employer_pct/100))) AS sum_employer_contr
FROM salaries
WHERE pay_date BETWEEN '2024-09-01' AND '2024-09-30';

-- Viewing employee, department, position and salary history (can use WHERE for a particular time frame)
SELECT name, age, gross_salary, department, position, pay_date
FROM employees
JOIN departments ON employees.department_id = departments.id
JOIN positions ON employees.position_id = positions.id
JOIN salaries ON employees.id = salaries.employee_id
WHERE pay_date BETWEEN '2024-09-01' AND '2024-09-30';

-- Viewing tables accordingly:
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM positions;
SELECT * FROM salaries;

-- Adding a new department
INSERT INTO departments (department)
VALUES ('Placeholder');

-- Adding a new position
INSERT INTO positions (position)
VALUES ('Placeholder');

-- Adding a new employee (note the format YYYY-MM-DD). Refer to departments and positions for the id.
INSERT INTO employees (name, age, department_id, position_id, join_date)
VALUES ('John', 25, 3, 8, '2024-08-04'),
('May', 23, 2, 5, '2024-08-04');

-- During payday, insert salaries into database. Refer to 'employees' table for employee_id and amend percentages
-- with reference from CPF webpage.
INSERT INTO salaries (employee_id, gross_salary, employee_pct, employer_pct)
VALUES (1, 3000, 20, 17),
(2, 5000, 20, 17);

-- If an employee resigns or gets retrenched, delete their name from the database. Archives should be in paper form
DELETE FROM employees WHERE id = ?
DELETE FROM salaries WHERE employee_id = ?

-- Periodically update the ages of the employees
UPDATE employees
SET age = ?
WHERE id = ?;
