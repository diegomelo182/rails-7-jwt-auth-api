module V1
  class AuthController < ApplicationController
    skip_before_action :valid_jwt_token?

    def sign_in
      user = UserRepository.sign_in auth_params
      token = JwtService.encode(payload: build_token_payload(user))

      render json: { token: token }
    rescue ::InvalidEmailError, ::InvalidPasswordError => e
      render json: { error: e.message, class_error: e.class }, status: 400
    end

    def renew
      token = auth_params[:token]
      payload = JwtService.valid?(token: token)
      renewed_token = JwtService.encode(payload: payload&.first)

      render json: { renewed_token: renewed_token }
    rescue JWT::DecodeError => e
      render json: { error: 'The token is invalid', class_error: e.class }, status: 400
    rescue StandardError => e
      render json: { error: e.message, class_error: e.class }, status: 400
    end

    def valid
      token = auth_params[:token]
      payload = JwtService.valid?(token: token)

      render json: { is_valid: !payload.nil? }
    rescue JWT::DecodeError, JWT::ExpiredSignature => e
      render json: { error: JwtService.build_jwt_message(e.class), class_error: e.class }, status: 400
    rescue StandardError => e
      render json: { error: e.message, class_error: e.class }, status: 400
    end

    private

    def build_jwt_message(klass)
      return 'The token has been expirated' if klass.instance_of? 'JWT::ExpiredSignature'

      'The token is invalid'
    end

    def build_token_payload(data)
      { user_name: data.name, user_email: data.email }
    end

    def auth_params
      params.require(:auth).permit(:login, :password, :token)
    end
  end
end
