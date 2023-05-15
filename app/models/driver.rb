# == Schema Information
#
# Table name: drivers
#
#  id                     :bigint           not null, primary key
#  availability           :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  license_number         :string
#  location               :point
#  name                   :string
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_drivers_on_email                 (email) UNIQUE
#  index_drivers_on_reset_password_token  (reset_password_token) UNIQUE
#
class Driver < ApplicationRecord
  # Concerens
  include Filterable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rides
  has_one :cab

  # Scopes
  scope :filter_by_ride_end_time, ->(end_time) { where(rides: { end_time: }).joins(:rides) }
  scope :filter_by_location, lambda { |location|
    longitude, latitude = location.split(',')
    where(Arel.sql(" ST_DWithin(location::geometry, ST_MakePoint(#{longitude.to_i},#{latitude.to_i}),  0.03 )"))
      .order(Arel.sql("location::geometry <-> ST_MakePoint(#{longitude.to_i},#{latitude.to_i})"))
  }
  scope :filter_by_availability, ->(availability) { where(availability:) }

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :license_number, presence: true

  def end_ride!
    # this method for end trip once user finalize his trip
    # and update end_time with current_time

    # first find ride
    ride = rides.where(end_time: nil).last
    ride&.update(end_time: Time.zone.now)
  end
end
