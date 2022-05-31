class AddDescToBikes < ActiveRecord::Migration[6.1]
  def change
    add_column :bikes, :description, :text
  end
end
