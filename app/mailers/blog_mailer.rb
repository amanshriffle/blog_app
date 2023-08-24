class BlogMailer < ApplicationMailer
  def new_blog_email
    @user = params[:user]
    @blog = params[:blog]
    @follower_user = params[:follower_user]

    mail(to: @follower_user.email, subject: "New Blog Posted by #{@user.username}.")
  end
end
