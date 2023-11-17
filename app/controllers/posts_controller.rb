class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.new
    @post = Post.find params[:id]
    @posts = Post.all
    @user = current_user
    @recent_comments = @post.five_most_recent_comments
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = @current_user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      flash[:notice] = 'New post submited.'
      redirect_to user_post_path(@user, @post)
    else
      flash[:alert] = 'Something went wrong while submiting post.'
      render :new
    end
  end

  # Add here

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
