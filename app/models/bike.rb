class Bike < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :pictures

  CATEGORY = ["scooter", "dirt-bike", "chopper", "sport", "naked", "other"]
  validates :model, :category, :location, :year, :mileage, :maker, :daily_price, :description, presence: true
  validates :category, inclusion: { in: CATEGORY }
end
