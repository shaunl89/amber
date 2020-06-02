class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.find(params[:room_id])
    @bookings = @room.bookings
  end

  def new
    @room = Room.find(params[:room_id])
    @booking = Booking.new
  end

  def create
    @room = Room.find(params[:room_id])
    booking_params = params.require(:booking).permit(:start, :end)
    booking_params[:room_id] = params[:room_id]
    booking_params[:user_id] = current_user.id
    @booking = Booking.new(booking_params)
    # binding.pry

    if @booking.save
      redirect_to room_bookings_path
    else 
      render 'new'
    end
  end

  def edit
    @room = Room.find(params[:room_id])
    @booking = Booking.find(params[:id])
  end

  def update
    begin
      booking = current_user.bookings.find(params[:id])
      booking_params = params.require(:booking).permit(:start, :end)
      booking.update(booking_params)
      flash[:notice] = 'Booking has been successfully updated'
      redirect_to room_bookings_path
    rescue
      flash[:alert] = 'Not allowed to delete a booking you did not make'
      redirect_to room_bookings_path
    end
  end

  def destroy
    begin
      booking = current_user.bookings.find(params[:id])
      booking.destroy
      flash[:notice] = 'Booking deleted'
      redirect_to room_bookings_path
    rescue
      flash[:alert] = 'Not allowed to delete a booking you did not make'
      redirect_to room_bookings_path
    end
  end

end
