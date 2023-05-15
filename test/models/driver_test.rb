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
require "test_helper"

class DriverTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
