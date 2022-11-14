CREATE TABLE  level(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    title  VARCHAR(128) NOT NULL
);

CREATE TABLE  department(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    title VARCHAR(128) NOT NULL,
    full_name_chief VARCHAR(128) NOT NULL ,
    number_of_employees INT NOT NULL
);

CREATE TABLE staff(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(128) NOT NULL ,
    birthday DATE NOT NULL ,
    start_work DATE NOT NULL ,
    position VARCHAR(128) NOT NULL ,
    level_id INT,
    salary INT NOT NULL ,
    department_id INT,
    driving_permit BOOLEAN,

    CONSTRAINT level_title
        FOREIGN KEY (level_id)
        REFERENCES level(id),
    CONSTRAINT department
        FOREIGN KEY (department_id)
        REFERENCES  department(id)
);

CREATE TABLE  score(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    staff_id INT,
    first_quarter VARCHAR(1) CHECK (score.first_quarter ~ '[A-E]'),
    second_quarter VARCHAR(1) CHECK (score.second_quarter ~ '[A-E]'),
    third_quarter VARCHAR(1) CHECK (score.third_quarter ~ '[A-E]'),
    fourth_quarter VARCHAR(1) CHECK (score.fourth_quarter ~ '[A-E]'),
    CONSTRAINT staff_id
        FOREIGN KEY (staff_id)
        REFERENCES staff(id)
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
(full_name, birthday, start_work, position, level_id, salary, department_id, driving_permit)
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
(full_name, birthday, start_work, position, level_id, salary, department_id, driving_permit)
VALUES
('Пахомова Екатерина Вадимовна', '1990.04.12', '2022.09.20', 'Руководитель отлела Интелектуального анализа данных',
 4, 220000, 3, 'False'),
('Киселева Майя Егоровна', '1995.06.24', '2022.10.15', 'Аналитик данных', 2, 150000, 3, 'False'),
('Кузнецов Мирон Валерьевич', '1999.09.30', '2022.11.03', 'Аналитик данных', 1, 65000, 3, 'False');

--------------------------------------------------------------------------------------------------------------------

SELECT SUBSTR (full_name, 1, POSITION(' ' IN full_name)-1) AS name
FROM staff
WHERE salary=(SELECT MAX(salary) FROM staff);

---------------------------------------------------------

SELECT SUBSTR (full_name, 1, POSITION(' ' IN full_name)-1) AS name
FROM staff
ORDER BY name

---------------------------------------------------------


SELECT title, (
    SELECT  AVG((NOW()::date - start_work)/365)AS work
    FROM staff
    WHERE level_id = level.id)
FROM level


-------------------------------------------------------