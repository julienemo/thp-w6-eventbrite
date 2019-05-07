class AttendanceMailer < ApplicationMailer
  default from: 'juliette.nada@gmail.com'

  def participation_confirmation(attendance)
    @attendance = attendance
    @user = User.find(@attendance.participant_id)
    @event = Event.find(@attendance.event_id)
    @url = "https://github.com/julienemo"
    # @url  = 'http://monsite.fr/login'
    mail(to: @user.email, subject: "You just registered for an event.")
  end

end
