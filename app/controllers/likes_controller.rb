class LikesController < ApplicationController
  include NotifyUser
  skip_around_action :check_profile, except: :create
  before_action :set_blog

  def create
    like = @blog.likes.build(user_id: current_user.id)

    if like.save
      notify_user("#{current_user.username} liked on your post (#{@blog.title}).", like.blog_id, "Blog", @blog.user_id)
      redirect_to blog_path(@blog)
    else
      redirect_to blog_path(@blog), status: :forbidden
    end
  end

  def destroy
    like = @blog.likes.find_by!(user_id: current_user.id)
    authorize! :destroy, like
    like.destroy

    redirect_to blog_path(@blog)
  end

  private

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end
end
