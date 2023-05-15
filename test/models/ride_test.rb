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
require "test_helper"

class RideTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
