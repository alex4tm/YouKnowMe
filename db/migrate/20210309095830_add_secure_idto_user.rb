class AddSecureIdtoUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :secure_id, :string
  end
end
