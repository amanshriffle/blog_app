class ActivitiesController < ApplicationController
  def blogs
    blogs = @current_user.blogs
    render json: blogs
  end

  def likes
    likes = @current_user.liked_blogs

    render json: likes
  end

  def comments
    comments = @current_user.comments

    render json: comments
  end
end
