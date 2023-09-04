class BlogsController < ApplicationController
  skip_around_action :check_profile, except: [:create, :new]
  load_and_authorize_resource except: %i[new create search]
  layout "card_for_form", only: %i[new edit create update]

  def index
    @blogs = Blog.includes(:user).visible.page(params[:page])

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @blogs, include: :user }
    end
  end

  def show
    @comments = @blog.comments.includes(user: :profile)
    respond_to do |format|
      format.html { render layout: "card_to_show" }
      format.json { render json: @blog }
    end
  end

  def new
    @blog = Blog.new
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def create
    @blog = current_user.blogs.build(blog_params)

    if @blog.save
      redirect_to blog_path(@blog)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog.destroy

    redirect_to blogs_path
  end

  def search
    key = "%#{params[:key]}%"
    if params[:option] == "Blog"
      @blogs = Blog.where("title LIKE :key OR body LIKE :key", { key: }).page(params[:page])
      render "index"
    else
      @profiles = Profile.completed.select("users.username, profiles.*").joins(:user).where("users.username LIKE :key OR first_name LIKE :key OR last_name LIKE :key", { key: })
      render "profiles/search_result", layout: "card_for_list"
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body, :visible, pictures: [])
  end
end
