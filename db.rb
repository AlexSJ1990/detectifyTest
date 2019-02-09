require "sqlite3"

-- dir = File.dirname(__FILE__)
db = SQLite3::Database.new("db/screenshots.db")
db.execute('DROP TABLE IF EXISTS `screenshots`;')
db.execute('DROP TABLE IF EXISTS `users`;')

create_statement = "
CREATE TABLE screenshots (
  `id`  INTEGER PRIMARY KEY AUTOINCREMENT,
  `file` BLOB,
  `user_id` INTEGER,
  FOREIGN KEY(user_id) REFERENCES user(id)
);"

create_statement2 = "
CREATE TABLE users (
  `id`  INTEGER PRIMARY KEY AUTOINCREMENT,
  `username` VARCHAR,
  `password` VARCHAR
);"

db.execute(create_statement)
db.execute(create_statement2)



