class BikesController < ApplicationController

  def index
    @bikes = Bike.all
    @markers = @bikes.geocoded.map do |bike|
      {
        lat: bike.latitude,
        lng: bike.longitude
      }
    end
    if params[:query].present?
      @bikes = Bike.search_globally(params[:query])
    else
      @bikes = Bike.all
    end
  end

  def show
    @bike = Bike.find(params[:id])
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
