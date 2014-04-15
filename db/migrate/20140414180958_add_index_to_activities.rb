class AddIndexToActivities < ActiveRecord::Migration
  def up
    add_index :activities, [:name, :user_id], unique: true
  end

  def down
    remove_index :activities, [:name, :user_id]
  end
end
