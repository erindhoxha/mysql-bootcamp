-- =====================================================================
-- CRUD challenge: shirts_db
-- =====================================================================

CREATE DATABASE IF NOT EXISTS shirts_db;
USE shirts_db;

CREATE TABLE shirts (
    shirt_id   INT PRIMARY KEY AUTO_INCREMENT,
    article    VARCHAR(50) NOT NULL,
    color      VARCHAR(50) NOT NULL,
    shirt_size VARCHAR(20) NOT NULL,
    last_worn  INT
);

INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES ('t-shirt', 'white',  'xxl', 22),
       ('t-shirt', 'blue',   'xl',  22),
       ('t-shirt', 'blue',   'xl',  25),
       ('t-shirt', 'red',    'xl',  25),
       ('shirt',   'purple', 'xl',  25);

SELECT * FROM shirts;

-- Rename the first two articles
UPDATE shirts SET article = 'shirt' WHERE shirt_id = 1;
UPDATE shirts SET article = 'shirt' WHERE shirt_id = 2;

-- Remove all purple shirts
DELETE FROM shirts WHERE color = 'purple';

SELECT * FROM shirts;
