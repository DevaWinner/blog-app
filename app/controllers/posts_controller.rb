class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    set_current_user
    @post = @current_user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_post_path(@current_user.id, @post.id), notice: 'Your post was successfully created.'
    else
      render :new
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
