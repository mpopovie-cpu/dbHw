CREATE TABLE tests (
    test_id SERIAL PRIMARY KEY,
    test_name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE questions (
    question_id SERIAL PRIMARY KEY,
    test_id INT REFERENCES tests(test_id) ON DELETE CASCADE,
    question_text TEXT NOT NULL
);

CREATE TABLE answers (
    answer_id SERIAL PRIMARY KEY,
    question_id INT REFERENCES questions(question_id) ON DELETE CASCADE,
    answer_text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT check_one_to_five CHECK (length(answer_text) > 0)
);

INSERT INTO tests (test_name, description) VALUES
('Математика 1', 'Простейший тест по арифметике'),
('История 1', 'Вопросы по истории');

INSERT INTO questions (test_id, question_text) VALUES
(1, 'Сколько будет 2+2?'),
(1, 'Сколько будет 5-3?'),
(2, 'Кто был первым императором Рима?'),
(2, 'В каком году началась Вторая мировая война?');

INSERT INTO answers (question_id, answer_text, is_correct) VALUES
(1, '3', FALSE),
(1, '4', TRUE),
(1, '5', FALSE),
(2, '1', FALSE),
(2, '2', TRUE),
(2, '3', FALSE),
(3, 'Юлий Цезарь', FALSE),
(3, 'Август', TRUE),
(3, 'Нерон', FALSE),
(4, '1939', TRUE),
(4, '1914', FALSE),
(4, '1945', FALSE);

SELECT * FROM tests;

SELECT q.question_id, q.question_text, t.test_name
FROM questions q
JOIN tests t ON q.test_id = t.test_id;

SELECT * FROM answers WHERE question_id = 1;

SELECT q.question_text, a.answer_text
FROM questions q
JOIN answers a ON q.question_id = a.question_id
WHERE a.is_correct = TRUE;
