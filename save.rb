require 'sqlite3'
require 'base64'

DB = SQLite3::Database.open("db/screenshots.db")

def load_files(user_id)
  stm = DB.prepare "select file from screenshots where user_id LIKE (?);"
  stm.bind_params(user_id)
  files = stm.execute

  stm = DB.prepare "select file_name from screenshots where user_id LIKE (?);"
  stm.bind_params(user_id)
  files_names = stm.execute

  iBlobs = files.map do |file|
    iBlob = row.join
  end
  #### Make a file from a blob
  iBlobs.each do |blob|
    fileOut = File.open "screenshot_images/image#{((1..10).to_a.sample)}.PNG", "wb"
    fileOut.write blob
    fileOut.close
  end
  #### at this point the new file image2.PNG should miraculously appear
  puts "You will find your images in the directory that this application is running in, in a folder called screenshot_images"
end

def save(file, file_name, file_group_name, user_id)
  if file.class == Array
    in_file = file[0]
    # p in_file.class
    fileIn = File.open in_file, "rb"
  else
    in_file = file
    # p in_file
    fileIn = File.open in_file, "rb"
  end
  img = fileIn.read
  # p "class of img is #{img.class}"
  fileIn.close
  iBlob = SQLite3::Blob.new img
  # p "Class of iBlob is #{iBlob.class}"

  #### insert into a db
  #### open the database
  dbname = "db/screenshots.db"
  db = SQLite3::Database.open dbname
  # if db
  #     puts "Images DB" + dbname + " is open"
  # end
  #### insert iBlob into images table
  stm = db.prepare "insert into screenshots (file, file_name, file_group_name, user_id) values (?, ?, ?, ?);"
  stm.bind_params(iBlob, file_name, file_group_name, user_id)
  rs = stm.execute
end

def find_user(username)
  DB.execute("SELECT * FROM USERS WHERE username LIKE ?", "#{username}")
end

def save_user(user)
  username = user.username
  password = user.password
  DB.execute("INSERT INTO USERS (username, password) VALUES (?, ?)", username, password)
end

