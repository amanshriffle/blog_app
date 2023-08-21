class LikesController < ApplicationController
  before_action :set_blog
  include NotifyUser

  def blog_likes
    render json: @blog.likes_by
  end

  def create
    like = @blog.likes.build(user_id: @current_user.id)

    if like.save
      notify_user("#{@current_user.username} liked on your post (#{@blog.title}).", like.blog_id, "Blog", @blog.user_id)
      render json: like, status: :created
    else
      render json: like.errors, status: 422
    end
  end

  def destroy
    like = @blog.likes.find_by_user_id!(@current_user.id)
    like.destroy

    render json: like
  end

  private

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end
end
