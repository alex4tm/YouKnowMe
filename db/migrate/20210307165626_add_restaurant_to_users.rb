class AddRestaurantToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :restaurant, index: true
    add_foreign_key :users, :restaurants
  end
end
