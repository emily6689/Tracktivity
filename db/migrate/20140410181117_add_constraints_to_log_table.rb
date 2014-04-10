class AddConstraintsToLogTable < ActiveRecord::Migration
  def change
    change_column :logs, :activity_id, :integer, null: false
    change_column :logs, :time_clocked_in, :datetime, null: false
    change_column :logs, :time_clocked_out, :datetime, null: false
  end
end
