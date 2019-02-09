# require_relative 'screenshot'
require_relative 'app/models/users'
require_relative 'app/controllers/screenshots_controller'
require_relative 'app/controllers/users_controller'

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

class Router
  def initialize
    @running = true
    @screenshots_controller = ScreenshotsController.new
    @users_controller = UsersController.new
  end

  def run
    puts "Welcome to our url to screenshot app!"
    puts "           --           "
    # @user = @users_controller.authenticate # here we want to test whether logged in or not
    display_login_tasks
    action = gets.chomp.to_i
    route_login_action(action)
    while @running && @user.logged_on?
      display_tasks
      action = ask_action
      route_action(action)
    end
  end

  private

    def display_tasks
      puts ""
      puts "           What do you want to do next?"
      puts "           1 - logout"
      puts "           2 - get screenshots of urls"
      puts "           3 - retrieve screenshots"
      puts "           4 - Exit the program"
      puts ""
    end

    def display_login_tasks
      puts ""
      puts "         Enter 1 to Login"
      puts "         Enter 2 to Register"
    end

    def route_action(action)
      case action
      # when 1 then @users_controller.authenticate
      when 2 then @screenshots_controller.create
      when 3 then @screenshots_controller.retrieve
      when 4 then stop
      else
        puts "Please press 1, 2, 3 or 4"
      end
    end

    def route_login_action(action)
      case action
      when 1 then @users_controller.authenticate
      when 2 then
      else
        puts "Please press 1 or 2"
      end
    end

    def ask_action
      puts "What do you want to do next?"
      print "===> "
      gets.chomp.to_i
    end

     def stop
      @running = false
    end
end

