class ApplicationMailer < ActionMailer::Base
  FROM_NAME = "Weavenote"
  default from: "\"#{FROM_NAME}\" <noreply@#{ENV['WEAVENOTE__DOMAIN']}>"
  layout 'mailer'
end
