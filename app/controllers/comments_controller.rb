class CommentsController < ApplicationController
  include NotifyUser

  before_action :set_comment, only: [:destroy, :update]
  before_action :check_comment_author, only: [:update, :destroy]

  def index
    blog = Blog.find(params[:blog_id])
    comments = blog.comments

    render json: comments, adapter: nil
  end

  def show
    comment = Comment.find(params[:id])
    render json: comment
  end

  def create
    params[:parent_comment_id] = params[:comment_id] if params[:comment_id]

    @comment = @current_user.comments.build(comment_params)

    if @comment.save
      generate_notification

      render json: @comment, status: :created
    else
      render json: @comment.errors, status: 422
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy

    render json: @comment
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.permit(:comment_text, :parent_comment_id, :blog_id)
  end

  def check_comment_author
    unless @comment.user_id == @current_user.id
      raise ActiveRecord::ReadOnlyError, "Only author can edit or delete the comment."
    end
  end

  def generate_notification
    if @comment.parent_comment_id
      parent_comment = @comment.parent_comment
      notify_user("#{@current_user.username} replied on your comment.", parent_comment.id, "Comment", parent_comment.user_id)
    else
      blog = @comment.blog
      notify_user("#{@current_user.username} commented on your post (#{blog.title}).", blog.id, "Blog", blog.user_id)
    end
  end
end
