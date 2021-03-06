class AppMailer < ActionMailer::Base
  default from: "mpope.cr@gmail.com"

  def friend_invite(user, invitation_message)
    @user = user
    @invitation_message = invitation_message

    mail to: @user.email,
         subject: "[MyFlix] You've been invited to join MyFlix!"
  end

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
