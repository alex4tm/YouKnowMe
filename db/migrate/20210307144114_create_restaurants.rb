class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.integer :tables_capacity
      t.string :category
      t.integer :rating

      t.timestamps
    end
  end
end
