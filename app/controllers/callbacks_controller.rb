class CallbacksController < ApplicationController
  before_action :set_access_token

  # POST /akerun/callback/bookings/:booking_id/registered
  def registered
    ur = UserRequest.find_by(key: params[:booking_id])
    if ur
      guest = Guest.find_or_create_by(akerun_user_key: params[:user_id])
      ur.register(guest, @access_token)

      render json: {
        success: true,
        url: ur.guest_info_url
      }
    else
      render json: {
        success: true
      }
    end
  end

  # POST /akerun/callback/touchpoints/:device_id
  def touchpoint
    hotel = Hotel.find_by(akerun_hotel_key: params[:hotel_id])

    tp = TouchPoint.find_by(akerun_key: params[:device_id], hotel_id: hotel.id)
    raise "Unknow touchpoint" unless tp

    guest = Guest.find_by(akerun_user_key: params[:user_id])
    raise "Unknow user" unless guest

    if tp.device_type == 'checkin'
      booking = hotel.bookings.find_by(guest_id: guest.id, status: ["checkedin","assigned"])
      raise "They don't have a booking" unless booking
      raise "Can't check in yet" unless booking.can_checkin?
      booking.checkin!(access_token: @access_token)
    else
      booking = hotel.bookings.find_by(guest_id: guest.id, status: ["checkedin"])
      raise "They don't have a booking" unless booking
      raise "Can't check out yet" unless booking.can_checkout?
      booking.checkout!(access_token: @access_token)
    end

    render json: {
      success: true,
      booking_id: booking.id,
      rooms: booking.rooms.map(&:name),
      url: "https://www.google.com/"
    }
  rescue RuntimeError => e
    logger.error "callback error: #{e.to_s}"
    render json: {
      success: false,
      message: e.to_s
    }
  end

  # POST /akerun/callback/users/:user_id/opened/:device_id
  def opened_akerun
    render json: {
      success: true
    }
  end

  # POST /akerun/callback/akeruns/:akerun_device_id
  def registered_akerun
    hotel = Hotel.find_by(akerun_hotel_key: params[:hotel_id])
    hotel.import_akeruns!(@access_token)

    render json: {
      success: true
    }
  rescue RuntimeError => e
    render json: {
      success: false,
      message: e.to_s
    }
  end

  private

  def set_access_token
    access_token = AccessToken.first
    @access_token = access_token.token
  end
end
