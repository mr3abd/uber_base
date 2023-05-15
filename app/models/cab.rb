# == Schema Information
#
# Table name: cabs
#
#  id            :bigint           not null, primary key
#  license_plate :string
#  location      :point
#  make          :string
#  model         :string
#  year          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  driver_id     :bigint           not null
#
# Indexes
#
#  index_cabs_on_driver_id  (driver_id)
#
# Foreign Keys
#
#  fk_rails_...  (driver_id => drivers.id)
#
class Cab < ApplicationRecord
  include Locationabel
  belongs_to :driver

  validates :driver, uniqueness: true
  validates :license_plate, presence: true
  validates :make, presence: true
  validates :model, presence: true
  validates :year, presence: true
end
