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
require "test_helper"

class CabTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
