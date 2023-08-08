class RepliesController < ApplicationController
  def index
    @blog = Blog.find(param[:id])
    @comment = @blog.comments.find(param[:comment_id])
    @replies = @comment.replies

    render json: @replies
  end
end
