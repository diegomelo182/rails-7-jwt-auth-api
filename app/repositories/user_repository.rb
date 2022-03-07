class UserRepository
  def self.sign_in(params = {})
    login, password = params.values_at :login, :password
    user = User.find_by(email: login)

    raise InvalidEmailError unless user
    raise InvalidPasswordError unless user.authenticate password

    user
  end
end
