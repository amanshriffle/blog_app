class BlogMailer < ApplicationMailer
  def new_blog_email
    @user = params[:user]
    @blog = params[:blog]

    mail(bcc: @user.follower_users.pluck(:email), subject: "New Blog Posted by #{@user.username}.")
  end
end
