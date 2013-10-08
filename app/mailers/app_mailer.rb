class AppMailer < ActionMailer::Base
  default from: "mpope.cr@gmail.com"

  def send_welcome_on_sign_up(user)
    @user = user

    mail to:      @user.email,
         subject: "Welcome to MyFlix!"
  end
end
