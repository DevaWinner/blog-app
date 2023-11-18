class Api::V1::PostsController < ApplicationController
  def index
    @posts = User.find(params[:user_id]).posts
    render json: @posts
  end

  # Add here

  def set_user
    @user = User.find(params[:user_id])
  end
end
