class Attendance < ApplicationRecord
  after_create :send_confirmation
  validates_uniqueness_of :participant_id, :scope => [:event_id]
  validate :stripe_id_coherent?
  validate :admin_cant_participate

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

  def admin_cant_participate
    e_admin = Event.find(event_id).admin_id
    if e_admin == participant_id
      errors.add(:participant_id, "Admin can't participate in own event.")
    end
  end
end
