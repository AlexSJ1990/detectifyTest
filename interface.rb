require_relative 'app/models/users'
require_relative 'app/controllers/screenshots_controller'
require_relative 'app/controllers/users_controller'

class Router
  def initialize
    @running = true
    @users_controller = UsersController.new
  end

  def run
    puts "Welcome to our url to screenshot app!"
    puts "           --           "
    display_login_tasks
    action = gets.chomp.to_i
    @user = route_login_action(action)
    if @user.nil?
      run
    else
      while @running && @user.logged_on?
        display_tasks
        action = ask_action
        route_action(action)
      end
    end
  end

  private

    def display_tasks
      puts ""
      puts "           What do you want to do next?"
      puts "           1 - logout"
      puts "           2 - get screenshots of urls"
      puts "           3 - retrieve screenshots"
      puts ""
    end

    def display_login_tasks
      puts ""
      puts "         Enter 1 to Login"
      puts "         Enter 2 to Register"
    end

    def route_action(action)
      @screenshots_controller = ScreenshotsController.new(@user)
      case action
      when 1 then stop
      when 2 then @screenshots_controller.create_files_from_cli_or_file
      when 3 then @screenshots_controller.retrieve
      else
        puts "Please press 1, 2, 3 or 4"
      end
    end

    def route_login_action(action)
      case action
      when 1 then @users_controller.login
      when 2 then @users_controller.register
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
      puts "you are logged out"
    end
end

