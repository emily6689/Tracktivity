class Log < ActiveRecord::Base
  validates :activity_id, presence: true
  validates :time_clocked_in, presence: true
  validates :time_clocked_out, presence: true

  belongs_to :activity

  def time_spent
    hours   = (time_clocked_out.hour - time_clocked_in.hour)
    minutes = (time_clocked_out.hour - time_clocked_in.hour)
    (hours*60) + minutes
  end


end
