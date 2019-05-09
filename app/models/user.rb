class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :send_welcome

  has_one_attached :avatar

  has_many :managed_events,
    foreign_key: 'admin_id',
    class_name: "Event",
    dependent: :destroy

  has_many :attendances,
    foreign_key: 'participant_id'

  has_many :participants,
    foreign_key: 'participant_id',
    through: :managed_events,
    class_name: 'User',
    dependent: :destroy

  def send_welcome
    UserMailer.welcome_email(self).deliver_now
  end

end
