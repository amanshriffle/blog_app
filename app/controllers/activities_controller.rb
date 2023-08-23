class ActivitiesController < ApplicationController
  def blogs
    blogs = @current_user.blogs
    render json: blogs, include: [:user, :likes]
  end

  def likes
    likes = @current_user.liked_blogs
    render json: likes, include: [:user, :likes]
  end

  def comments
    comments = @current_user.comments
    render json: comments, include: :user
  end
end
