class AuthController < ApplicationController
  skip_before_action :authenticate_user, only: [ :login, :signup ]

  def signup
    user = User.new(signup_params)
    if user.save
      token = jwt_encode({ user_id: user.id })
       render json: { user: UserSerializer.new(user).as_json, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = jwt_encode({ user_id: user.id })
      render json: { user: UserSerializer.new(user).as_json, token: token }
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  private

  def signup_params
    params.permit(:name, :email, :password, :password_confirmation, :role)
  end
end
