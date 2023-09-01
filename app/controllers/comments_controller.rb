class CommentsController < ApplicationController
  skip_around_action :check_profile, except: :create
  load_and_authorize_resource except: :create
  include NotifyUser

  def show
    render layout: "card_to_show"
  end

  def create
    @comment = current_user.comments.build(comment_params)

    generate_notification if @comment.save

    redirect_to_comment_or_blog
  end

  def edit
    render layout: "card_for_form"
  end

  def update
    if @comment.update(comment_params)
      redirect_to_comment_or_blog
    else
      render :edit, layout: "card_for_form", status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to_comment_or_blog
  end

  private

  def comment_params
    params[:comment][:blog_id] = params[:blog_id] unless params[:_method]
    params.require(:comment).permit(:comment_text, :parent_comment_id, :blog_id)
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

  def redirect_to_comment_or_blog
    if @comment.parent_comment_id.nil?
      redirect_to blog_path(@comment.blog)
    else
      redirect_to comment_path(@comment.parent_comment)
    end
  end
end
