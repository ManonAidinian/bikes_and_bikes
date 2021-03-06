class BikesController < ApplicationController

  def index
    if params[:query].present?
      @bikes = Bike.search_globally(params[:query])
    else
      @bikes = Bike.all
    end
    @markers = @bikes.geocoded.map do |bike|
      {
        lat: bike.latitude,
        lng: bike.longitude
      }
    end
  end

  def show
    @bike = Bike.find(params[:id])
    @bike_avg_rating = @bike.reviews.average(:bike_rating)
    @owner_avg_rating = @bike.reviews.average(:owner_rating)

    @booking = Booking.new()

    @marker = {
      lat: @bike.latitude || 0,
      lng: @bike.longitude || 0
      }
  end

  def new
    @bike = Bike.new
  end

  def create
    @bike = Bike.new(bike_params)
    @bike.user = current_user
    if @bike.save
      redirect_to bike_path(@bike)
    else
      render :new
    end
  end

  private

  def bike_params
  params.require(:bike).permit(:model, :description, :category, :location, :year, :mileage, :maker, :daily_price, pictures: [])
  end
end
