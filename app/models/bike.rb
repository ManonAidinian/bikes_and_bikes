class Bike < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :pictures

  CATEGORIES = ["Scooter", "Dirt-bike", "Chopper", "Sport", "Naked", "Other"]
  validates :model, :category, :location, :year, :mileage, :maker, :daily_price, :description, presence: true
  validates :category, inclusion: { in: CATEGORIES }
end
