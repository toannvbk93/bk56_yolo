class AddPointToMembers < ActiveRecord::Migration
  def change
    add_column :members, :point, :int
  end
end
