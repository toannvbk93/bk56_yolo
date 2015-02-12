class AddIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :id, :int
  end
end
