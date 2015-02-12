class AddPointToUsers < ActiveRecord::Migration
  def change
    add_column :users, :point, :int
  end
end
