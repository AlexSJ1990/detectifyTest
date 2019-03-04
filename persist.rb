require 'sqlite3'

def load_files(user_id)
  begin
    iblob = []
    file_name = []
    outfile = File.open("error.log", "w")
    db = SQLite3::Database.open("db/screenshots.db")

    outfile.puts "db open" if db

    stm1 = db.prepare "select file from screenshots where user_id LIKE (?);"
    stm1.bind_params(user_id)
    stm2 = db.prepare "select file_name from screenshots where user_id LIKE (?);"
    stm2.bind_params(user_id)

    rs1 = stm1.execute
    rs2 = stm2.execute

    rs2.each do |row|
      file_name << row.join
    end

    rs1.each do |row|
      iblob << row.join
    end

    for i in 0..(file_name.count - 1)
      # Make a file from a blob
      # opening a binary file for writing in if it doesn't exist it will create it
      fileOut = File.open "image.PNG", "wb"
      fileOut.write iblob[i]
      # now change the file name
      fileOut.close
      file_path = "screenshot_images" + "/" + file_name[i]
      File.rename('image.PNG', file_path)
    end
    db.close if db
    rescue SQLite3::Exception => e
    outfile.puts "Exception occurred"
    outfile.puts e
  end
end


def save(file, file_name, file_group_name, user_id)
  fileIn = File.open file, "rb"
  img = fileIn.read
  fileIn.close
  iBlob = SQLite3::Blob.new img
  dbname = "db/screenshots.db"
  db = SQLite3::Database.open dbname
  stm = db.prepare "insert into screenshots (file, file_name, file_group_name, user_id) values (?, ?, ?, ?);"
  stm.bind_params(iBlob, file_name, file_group_name, user_id)
  rs = stm.execute
end

def find_user(username)
  db = SQLite3::Database.open "db/screenshots.db"
  statement = db.execute("SELECT * FROM USERS WHERE username LIKE ?", "#{username}")
end

def save_user(user)
  username = user.username
  password = user.password
  db = SQLite3::Database.open "db/screenshots.db"
  db.execute("INSERT INTO USERS (username, password) VALUES (?, ?)", username, password)
end


