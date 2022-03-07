class InvalidEmailError < StandardError
  def message
    'Invalid Email'
  end
end
