class Attendance < ApplicationRecord
  after_create :send_confirmation
  validates_uniqueness_of :participant_id, :scope => [:event_id]

  belongs_to :event

  belongs_to :participant,
    foreign_key: 'participant_id',
    class_name: "User"

  def send_confirmation
    AttendanceMailer.participation_confirmation(self).deliver_now
  end

end
