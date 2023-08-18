class BlogsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :likes, :show]
  before_action :set_blog, except: [:index, :create]
  before_action :check_blog_author, only: [:update, :destroy]

  def index
    @blogs = Blog.visible
    render json: @blogs
  end

  def show
    @comments = @blog.comments

    render json: [@blog, @comments.where(replied_on_comment_id: nil)]
  end

  def create
    @blog = @current_user.blogs.build(blog_params)

    if @blog.save
      render json: @blog, status: :created
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render json: @blog, status: :unprocessable_entity
    end
  end

  def destroy
    if @blog.user_id == @current_user.id
      @blog.destroy
      redirect_to blogs_url
    end
  end

  def like
    @blog.likes.create(user_id: @current_user.id)

    render json: @blog
  end

  def unlike
    @like = @blog.likes.find_by_user_id!(@current_user.id)
    @like.destroy

    render json: @blog
  end

  def likes
    @likes = @blog.like_by_users

    render json: @likes
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.permit(:title, :body, :visible)
  end

  def check_blog_author
    unless @blog.user_id == @current_user.id
      raise ActiveRecord::ReadOnlyError, "Only author can edit or delete the blog."
    end
  end
end
