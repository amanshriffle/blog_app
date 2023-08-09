class RepliesController < ApplicationController
  def index
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.find(params[:comment_id])
    @replies = @comment.replies

    render json: @replies
  end
end
