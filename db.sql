CREATE TABLE screenshots (
  `id`  INTEGER PRIMARY KEY AUTOINCREMENT,
  `file` BLOB,
  `user_id` INTEGER,
  FOREIGN KEY(user_id) REFERENCES user(id)
);

CREATE TABLE users (
  `id`  INTEGER PRIMARY KEY AUTOINCREMENT,
  `username` VARCHAR,
  `password` VARCHAR
);

