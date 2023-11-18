class Api::V1::UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @users = User.all.select('name, id, bio, email')
    render json: @users
  end

  def show
    @user = User.select('name, id, bio, email').find(params[:id])
    render json: @user
  end

  # Add here

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end
end
