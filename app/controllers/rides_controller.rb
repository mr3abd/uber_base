class RidesController < ApplicationController
  before_action :set_driver, only: %i[index end_ride]
  before_action :set_rider
  before_action :fetch_driver, only: :create
  def index
    # filter history for user with pagy
    pagy_option, rides = pagy(@rider.rides, page: pagination_params[:page],
                                            items: pagination_params[:per_page])
    rides_serializer = RideSerializer.new(rides).serializable_hash[:data]
    data = {
      data: rides_serializer,
      info: {
        page: pagy_option.page, next: pagy_option.next,
        items: pagy_option.items, pages: pagy_option.pages
      }
    }
    render json: data, status: :ok
  end

  def create
    # filter by nearby from user and create with first user
    # and make sure it's availble
    # make sure haven't rider else you
    # and get first then create Ride
    if @driver
      ride = @driver.rides.build(ride_create_params)
      render json: ride
    else
      render json: { msg: "Sorry we can't found Drvier" }
    end
  end

  def end_ride
    @driver.end_ride!
    head(:ok)
  end

  def ride_create_params
    params.require(:ride).permit(:start_time, :start_location,
                                 :end_location).merge({ ride: { rider: @rider, start_time: Time.now } })
  end

  def fetch_driver
    # filter by nearby from user and create with first user
    # and make sure it's availble
    # make sure haven't rider else you
    # and get first then create Ride
    filtering_params = {
      location: @rider.location,
      availability: true
    }
    @driver = Driver.filter(filtering_params).first
  end
end
