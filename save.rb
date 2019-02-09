require 'sqlite3'


def load
end

def save(file, user_id)
  db = SQLite3::Database.open("db/screenshots.db")
  # puts "Database is open" if db
  @img = file
  blob = SQLite3::Blob.new @img.to_s
  db.execute("INSERT INTO screenshots (file, user_id) VALUES (?, ?)", blob, user_id)
end




