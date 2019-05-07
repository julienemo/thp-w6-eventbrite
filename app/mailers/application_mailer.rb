class ApplicationMailer < ActionMailer::Base
  default :from     => 'notification@julievent.herokuapp.com',
          :reply_to => 'juliette.nada@gmail.com'
  layout 'mailer'
end
