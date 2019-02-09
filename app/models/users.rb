require 'bcrypt'

class User
  include BCrypt
  attr_reader :username
  def initialize(attr = {})
    @username = attr[:username]
    @password = attr[:password]
    @logged_on = false
  end

  def logged_on?
    @logged_on
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end

