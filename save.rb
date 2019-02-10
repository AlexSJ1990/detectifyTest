require 'sqlite3'
require 'base64'

DB = SQLite3::Database.open("db/screenshots.db")

def load
    DB.execute( "SELECT file FROM screenshots" ) do |file|
    p file
    fileOut = File.open "images/facebook - 10 Feb 2019 16:04:56PM.png", "wb"
    fileOut.write iBlob
    fileOut.close
  end
end

def save(file, user_id)
  # don't think you can use file.count here
  if file.class == Array
  # if file.count > 0
    p "I should be an array here"
    in_file = file[0]
    p in_file.class

    fileIn = File.open in_file, "rb"
  else
    p "I'm in the else - not an array"
    in_file = file
    p in_file
    fileIn = File.open in_file, "rb"
  end
  img = fileIn.read
  p img.class
  iBlob = SQLite3::Blob.new img
  # p file
  # @img = file
  # p @img
  # blob = SQLite3::Blob.new @img.to_s
  # p blob

  DB.execute("INSERT INTO screenshots (file, user_id) VALUES (?, ?)", iBlob, user_id)
end

def find_user(username)
  DB.execute("SELECT * FROM USERS WHERE username LIKE ?", "#{username}")
end

def save_user(user)
  username = user.username
  password = user.password
  DB.execute("INSERT INTO USERS (username, password) VALUES (?, ?)", username, password)
end

# load
