class Api::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # ... other actions go here ...

private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
