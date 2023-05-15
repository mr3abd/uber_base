# == Schema Information
#
# Table name: rides
#
#  id             :bigint           not null, primary key
#  end_location   :point
#  end_time       :datetime
#  start_location :point
#  start_time     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  driver_id      :bigint           not null
#  rider_id       :bigint           not null
#
# Indexes
#
#  index_rides_on_driver_id  (driver_id)
#  index_rides_on_rider_id   (rider_id)
#
# Foreign Keys
#
#  fk_rails_...  (driver_id => drivers.id)
#  fk_rails_...  (rider_id => riders.id)
#
class Ride < ApplicationRecord
  # Concerens
  include Filterable

  # Associate
  belongs_to :rider
  belongs_to :driver

  # Validation
  validates :start_location, presence: true
  validates :end_location, presence: true
  validates :start_time, presence: true
  before_validation :reject_rides_cases, on: :create

  after_create do
    driver.update(availability: false)
  end

  after_save do
    driver.update(availability: true) if end_location && end_time
  end

  def reject_rides_cases
    # purpose from this method to validate
    # for if Rider habe another Riders or no
    return unless rider.rides.find_by(end_time: nil)

    errors.add(:base, 'Cannot Accept this Ride as you have another Ride')
  end

  def distance
    (start_location.x - end_location.x)**2 + (start_location.y - end_location.y)**2
  end
end
