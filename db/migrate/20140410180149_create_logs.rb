class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :activity_id
      t.datetime :time_clocked_in
      t.datetime :time_clocked_out

      t.timestamps
    end
  end
end
