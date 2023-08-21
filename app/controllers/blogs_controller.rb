class BlogsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :set_blog, only: [:update, :destroy]
  before_action :check_blog_author, only: [:update, :destroy]

  def index
    blogs = Blog.visible
    render json: blogs
  end

  def show
    blog = Blog.includes(:comments).where("comments.parent_comment_id" => nil).find(params[:id])
    comments = blog.comments

    render json: [blog, comments]
  end

  def create
    blog = @current_user.blogs.build(blog_params)

    if blog.save
      render json: blog, status: :created
    else
      render json: blog.errors, status: :unprocessable_entity
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @blog.destroy
    redirect_to activity_blogs_path
  end

  def user_blogs
    user = User.find_by_username!(params[:username])

    render json: user.blogs if user.id == @current_user.id
    render json: user.blogs.visible
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
