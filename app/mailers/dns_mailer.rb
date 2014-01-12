class DnsMailer < ActionMailer::Base
  default from: $DEFAULT_EMAIL_FROM

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.dns_mailer.hostname_active.subject
  #
  def hostname_active(email,hostname)
    @email = email
    @hostname = hostname.name

    mail(to: @email, subject: "ScaleSimple activation succeeded for #{@hostname}")
  end

  def hostname_created(email,hostname)
    @email = email
    @hostname = hostname.name

    mail(to: @email, subject: "#{@hostname} created on ScaleSimple network")
  end

end
