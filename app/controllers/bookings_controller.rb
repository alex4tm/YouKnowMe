require 'twilio-ruby'

class BookingsController < ApplicationController
  before_action :set_restaurant, only: [:new, :create, :index, :available]


  def index
    authorize current_user
    # find the user based on the secure ID
    @bookings = policy_scope(Booking)
    authorize current_user
    if params[:search].present?
      @user = User.find_by(secure_id: params[:search])
      @error_message = "User Not Found" if @user.nil?
    end
  end

  def available
    @available = check_availability(params[:booking_search][:starts_at])

    @user = User.find_by(secure_id: params[:booking_search][:user])
    puts '-' * 20
    puts "USER ID - #{@user.secure_id}"
    @booking = Booking.new
    @start_date = params[:booking_search][:starts_at]
    authorize @booking
    if @available

      respond_to do |format|
        format.html { bookings_path }
        format.js
      end
    else
      flash.alert = "Date not available"
    end
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.restaurant = @restaurant
    @booking.user = User.find(params[:booking][:user])
    authorize @booking
    message = "#{@restaurant.name.capitalize} at #{@booking.start_date.strftime('%B %e at %l:%M %p')}"
    phone_number = "#{@booking.user.phone_number}"
    if @booking.save
      SmsConfirmationJob.perform_now(message, phone_number)
      redirect_to restaurants_path
    else
      flash.alert = "boking not saved"
      redirect_to restaurants_path
    end
  end

  private

  def check_availability(start_time)
    current_user.restaurant.tables_capacity > check_bookings(start_time).count
  end

  def check_bookings(start_time)
    @restaurant.bookings.where("start_date BETWEEN ? AND ?", start_time.to_datetime - 2.hours, start_time.to_datetime + 2.hours)

  end

  def set_restaurant
    @restaurant = current_user.restaurant
  end

  def booking_params
    params.require(:booking).permit(:notes, :start_date, :number_of_guests)
  end
end
