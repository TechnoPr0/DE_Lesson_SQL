CREATE TABLE  level(
    id serial PRIMARY KEY ,
    title varchar(128) NOT NULL
);

CREATE TABLE  department(
    id serial PRIMARY KEY ,
    title varchar(128) NOT NULL,
    full_name_chief varchar(128) NOT NULL ,
    number_of_employees integer NOT NULL
)

CREATE TABLE staff(
    id serial PRIMARY KEY,
    full_name varchar(128) NOT NULL ,
    birthday DATE NOT NULL ,
    start_work DATE NOT NULL ,
    position varchar(128) NOT NULL ,
    level_id integer REFERENCES level(id),
    salary integer NOT NULL ,
    departament_id integer REFERENCES  department(id),
    driving_permit boolean
);

CREATE TABLE  score(
    id serial PRIMARY KEY ,
    staff_id integer REFERENCES staff(id),
    first_quarter varchar(1) CHECK (score.first_quarter ~ '[A-E]'),
    second_quarter varchar(1) CHECK (score.second_quarter ~ '[A-E]'),
    third_quarter varchar(1) CHECK (score.third_quarter ~ '[A-E]'),
    fourth_quarter varchar(1) CHECK (score.fourth_quarter ~ '[A-E]')

);

---------------------------------------------

INSERT INTO level
VALUES
    (1, 'Junior'),
    (2, 'Middle'),
    (3, 'Senior'),
    (4, 'Lead');

INSERT INTO department
VALUES
    (1, 'Отдел разработки', 'Галкин Александр Алексеевич', 3),
    (2, 'Отдел тестирования', 'Павлова Полина Даниэльевна', 2);


INSERT INTO staff
VALUES
(1, 'Иванов Кирилл Егорович', '1989.01.20', '2009.02.02', 'Программист', 3, 190000, 1, 'True' ),
(2, 'Галкин Александр Алексеевич', '1980.11.20', '2000.12.01', 'Руководитель отдела разработки', 4, 250000, 1, 'True'),
(3, 'Беляев Михаил Денисович', '1990.05.10', '2010.09.02', 'Программист', 2, 150000, 1, 'False' ),
(4, 'Королев Александр Александрович', '2000.03.25', '2019.04.15', 'Тестировщик', 1, 60000, 2, 'False'),
(5, 'Павлова Полина Даниэльевна', '1988.05.29', '2010.10.03', 'Руководитель отдела тестирования', 4, 250000, 2, 'True');

---------------------------------------------

INSERT INTO score
VALUES
(1, 1, 'A', 'A', 'B', 'B'),
(2, 2, 'A', 'A', 'A', 'A'),
(3, 3, 'C', 'D', 'B', 'A'),
(4, 4, 'D', 'C', 'A', 'A'),
(5, 5, 'A', 'B', 'B', 'A');

---------------------------------------------

INSERT INTO department
VALUES
(3, 'Отдел Интелектуального анализа данных', 'Пахомова Екатерина Вадимовна', 3);


INSERT INTO  staff
VALUES
(6, 'Пахомова Екатерина Вадимовна', '1990.04.12', '2022.09.20', 'Руководитель отлела Интелектуального анализа данных',
 4, 220000, 3, 'False'),
(7, 'Киселева Майя Егоровна', '1995.06.24', '2022.10.15', 'Аналитик данных', 2, 150000, 3, 'False'),
(8, 'Кузнецов Мирон Валерьевич', '1999.09.30', '2022.11.03', 'Аналитик данных', 1, 65000, 3, 'False');

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