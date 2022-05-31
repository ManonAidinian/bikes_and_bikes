class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.references :booking, null: false, foreign_key: true
      t.integer :bike_rating
      t.integer :owner_rating
      t.integer :booking_rating

      t.timestamps
    end
  end
end
