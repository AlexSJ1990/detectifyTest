require_relative "../views/user_view"

class UsersController

  def initialize
    @view = UserView.new
  end

  def register
    @view.get_info("what is your username?")
    @view.get_info("What is your password?")

  end


  def authenticate
    username = @view.get_info("what is your username?")
    password = @view.get_info("What is your password?")
    user = find_user(username).flatten
    user = User.new(username: user[1], password: user[2])

    if user && (password == user.password)
      @view.print_info("Welcome #{user.username.capitalize}")
      return user
    else
      @session_view.print_info("Sorry invalid details")
      authenticate
    end
  end
end
