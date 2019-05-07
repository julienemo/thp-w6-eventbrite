class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url = "https://julievent.herokuapp.com"
    # @url  = 'http://monsite.fr/login'
    mail(to: @user.email, subject: "Welcome to Julie'event!")
  end

end
