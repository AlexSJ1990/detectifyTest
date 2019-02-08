# require_relative 'screenshot'
require_relative 'user'

# @user.logged_on?
# if false
# tell user to login - use puts
# gets userid
# gets password
# authenticate (this method resides in the database setup file)
# if not authenticated loop back to login + puts error message

# enter 1 to enter urls, enter 2 to use a csv file enter 3 to use json file
# answer = gets.chomp
# if answer = 1 one_url

# DB = SQLite3::Database.new("db/screenshots")

  def one_url
    answer = nil
    url_array = []

    until answer == ""
      puts "Hello type your url's here to get screenshots, if you have finished entering click return"
      answer = gets.chomp
      url_array << answer unless answer == ""
    end
    # invoke get&store(type(1,2 or 3), url, user_id)
  end

  # elsif

# url_array.each do |url|
#   take_screenshot(url)
# end


@running = true



def run
  puts "Welcome to our url to screenshot app!"
  puts "           --           "
  while @running
    # authenticate
    display_tasks
    action = ask_action
    route_action(action)
  end
end

# needs to be put in a separate file to run the program


private

  def display_tasks
    puts ""
    puts "           What do you want to do next?"
    puts "           1 - login or register"
    puts "           2 - Enter urls via the terminal"
    puts "           3 - Upload a csv with urls"
    puts "           4 - Upload a json with urls"
    puts "           5 - retrieve screenshots"
    puts "           5 - Exit the program"
    puts ""
  end

  def route_action(action)
    case action
    when 1 then
    when 2 then
    when 3 then stop
    else
      puts "Please press 1, 2, or 3"
    end
  end

  def ask_action
    puts "What do you want to do next?"
    print "===> "
    gets.chomp.to_i
  end

  def authenticate
    puts ""
    puts "         Enter 1 to Login"
    puts "         Enter 2 to Register"
  end

   def stop
    @running = false
  end

run

