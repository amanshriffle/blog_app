class CommentsController < ApplicationController
  before_action :blog, only: [:index, :create]
  before_action :comment, only: [:show, :destroy, :update]

  def index
    @comment = @blog.comments.where(replied_on_comment_id: nil)

    render json: @comment
  end

  def show
    @replies = @comment.replies

    render json: [@comment, @replies]
  end

  def create
    params[:user_id] = @current_user.id
    params[:replied_on_comment_id] = params[:comment_id] unless params[:comment_id].nil?

    @comment = @blog.comments.create(comment_params)

    redirect_to @blog
  end

  def update
    unless @comment.user_id == @current_user.id
      render json: { error: "Only author can edit the comment." }, status: :unauthorized
      return nil
    end

    if @comment.update(comment_params)
      redirect_to @comment
    else
      render json: @comment, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.user_id == @current_user.id
      @comment.destroy
      redirect_to @comment.blog
    else
      render json: { error: "Only author can delete the comment." }, status: :unauthorized
    end
  end

  private

  def blog
    @blog = Blog.includes(:comments).find(params[:blog_id])
  end

  def comment
    @comment = Comment.includes(:replies).find(params[:id])
  end

  def comment_params
    params.permit(:comment, :replied_on_comment_id, :user_id)
  end
end
