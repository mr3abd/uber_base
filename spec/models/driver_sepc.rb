require 'rails_helper'

RSpec.describe Driver, type: :model do
  let(:driver) { FactoryBot.create(:driver) }

  describe 'associations' do
    it { should have_many(:rides) }
    it { should have_one(:cab) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:license_number) }
  end
  describe '#name' do
    it 'should be present' do
      driver = Driver.new(name: '')
      expect(driver).to be_invalid
    end

    it 'should be unique' do
      driver1 = Driver.create(name: 'John Doe')
      driver2 = Driver.new(name: 'John Doe')
      expect(driver2).to be_invalid
    end
  end

  describe '#phone_number' do
    it 'should be present' do
      driver = Driver.new(phone_number: '')
      expect(driver).to be_invalid
    end

    it 'should be a valid phone number' do
      driver = Driver.new(phone_number: '1234567890123456')
      expect(driver).to be_invalid
    end
  end

  describe '#email' do
    it 'should be present' do
      driver = Driver.new(email: '')
      expect(driver).to be_invalid
    end
  end

  # describe '#end_ride!' do
  #   it 'should update the end_time of the last ride' do
  #     ride = driver.rides.create!

  #     driver.end_ride!

  #     expect(ride.end_time).to be_present
  #   end

  #   it 'should not update the end_time of a ride that has already ended' do
  #     driver = Driver.create!
  #     ride = driver.rides.create!(end_time: Time.zone.now)

  #     driver.end_ride!

  #     expect(ride.end_time).to eq(Time.zone.now)
  #   end
  # end

  describe 'factories' do
    it 'should create a valid driver' do
      driver = FactoryBot.create(:driver)
      expect(driver).to be_valid
    end

    it 'should create a driver with all required attributes' do
      driver = FactoryBot.create(:driver)
      expect(driver.name).to be_present
      expect(driver.phone_number).to be_present
      expect(driver.license_number).to be_present
      expect(driver.email).to be_present
    end
  end
end
