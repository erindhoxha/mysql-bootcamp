-- =====================================================================
-- Window functions (MySQL 8+)
-- Topics: OVER(), PARTITION BY, RANK, DENSE_RANK, ROW_NUMBER, NTILE,
--         FIRST_VALUE, LAG, LEAD
-- =====================================================================

CREATE DATABASE IF NOT EXISTS window_funcs;
USE window_funcs;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_no     INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary     INT
);

INSERT INTO employees (department, salary)
VALUES ('engineering', 80000), ('engineering', 69000), ('engineering', 70000),
       ('sales', 59000), ('sales', 60000);

-- GROUP BY collapses rows...
SELECT department, AVG(salary) FROM employees GROUP BY department;

-- ...a window function keeps every row
SELECT emp_no, department, salary,
       AVG(salary) OVER () AS company_avg,
       MIN(salary) OVER () AS company_min,
       MAX(salary) OVER () AS company_max
FROM employees;

-- PARTITION BY: aggregates per department, row by row
SELECT emp_no, department, salary,
       MIN(salary) OVER (PARTITION BY department) AS dept_min,
       MAX(salary) OVER (PARTITION BY department) AS dept_max
FROM employees;

-- RANK vs DENSE_RANK vs ROW_NUMBER
SELECT emp_no, department, salary,
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_row_number,
       RANK()       OVER (PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank,
       RANK()       OVER (ORDER BY salary DESC)                         AS overall_salary_rank,
       DENSE_RANK() OVER (ORDER BY salary DESC)                         AS overall_dense_rank
FROM employees;

-- NTILE: split rows into buckets
SELECT emp_no, department, salary,
       NTILE(2) OVER (PARTITION BY department ORDER BY salary DESC) AS dept_salary_half,
       NTILE(4) OVER (ORDER BY salary DESC)                         AS salary_quartile
FROM employees;

-- FIRST_VALUE: the top earner, per department and overall
SELECT emp_no, department, salary,
       FIRST_VALUE(emp_no) OVER (PARTITION BY department ORDER BY salary DESC) AS highest_paid_dept,
       FIRST_VALUE(emp_no) OVER (ORDER BY salary DESC)                         AS highest_paid_overall
FROM employees;

-- LAG / LEAD: look at the previous / next row
SELECT emp_no, department, salary,
       LAG(salary)  OVER (ORDER BY salary DESC) AS prev_salary,
       LEAD(salary) OVER (ORDER BY salary DESC) AS next_salary
FROM employees;

-- Gap to the next-highest salary in the same department
SELECT emp_no, department, salary,
       salary - LAG(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS salary_diff
FROM employees;
