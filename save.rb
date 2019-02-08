require 'sqlite3'

DB = SQLite3::Database.new("db/screenshots.db")

def load
end

def save(file, user_id)
  @img = file
  blob = SQLite3::Blob.new @img.to_s
  DB.execute("INSERT INTO screenshots (file, user_id) VALUES (?, ?)", blob, user_id)
end
