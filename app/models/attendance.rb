class Attendance < ApplicationRecord
  after_create :send_confirmation
  validates_uniqueness_of :participant_id, :scope => [:event_id]
  validate :stripe_id_coherent?

  belongs_to :event

  belongs_to :participant,
    foreign_key: 'participant_id',
    class_name: "User"

  def send_confirmation
    AttendanceMailer.participation_confirmation(self).deliver_now
  end

  private
  def stripe_id_coherent?
    e_price = Event.find(event_id).price
    unless ((e_price == 0 && stripe_customer_id == nil)||(e_price !=0 && stripe_customer_id != nil))
      errors.add(:strip_customer_id, "can only be empt for free events.")
    end
  end
end
