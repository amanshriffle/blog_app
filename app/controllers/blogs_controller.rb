class BlogsController < ApplicationController
  def index
    @blogs = Blog.visible
    render json: @blogs
  end

  def show
    @blog = Blog.find(params[:id])
    @comments = @blog.comments.where(replied_on: nil)
    render json: [@blog, @comments]
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    render json: @blog if @blog.save

    render json: @blog.errors.full_messages
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
  end

  private def blog_params
    params[:title] = params[:title].titleize
    params[:body] = params[:body].capitalize

    params.permit(:title, :body, :visible, :user_id)
  end
end
