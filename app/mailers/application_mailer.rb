class ApplicationMailer < ActionMailer::Base
  default from: 'em.test.1@gmail.com'
  default reply_to: 'em.test.1@gmail.com'
  layout 'mailer'
end
