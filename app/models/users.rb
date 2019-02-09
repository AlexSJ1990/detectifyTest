class User
  def initialize(attr = {})
    @username = attr[:username]
    @password = attr[:password]
    @logged_on = false
  end

  def logged_on?
    @logged_on
  end

  # def login
  #   @logged_on = true
  # end
end
