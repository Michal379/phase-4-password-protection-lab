class UsersController < ApplicationController
    def create
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      user = current_user
      if user
        render json: user
      else
        render json: { error: "Not authenticated" }, status: :unauthorized
      end
    end
  
    private
  
    def user_params
      params.permit(:username, :password, :password_confirmation)
    end
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  