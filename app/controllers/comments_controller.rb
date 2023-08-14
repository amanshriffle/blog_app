class CommentsController < ApplicationController
  def index
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.where(replied_on: nil)

    render json: @comment
  end

  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.create(comment_params)

    render json: [@blog, @comment]
  end

  def show
    @comment = Comment.find(params[:id])
    @replies = @comment.replies

    render json: [@comment, @replies]
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to @comment.blog
  end

  private

  def comment_params
    params.permit(:comment, :user_id)
  end
end
