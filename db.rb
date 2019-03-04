require "sqlite3"

db = SQLite3::Database.new("db/screenshots.db")
db.execute('DROP TABLE IF EXISTS `screenshots`;')
db.execute('DROP TABLE IF EXISTS `users`;')

create_statement = "
CREATE TABLE screenshots (
  `id`  INTEGER PRIMARY KEY AUTOINCREMENT,
  `file` BLOB,
  `file_name` STRING,
  `file_group_name` STRING,
  `user_id` INTEGER,
  FOREIGN KEY(user_id) REFERENCES user(id)
);"

create_statement2 = "
CREATE TABLE users (
  `id`  INTEGER PRIMARY KEY AUTOINCREMENT,
  `username` VARCHAR UNIQUE,
  `password` VARCHAR
);"

db.execute(create_statement)
db.execute(create_statement2)



