class User
  def initialize(username, password)
    @username = username
    @password = password
    @logged_on = false
  end

  def logged_on?
    @logged_on
  end

  # def login
  #   @logged_on = true
  # end
end
