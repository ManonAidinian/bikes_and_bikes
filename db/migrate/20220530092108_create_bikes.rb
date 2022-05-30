class CreateBikes < ActiveRecord::Migration[6.1]
  def change
    create_table :bikes do |t|
      t.string :model
      t.string :category
      t.string :location
      t.float :latitude
      t.float :longitude
      t.integer :year
      t.integer :mileage
      t.string :maker
      t.boolean :available
      t.float :daily_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
