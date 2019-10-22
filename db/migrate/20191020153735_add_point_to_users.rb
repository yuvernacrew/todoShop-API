class AddPointToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :point, :integer, null: false, default: 0
  end
end
