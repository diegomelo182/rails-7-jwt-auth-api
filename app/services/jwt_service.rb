# responsible to help with JWT
class JwtService
  def self.decode(token:)
    JWT.decode(token, secret, true, { algorithm: 'HS256' })
  end

  def self.encode(payload:, exp: Time.now.to_i + 4 * 3600)
    payload[:exp] = exp
    JWT.encode(payload, secret, 'HS256')
  end

  def self.valid?(token:)
    decoded = decode(token: token)
    return nil unless decoded&.first&.key?('user_email')

    decoded
  end

  def self.secret
    Rails.application.credentials.jwt_token_secret
  end

  def self.build_jwt_message(klass)
    return 'Token has been expirated' if klass.to_s == 'JWT::ExpiredSignature'
    return 'Token signature is invalid' if klass.to_s == 'JWT::ImmatureSignature'

    'Token is invalid'
  end
end
