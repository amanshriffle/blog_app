class CommentsController < ApplicationController
  skip_around_action :check_profile, except: :create
  load_and_authorize_resource except: :create
  include NotifyUser

  def index
    blog = Blog.find(params[:blog_id])
    comments = blog.comments

    render json: comments, include: :user
  end

  def show
    render json: @comment
  end

  def create
    @comment = current_user.comments.build(comment_params)

    generate_notification if @comment.save

    redirect_to blog_path(@comment.blog)
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

    redirect_to blog_path(@comment.blog)
  end

  private

  def comment_params
    params.permit(:comment_text, :parent_comment_id, :blog_id)
  end

  def generate_notification
    if @comment.parent_comment_id
      parent_comment = @comment.parent_comment
      notify_user("#{current_user.username} replied on your comment.", parent_comment.id, "Comment", parent_comment.user_id)
    else
      blog = @comment.blog
      notify_user("#{current_user.username} commented on your post (#{blog.title}).", blog.id, "Blog", blog.user_id)
    end
  end
end
