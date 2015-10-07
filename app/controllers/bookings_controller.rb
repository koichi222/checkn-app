class BookingsController < ApplicationController
  layout 'hotels'
  before_action :set_hotel
  before_action :set_booking, only: [:show, :edit, :update, :cancel, :checkin, :checkout]

  def index
    @bookings = Booking.all.order("bookings.id DESC")

    @year, @month, @day = %w(year month day).map{|s| params[s]}
    if @year && @month && @day
      @date = Time.local(@year, @month, @day)
    else
      @date = Time.now
    end
    @ed = @date + 1.day
    @bookings = @bookings.where('NOT (? < checkin OR checkout < ?)', @ed, @date)
  end

  def new
    @booking = @hotel.bookings.new(checkin: Date.tomorrow+15.hours, checkout: Date.tomorrow+1.day+10.hours)
  end

  def create
    @booking = @hotel.bookings.new(booking_params.merge(status: 'no-guest-info'))
    if @booking.save
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

  def cancel
    @booking.checkout!(status: 'canceled', access_token: session[:access_token])
    redirect_to action: 'index'
  end

  def checkout
    @booking.checkout!(access_token: session[:access_token])
    redirect_to action: 'index'
  end

  def checkin
    @booking.checkin!(access_token: session[:access_token])
    redirect_to action: 'index'
  end

  def edit
    render action: 'edit'
  end

  def update
    unless params[:rooms].empty?
      @booking.rooms = @hotel.rooms.where(id: params[:rooms])
      if @booking.rooms.empty?
        @booking.status = 'not-assigned'
      elsif %w(not-assigned assigned checkedin key).include?(@booking.status)
        @booking.status = 'assigned'
      end
      @booking.save!
    end
    if params[:booking]
      @booking.update_attributes booking_params
    end
    redirect_to action: 'index'
  end

  private
  def set_hotel
    @hotel = Hotel.find_by(id: params[:hotel_id])
  end

  private
  def set_booking
    @booking = @hotel.bookings.find_by(id: params[:id])
  end

  def booking_params
    params.require(:booking).permit(:travel_agency_id, :plan, :checkin, :checkout, :no, :status, :agency_booking_key)
  end
end
