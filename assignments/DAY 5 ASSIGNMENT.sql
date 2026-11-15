USE DA8;
DROP TABLE EMPLOYEES;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    job_role VARCHAR(50),
    salary DECIMAL(10,2),
    joining_date DATE,
    city VARCHAR(50)
);


INSERT INTO employees
(emp_id, emp_name, department, job_role, salary, joining_date, city)
VALUES
(101, 'Ravi Kumar', 'IT', 'Developer', 45000, '2023-01-15', 'Vizag'),
(102, 'Priya Sharma', 'HR', 'HR Manager', 55000, '2022-06-20', 'Hyderabad'),
(103, 'Kiran Reddy', 'IT', 'Tester', 40000, '2023-03-10', 'Vizag'),
(104, 'Sneha Rao', 'Finance', 'Accountant', 48000, '2021-11-25', 'Chennai'),
(105, 'Arun Kumar', 'IT', 'Developer', 60000, '2020-08-18', 'Bangalore'),
(106, 'Divya Reddy', 'HR', 'Recruiter', 35000, '2024-01-05', 'Vizag'),
(107, 'Suresh Babu', 'Sales', 'Executive', 42000, '2022-09-12', 'Hyderabad'),
(108, 'Anjali Devi', 'IT', 'Developer', 70000, '2019-05-30', 'Chennai'),
(109, 'Mahesh Kumar', 'Sales', 'Manager', 65000, '2020-02-14', 'Bangalore'),
(110, 'Lakshmi Rao', 'Finance', 'Analyst', 52000, '2023-07-22', 'Hyderabad');
SELECT*FROM EMPLOYEES;
UPDATE employees SET salary = 50000 WHERE emp_id = 101;
UPDATE employees SET salary = salary * 1.10 WHERE department = 'IT';
UPDATE employees SET city = 'Vizag' WHERE emp_id = 102;
UPDATE employees SET job_role = 'Senior Tester' WHERE emp_id = 103;
UPDATE employees SET salary = salary + 5000 WHERE department = 'HR';
UPDATE employees SET city = 'Hyderabad' WHERE city = 'Vizag';
UPDATE employees SET department = 'Development' WHERE emp_id = 105;
UPDATE employees SET salary = salary * 1.15 WHERE salary < 45000;
UPDATE employees SET job_role = 'Senior Developer' WHERE emp_id = 108;
UPDATE employees SET city = 'Bangalore' WHERE department = 'Finance';


DELETE FROM employees WHERE emp_id = 106;
DELETE FROM employees WHERE department = 'Finance';
DELETE FROM employees WHERE salary < 40000;
DELETE FROM employees WHERE city = 'Vizag';
DELETE FROM employees WHERE emp_name = 'Suresh Babu';
DELETE FROM employees WHERE joining_date < '2020-01-01';
DELETE FROM employees WHERE job_role = 'Recruiter';
DELETE FROM employees WHERE department = 'Sales' AND salary < 50000;
DELETE FROM employees WHERE salary = (SELECT * FROM (SELECT MIN(salary) FROM employees) AS t);
DELETE FROM employees WHERE city = 'Chennai';

SELECT * FROM employees;
SELECT * FROM employees WHERE department = 'IT';
SELECT * FROM employees WHERE salary > 50000;
SELECT emp_name, salary FROM employees;
SELECT * FROM employees WHERE city = 'Vizag';
SELECT * FROM employees WHERE joining_date > '2022-01-01';
SELECT * FROM employees WHERE salary BETWEEN 40000 AND 60000;
SELECT * FROM employees WHERE emp_name LIKE '%Kumar';
SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY salary DESC LIMIT 1;






