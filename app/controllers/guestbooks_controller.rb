class GuestbooksController < ApplicationController
  layout 'guestbooks'
  before_action :set_booking

  def new
    @guest_info = @booking.guest.guest_infos.new
  end

  def create
    @guest_info = @booking.guest.guest_infos.new(guest_info_params)

    if @guest_info.save
      @booking.update_attributes guest_info_id: @guest_info.id, status: "not-assigned"
      redirect_to 'akerun://webview/close'
    else
      render :new
    end
  end

  private
  def guest_info_params
    params.require(:guest_info).permit(:name, :zip, :address1, :address2, :phone, :sex, :email)
  end

  private
  def set_booking
    @booking = Booking.find_by(key: params[:booking_id])
  end
end
