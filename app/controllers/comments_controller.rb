class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @user = @current_user
  end

  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @comment = @post.comments.new(comment_params.merge(author: @user))

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Submitted new comment .'
    else
      render :new
    end
  end

  def destroy
    @user = current_user
    @comment = Comment.find(params[:id])

    if @comment.author == @user
      @comment.destroy
      flash[:notice] = 'Deleted comment .'
    end

    redirect_to user_post_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
