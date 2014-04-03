class AddUserIdAttrToActivity < ActiveRecord::Migration
  def up
    add_column :activities, :user_id, :integer, null: false
  end

  def down
    remove_column :activities, :user_id
  end
end
