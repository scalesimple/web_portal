class Admin::UserMailer < ActionMailer::Base
  default from: "noreply@scalesimple.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin.user_mailer.new_signup.subject
  #
  def new_signup(email)
    @email = email
    mail(to: "registrations@scalesimple.com", subject: "New User Registration Alert")
  end
  
end
