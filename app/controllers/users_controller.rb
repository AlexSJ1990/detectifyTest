require_relative "../views/user_view"
require_relative "../models/users"
require_relative '../../persist'
require 'bcrypt'

class UsersController

  def initialize
    @view = UserView.new
  end

  def register
    @view.print_info("        Register here")
    username = @view.get_info("       what is your username?")
    password = @view.get_info("       What is your password?")
    user = User.new(username: username, password: password)
    user.encrypt
    my_password = BCrypt::Password.new(user.password)
    my_password == password
    save_user(user)
    @view.print_info("        Great, you are registered! \n")
    @view.print_info("        Please now login")
    login
  end

  def login
    username = @view.get_info("       what is your username?")
    password = @view.get_info("       What is your password?")
    user = find_user(username).flatten
    if user == []
      @view.print_info("        You cannot be found on our system, please register first")
      register
    else
      @user = User.new(id: user[0], username: user[1], password: user[2])
      my_password = BCrypt::Password.new(@user.password)
      if @user && (my_password == password)
        @view.print_info("        Welcome #{@user.username.capitalize}")
        @view.puts_space
        @user.login
        return @user
      else
        @view.print_info("        Sorry invalid details")
        login
      end
    end
  end
end
