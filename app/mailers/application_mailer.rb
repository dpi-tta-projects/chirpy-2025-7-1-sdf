class ApplicationMailer < ActionMailer::Base
  default from: "noreply@chirpy.com"
  default 'reply-to': "support@chirpy.com"
  layout "mailer"
end
