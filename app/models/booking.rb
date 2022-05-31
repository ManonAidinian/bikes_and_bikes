class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :bike

  STATUSES = ["pending", "accepted", "rejected"]
  validates :start_date, :end_date, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
end
