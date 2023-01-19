-- Active: 1674128693852@@127.0.0.1@3306

-- Práticas

--pratica 1.1 Crie a tabela de users
CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TEXT DEFAULT(DATETIME('now', 'localtime')) NOT NULL
);

SELECT * FROM users;

SELECT DATETIME("now", "localtime");

--pratica 1.2 popule com pelo menos 3 pessoas
INSERT INTO users(id, name, email, password)
VALUES
("u001", "Veloso", "veloso@labenu.com", "12345"),
("u002", "Indio", "indio@labenu.com", "Indio123"),
("u003", "Gabriel", "gabriel@labenu.com", "gabriel123");

DELETE FROM users;

--pratica 2.1 criar tabela de relacao

CREATE TABLE follows (
    follower_id TEXT NOT NULL,
    followed_id TEXT NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followed_id) REFERENCES users(id)
);

SELECT * FROM follows;

INSERT INTO follows (follower_id, followed_id)
VALUES
("u001", "u002"),
("u001", "u003"),
("u002", "u001");

DELETE FROM follows;

SELECT * FROM users
INNER JOIN follows
ON follows.follower_id = users.id;

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id;

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
INNER JOIN users AS usersFollowed
ON follows.followed_id = usersFollowed.id
;

--removendo ambiguidades
SELECT 
users.id AS usersId,
users.name,
users.email,
users.password,
users.create_at AS createAt,
follows.follower_id AS followerId,
follows.followed_id AS followedId,
usersFollowed.name AS nameFollowed
 FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
INNER JOIN users AS usersFollowed
ON follows.followed_id = usersFollowed.id
;