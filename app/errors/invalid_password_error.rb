class InvalidPasswordError < StandardError
  def message
    'Invalid password'
  end
end
