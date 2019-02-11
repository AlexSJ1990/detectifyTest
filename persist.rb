require 'sqlite3'

def load_files(user_id)
    begin
        iblob = []
        file_name = []
        ofname = "error.log"
        outfile = File.open(ofname, "w")
        db = SQLite3::Database.open("db/screenshots.db")
        if db
            outfile.puts "db open"
        end
        stm1 = db.prepare "select file from screenshots where user_id LIKE (?);"
        stm1.bind_params(user_id)
        stm2 = db.prepare "select file_name from screenshots where user_id LIKE (?);"
        stm2.bind_params(user_id)

        rs1 = stm1.execute
        rs2 = stm2.execute

        rs2.each_with_index do |row, i|
            file_name[i] = row.join
        end
        rs1.each_with_index do |row, i|
            iblob[i] = row.join
        end

        nrow = file_name.count
        for i in 0..nrow-1
            # Make a file from a blob
            fileOut = File.open "image.PNG", "wb"
            fileOut.write iblob[i]
            # now change the file name
            fileOut.close
            file_path = "screenshot_images" + "/" + file_name[i]
            File.rename('image.PNG', file_path)
        end
        if db
        db.close
        puts "Images DB" + dbname + " is closed"
        end
    rescue SQLite3::Exception => e
    outfile.puts "Exception occurred"
    outfile.puts e
    end
    puts "You will find your images in the directory that this application is running in, in a folder called screenshot_images"
end


def save(file, file_name, file_group_name, user_id)
  if file.class == Array
    in_file = file[0]
    fileIn = File.open in_file, "rb"
  else
    in_file = file
    fileIn = File.open in_file, "rb"
  end
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
    db.execute("SELECT * FROM USERS WHERE username LIKE ?", "#{username}")
end

def save_user(user)
  username = user.username
  password = user.password
  db = SQLite3::Database.open "db/screenshots.db"
  db.execute("INSERT INTO USERS (username, password) VALUES (?, ?)", username, password)
end


