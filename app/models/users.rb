class User
  attr_reader :username, :password, :id
  def initialize(attr = {})
    @id = attr[:id]
    @username = attr[:username]
    @password = attr[:password]
    @logged_on = false
  end

  def logged_on?
    @logged_on
  end

  def login
    @logged_on = true
  end

  def encrypt
    @password = BCrypt::Password.create(@password)
  end
end

