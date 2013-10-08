class AppMailer < ActionMailer::Base
  default from: "mpope.cr@gmail.com"

  def send_welcome_on_sign_up(user)
    @user = user

    mail to:      @user.email,
         subject: "Welcome to MyFlix!"
  end

  def password_reset(user)
    @user = user

    mail to: @user.email,
         subject: "[MyFlix] Password reset"
  end
end
