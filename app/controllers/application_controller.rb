class ApplicationController < ActionController::Base
  include Pagy::Backend
  respond_to :json
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found
  rescue_from ActionController::ParameterMissing, with: :params_missing
  rescue_from Pagy::OverflowError, with: :redirect_to_last_page

  def set_rider
    # this method just mock until handle quick auth from
    # https://github.com/waiting-for-dev/devise-jwt
    @rider ||= Rider.first
  end

  def set_driver
    # this method just mock until handle quick auth from
    # https://github.com/waiting-for-dev/devise-jwt
    @driver ||= Driver.first
  end

  protected

  def resource_not_found
    head(:not_found)
  end

  def params_missing(message)
    render json: { msg: message }, status: :bad_request
  end

  def pagination_params
    pagination_params = params.slice(:page, :per_page)
    { page: pagination_params[:page] || 1, per_page: pagination_params[:per_page] || 10 }
  end

  def redirect_to_last_page(exception)
    redirect_to url_for(page: exception.pagy.last),
                notice: "Page ##{params[:page]} is overflowing. Showing page #{exception.pagy.last} instead."
  end
end
