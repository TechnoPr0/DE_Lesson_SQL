CREATE TABLE  level(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    title  VARCHAR(128) NOT NULL
);

CREATE TABLE  department(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    title VARCHAR(128) NOT NULL,
    full_name_chief VARCHAR(128) NOT NULL ,
    number_of_employees INT NOT NULL
)

CREATE TABLE staff(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(128) NOT NULL ,
    birthday DATE NOT NULL ,
    start_work DATE NOT NULL ,
    position VARCHAR(128) NOT NULL ,
    level_id  INT REFERENCES level(id),
    salary INT NOT NULL ,
    departament_id INT REFERENCES  department(id),
    driving_permit BOOLEAN
);

CREATE TABLE  score(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    staff_id integer REFERENCES staff(id),
    first_quarter VARCHAR(1) CHECK (score.first_quarter ~ '[A-E]'),
    second_quarter VARCHAR(1) CHECK (score.second_quarter ~ '[A-E]'),
    third_quarter VARCHAR(1) CHECK (score.third_quarter ~ '[A-E]'),
    fourth_quarter VARCHAR(1) CHECK (score.fourth_quarter ~ '[A-E]')

);

---------------------------------------------

INSERT INTO level
(title)
VALUES
    ('Junior'),
    ('Middle'),
    ('Senior'),
    ('Lead');

INSERT INTO department
(title, full_name_chief, number_of_employees)
VALUES
    ('Отдел разработки', 'Галкин Александр Алексеевич', 3),
    ('Отдел тестирования', 'Павлова Полина Даниэльевна', 2);


INSERT INTO staff
(full_name, birthday, start_work, position, level_id, salary, departament_id, driving_permit)
VALUES
('Иванов Кирилл Егорович', '1989.01.20', '2009.02.02', 'Программист', 3, 190000, 1, 'True' ),
('Галкин Александр Алексеевич', '1980.11.20', '2000.12.01', 'Руководитель отдела разработки', 4, 250000, 1, 'True'),
('Беляев Михаил Денисович', '1990.05.10', '2010.09.02', 'Программист', 2, 150000, 1, 'False' ),
('Королев Александр Александрович', '2000.03.25', '2019.04.15', 'Тестировщик', 1, 60000, 2, 'False'),
('Павлова Полина Даниэльевна', '1988.05.29', '2010.10.03', 'Руководитель отдела тестирования', 4, 250000, 2, 'True');

---------------------------------------------

INSERT INTO score
(staff_id, first_quarter, second_quarter, third_quarter, fourth_quarter)
VALUES
(1, 'A', 'A', 'B', 'B'),
(2, 'A', 'A', 'A', 'A'),
(3, 'C', 'D', 'B', 'A'),
(4, 'D', 'C', 'A', 'A'),
(5, 'A', 'B', 'B', 'A');

---------------------------------------------

INSERT INTO department
(title, full_name_chief, number_of_employees)
VALUES
('Отдел Интелектуального анализа данных', 'Пахомова Екатерина Вадимовна', 3);


INSERT INTO  staff
(full_name, birthday, start_work, position, level_id, salary, departament_id, driving_permit)
VALUES
('Пахомова Екатерина Вадимовна', '1990.04.12', '2022.09.20', 'Руководитель отлела Интелектуального анализа данных',
 4, 220000, 3, 'False'),
('Киселева Майя Егоровна', '1995.06.24', '2022.10.15', 'Аналитик данных', 2, 150000, 3, 'False'),
('Кузнецов Мирон Валерьевич', '1999.09.30', '2022.11.03', 'Аналитик данных', 1, 65000, 3, 'False');

---------------------------------------------


SELECT id, full_name, SUM((NOW()::date - start_work)/7) AS work_experience
FROM staff
GROUP BY id, full_name

---------------------------------------------

SELECT id, full_name, SUM((NOW()::date - start_work)/7) AS work_experience
FROM staff
GROUP BY id, full_name
LIMIT 3;

---------------------------------------------

SELECT id
FROM staff
WHERE driving_permit = 'True'

---------------------------------------------

SELECT staff.id
FROM staff
JOIN score ON staff.id = score.staff_id
WHERE first_quarter LIKE '%D%' OR first_quarter LIKE  '%E%' OR
second_quarter LIKE '%D%' OR second_quarter LIKE  '%E%' OR
third_quarter LIKE '%D%' OR third_quarter LIKE  '%E%' OR
fourth_quarter LIKE '%D%' OR fourth_quarter LIKE  '%E%' ;

---------------------------------------------

SELECT MAX(salary)
from staff;

SELECT title
FROM department
ORDER BY number_of_employees DESC
LIMIT 1;

---------------------------------------------

SELECT id, full_name, SUM((NOW()::date - start_work)/7) AS work_experience
FROM staff
GROUP BY  id
ORDER BY start_work;

---------------------------------------------

SELECT  level.title, AVG(staff.salary)
FROM level, staff
WHERE staff.level_id = '1' AND level.title = 'Junior'
GROUP BY level.title;

SELECT  level.title, AVG(staff.salary)
FROM level, staff
WHERE staff.level_id = '2' AND level.title = 'Middle'
GROUP BY level.title;

SELECT  level.title, AVG(staff.salary)
FROM level, staff
WHERE staff.level_id = '3' AND level.title = 'Senior'
GROUP BY level.title;

SELECT  level.title, AVG(staff.salary)
FROM level, staff
WHERE staff.level_id = '4' AND level.title = 'Lead'
GROUP BY level.title;