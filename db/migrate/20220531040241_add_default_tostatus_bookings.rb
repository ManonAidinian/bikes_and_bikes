class AddDefaultTostatusBookings < ActiveRecord::Migration[6.1]
  def change
    change_column :bookings, :status, :string, default: "pending"
  end
end
