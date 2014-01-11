class Admin::UserMailer < ActionMailer::Base
  default from: $DEFAULT_EMAIL_FROM

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin.user_mailer.new_signup.subject
  #
  def new_signup(email)
    @email = email
    mail(to: $REGISTRATION_NOTIFIER_EMAIL, subject: "New User Registration Alert")
  end
  
end
