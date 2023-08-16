class BlogsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :likes, :show]

  def index
    @blogs = Blog.visible
    render json: @blogs
  end

  def show
    @blog = Blog.find(params[:id])&.includes(:comments)&.where("comments.replied_on" => nil)

    @comments = @blog.comments
    render json: [@blog, @comments]
  end

  def create
    @blog = Blog.new(blog_params)
    return render json: @blog, status: :created if @blog.save

    render json: @blog.errors, status: :unprocessable_entity
  end

  def update
    @blog = Blog.find(params[:id])

    if @blog.update(blog_params)
      redirect_to @blog
    else
      render @blog, status: :unprocessable_entity
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    redirect_to blogs_url
  end

  def like
    @blog = Blog.find(params[:blog_id])
    @like = @blog.likes.create(user_id: @current_user.id)

    redirect_to @blog
  end

  def unlike
    @blog = Blog.find(params[:blog_id])
    @like = @blog.likes.find_by_user_id(params[:user_id])

    @like.destroy

    redirect_to @blog
  end

  def likes
    @blog = Blog.find(params[:blog_id])
    @like = @blog.like_by_users

    render json: @like
  end

  private

  def blog_params
    params[:title] = params[:title]&.titleize
    params[:body] = params[:body]&.capitalize

    params.permit(:title, :body, :visible, :user_id)
  end
end
