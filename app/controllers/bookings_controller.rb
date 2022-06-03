class BookingsController < ApplicationController

  def create
    @bike = Bike.find(params[:bike_id])

    @booking = Booking.new(booking_params)
    @booking.bike = @bike
    @booking.user = current_user
    @booking.status = 'pending'
    @booking.total_price = (@booking.end_date - @booking.start_date).to_i * @bike.daily_price
    if @booking.save
      regit push direct_to dashboard_path
    else
      render 'bikes/show'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price)
  end

end
