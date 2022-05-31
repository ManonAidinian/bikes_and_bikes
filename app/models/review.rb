class Review < ApplicationRecord
  belongs_to :booking

  RATING = (0..10)
  validates :comment, :booking_rating, presence: true
  validates :bike_rating, :owner_rating, :booking_rating, inclusion: { in: RATING }
end
