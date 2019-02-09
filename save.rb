require 'sqlite3'


def load
end

  DB = SQLite3::Database.open("db/screenshots.db")
def save(file, user_id)
  @img = file
  blob = SQLite3::Blob.new @img.to_s
  DB.execute("INSERT INTO screenshots (file, user_id) VALUES (?, ?)", blob, user_id)
end

def find_user(username)
  DB.execute("SELECT * FROM USERS WHERE username LIKE ?", "%#{username}%")
end

