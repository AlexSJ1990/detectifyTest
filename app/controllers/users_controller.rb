require_relative "../views/user_view"
require_relative "../models/users"
require_relative '../../save'
require 'bcrypt'

class UsersController

  def initialize
    @view = UserView.new
  end

  def register
    username = @view.get_info("what is your username?")
    password = @view.get_info("What is your password?")
    user = User.new(username: username, password: password)
    user.encrypt
    my_password = BCrypt::Password.new(user.password)
    my_password == password
    save_user(user)
  end

  def login
    username = @view.get_info("what is your username?")
    password = @view.get_info("What is your password?")
    user = find_user(username).flatten
    user = User.new(username: user[1], password: user[2])
    my_password = BCrypt::Password.new(user.password)
    if user && (my_password == password)
      @view.print_info("Welcome #{user.username.capitalize}")
      user.login
      return user
    else
      @view.print_info("Sorry invalid details")
      login
    end
  end
end

UsersController.new.register
UsersController.new.login
