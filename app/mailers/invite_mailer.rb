class InviteMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invite_mailer.grant_account_permission.subject
  #
  def grant_account_permission(user,account)
    @email = user.email
    @account = account

    mail(to: @email, subject: "You have been granted access to an account on ScaleSimple")
  end
end
