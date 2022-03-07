class ApplicationController < ActionController::API
  before_action :valid_jwt_token?

  def valid_jwt_token?
    JwtService.decode token: authorization_header.gsub('Bearer ', '')
  rescue JWT::ExpiredSignature, JWT::InvalidIssuerError, JWT::ImmatureSignature, JWT::DecodeError => e
    render json: { error: JwtService.build_jwt_message(e.class), class_error: e.class }, status: 400
  end

  private

  def authorization_header
    request.headers['Authorization'] || ''
  end
end
