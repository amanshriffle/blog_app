class BlogsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index show]
  skip_around_action :check_profile, except: :create

  load_and_authorize_resource

  def index
    blogs = Blog.visible
    render json: blogs, include: :user
  end

  def show
    render json: @blog
  end

  def create
    blog = current_user.blogs.build(blog_params)

    if blog.save
      render json: blog, status: :created, adapter: nil
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

    render json: @blog, status: :see_other
  end

  def user_blogs
    user = User.find_by!(username: params[:username])

    render json: user.blogs, adapter: nil if user.id == current_user.id
    render json: user.blogs.visible, adapter: nil
  end

  def search
    key = "%#{params[:key]}%"
    blogs = Blog.where("title LIKE :key OR body LIKE :key", { key: })

    render json: blogs
  end

  private

  def blog_params
    params.permit(:title, :body, :visible)
  end
end
