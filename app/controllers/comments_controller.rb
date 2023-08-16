class CommentsController < ApplicationController
  before_action :blog, only: [:index, :create]
  before_action :comment, only: [:show, :destroy]

  def index
    @comment = @blog.comments.where(replied_on: nil)

    render json: @comment
  end

  def create
    @comment = @blog.comments.create(comment_params)

    render json: [@blog, @comment]
  end

  def show
    @replies = @comment.replies

    render json: [@comment, @replies]
  end

  def destroy
    comment.destroy if comment.user_id == @current_user.id

    render json: comment, status: :see_other
  end

  private

  def blog
    @blog = Blog.find(params[:blog_id])
  end

  def comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.permit(:comment, @current_user.id)
  end
end
