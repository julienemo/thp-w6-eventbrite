class Event < ApplicationRecord
  validates :location, presence: true
  validates :title, presence: true, length: {in: 5..140}
  validates :description, presence: true, length:{in:20..1000}
  validates :price, inclusion:{in:1..1000}
  validate :duration_be_positive_and_multiple_of_5
  validate :cant_start_in_the_past

  belongs_to :admin,
    foreign_key: 'admin_id',
    class_name: "User"

  has_many :attendances,
    dependent: :destroy

  has_many :participants,
    through: :attendances,
    class_name: 'User'

  def duration_be_positive_and_multiple_of_5
    unless duration.present? && duration > 0 && duration % 5 ==0
      errors.add(:duration, "has to be positive and multiple of 5.")
    end
  end

  def cant_start_in_the_past
    unless start_time.present? && start_time > DateTime.now
      errors.add(:start_time, "must exist and can't be in the past")
    end
  end

  def end_time
    end_time = start_time + duration * 60
  end

end
