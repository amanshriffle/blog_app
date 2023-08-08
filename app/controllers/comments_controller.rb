class CommentsController < ApplicationController
  def index
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments

    render json: @comment
  end

  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.create(comment_params)

    render json: [@blog, @comment]
  end

  def show
    @comment = Blog.find(params[:blog_id]).comments.find(params[:id])
    @replies = @comment.replies
    render json: [@comment, @replies]
  end

  private

  def comment_params
    params.permit(:comment, :user_id)
  end
end
