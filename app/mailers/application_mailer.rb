class ApplicationMailer < ActionMailer::Base
  FROM_NAME = "Weavenote"
  default from: "\"#{FROM_NAME}\" <noreply@#{ENV['DOMAIN']}>"
  layout 'mailer'
end
