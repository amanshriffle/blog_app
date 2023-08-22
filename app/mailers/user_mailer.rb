class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @profile = params[:profile]

    mail(to: @user.email, subject: "Welcome to Our Awesome Site")
  end
end
