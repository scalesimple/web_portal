class RulesetMailer < ActionMailer::Base
  default from: "noreply@scalesimple.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ruleset_mailer.ruleset_active.subject
  #
  def ruleset_active(email,ruleset)
    @email = email
    @ruleset = ruleset

    mail(to: @email, subject: "Ruleset activation notification")
  end
end
