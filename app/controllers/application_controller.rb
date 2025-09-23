class ApplicationController < ActionController::API
  include JwtToken

  before_action :authenticate_user

  private

  def authenticate_user
    header = request.headers['Authorization']&.split(' ')&.last
    if header.present?
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    else
      render json: { error: 'Nil JSON web token' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :unauthorized
  rescue JWT::DecodeError => e
    render json: { error: e.message }, status: :unauthorized
  end
end
