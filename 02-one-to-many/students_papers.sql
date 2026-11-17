-- =====================================================================
-- Exercise: students & papers
-- Topics: one-to-many, INNER vs LEFT JOIN, IFNULL, AVG, IF()
-- =====================================================================

CREATE DATABASE IF NOT EXISTS students;
USE students;

DROP TABLE IF EXISTS papers, students;

CREATE TABLE students (
    id         INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100)
);

CREATE TABLE papers (
    id         INT PRIMARY KEY AUTO_INCREMENT,
    title      VARCHAR(100),
    grade      INT,
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students (id)
);

INSERT INTO students (first_name)
VALUES ('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade)
VALUES (1, 'My First Book Report', 60),
       (1, 'My Second Book Report', 75),
       (2, 'Russian Lit Through The Ages', 94),
       (2, 'De Montaigne and The Art of The Essay', 98),
       (4, 'Borges and Magical Realism', 89);

-- 1. Students with their papers, best grade first (inner join)
SELECT first_name, title, grade
FROM students
JOIN papers ON papers.student_id = students.id
ORDER BY grade DESC;

-- 2. All students, including those without papers (left join)
SELECT first_name, title, grade
FROM students
LEFT JOIN papers ON papers.student_id = students.id;

-- 3. Replace missing values
SELECT first_name,
       IFNULL(title, 'MISSING') AS title,
       IFNULL(grade, 0)         AS grade
FROM students
LEFT JOIN papers ON papers.student_id = students.id;

-- 4. Average grade per student
SELECT first_name, AVG(IFNULL(grade, 0)) AS average
FROM students
LEFT JOIN papers ON students.id = papers.student_id
GROUP BY students.id, first_name
ORDER BY average DESC;

-- 5. Average grade + passing status
SELECT first_name,
       AVG(IFNULL(grade, 0)) AS average,
       IF(AVG(IFNULL(grade, 0)) > 50, 'PASSING', 'FAILING') AS passing_status
FROM students
LEFT JOIN papers ON students.id = papers.student_id
GROUP BY students.id, first_name
ORDER BY average DESC;
