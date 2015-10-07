class HotelsController < ApplicationController
  layout 'hotels'
  #before_action :authenticate
  before_action :set_hotel, only: %w(import_akeruns)

  def import_akeruns
    @hotel.import_akeruns!(session[:access_token])
    redirect_to controller: "bookings", action: "index", hotel_id: @hotel.id
  end

  private
  def set_hotel
    @hotel = Hotel.find_by(id: params[:hotel_id])
  end
end
