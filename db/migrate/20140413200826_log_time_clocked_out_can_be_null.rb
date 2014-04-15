class LogTimeClockedOutCanBeNull < ActiveRecord::Migration
  def up
    change_column :logs, :time_clocked_out, :datetime, null: true
  end

  def down
    change_column :logs, :time_clocked_out, :datetime, null: false
  end
end
