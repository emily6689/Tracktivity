class Log < ActiveRecord::Base
  validates :activity_id, presence: true
  validates :time_clocked_in, presence: true
  validates :time_clocked_out, presence: true

  before_save :set_time_spent, if: Proc.new { |log| log.time_clocked_out.present? }

  belongs_to :activity

  def set_time_spent
    self.time_spent = individual_time_spent
  end

  def individual_time_spent
    hours   = (time_clocked_out.hour - time_clocked_in.hour)
    minutes = (time_clocked_out.minute - time_clocked_in.minute)
    (hours*60) + minutes
  end

end
