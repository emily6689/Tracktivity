class Log < ActiveRecord::Base
  validates :activity_id, presence: true
  validates :time_clocked_in, presence: true
  validates :time_clocked_out, presence: true

  belongs_to :activity
end
