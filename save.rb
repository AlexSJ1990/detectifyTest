require 'sqlite3'

DB = SQLite3::Database.open("db/screenshots.db")

def load
  # DB.execute(SELECT * file_path FROM screenshots)
  # DB.execute("COUNT * FROM screenshots WHERE ")
end

def save(file, user_id)
  @img = file
  blob = SQLite3::Blob.new @img.to_s
  DB.execute("INSERT INTO screenshots (file, user_id) VALUES (?, ?)", blob, user_id)
end

def find_user(username)
  DB.execute("SELECT * FROM USERS WHERE username LIKE ?", "%#{username}%")
end

def save_user(user)
  username = user.username
  password = user.password
  DB.execute("INSERT INTO USERS (username, password) VALUES (?, ?)", username, password)
end

