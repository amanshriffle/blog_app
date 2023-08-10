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
    return render json: @blog if @blog.save

    render json: @blog.errors.full_messages, status: :expectation_failed
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

  def like
    @blog = Blog.find(params[:blog_id])
    @like = @blog.likes.create(user_id: params[:user_id])

    redirect_to @blog
  end

  def unlike
    @blog = Blog.find(params[:blog_id])
    @like = @blog.likes.find_by(user_id: params[:user_id])

    @like.destroy

    redirect_to @blog
  end

  def likes
    @blog = Blog.find(params[:blog_id])
    @like = @blog.like_by_users

    render json: @like
  end

  private def blog_params
    params[:title] = params[:title].titleize unless params[:title].nil?
    params[:body] = params[:body].capitalize unless params[:body].nil?

    params.permit(:title, :body, :visible, :user_id)
  end
end
