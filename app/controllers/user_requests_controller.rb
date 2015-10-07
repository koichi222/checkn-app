class UserRequestsController < ApplicationController
  layout 'hotels'
  #before_action :authenticate
  before_action :set_hotel
  before_action :set_user_request, only: [:show, :edit, :update, :destroy]

  # GET /user_requests
  # GET /user_requests.json
  def index
    @user_requests = UserRequest.all
  end

  # GET /user_requests/1
  # GET /user_requests/1.json
  def show
  end

  # GET /user_requests/new
  def new
    @booking = Booking.find_by(id: params[:booking_id])
    @user_request = UserRequest.new(booking_id: @booking.id)
  end

  # GET /user_requests/1/edit
  def edit
  end

  # POST /user_requests
  # POST /user_requests.json
  def create
    @booking = Booking.find_by(id: params[:booking_id])
    @user_request = UserRequest.new(user_request_params.merge(booking_id: @booking.id))

    if @user_request.save
      @user_request.send_request!(session[:access_token])
      redirect_to action: 'index', controller: 'bookings'
    else
      render action: 'edit'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user_request
    @user_request = UserRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_request_params
    params.require(:user_request).permit(:booking_key, :name, :hotel_id, :travel_agency_id, :email, :plan, :mail_note, :count, :date)
  end

  private
  def set_hotel
    @hotel = Hotel.find_by(id: params[:hotel_id])
  end

end
