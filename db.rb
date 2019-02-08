require "sqlite3"

dir = File.dirname(__FILE__)
DB = SQLite3::Database.new(File.join(dir, "db/screenshots"))

DB.execute('DROP TABLE IF EXISTS `screenshots`;')
create_statement = "
CREATE TABLE `screenshots` (
  `id`  INTEGER PRIMARY KEY AUTOINCREMENT,
  `file` BLOB,
  `user_id`,
  FOREIGN KEY(user_id) REFERENCES user(id)
);

CREATE TABLE `users` (
  `id`  INTEGER PRIMARY KEY AUTOINCREMENT,
  `username` VARCHAR,
  `password` VARCHAR
);"

DB.execute(create_statement)


