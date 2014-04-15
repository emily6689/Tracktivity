class Log < ActiveRecord::Base
  validates :activity, presence: true
  validates :time_clocked_in, presence: true

  belongs_to :activity
  #belongs_to :user, through: :activity


  before_save :set_duration, if: Proc.new { |log| log.time_clocked_out.present? }



  def set_duration
    self.duration = calculate_duration
  end

  def calculate_duration
    hours   = (time_clocked_out.hour - time_clocked_in.hour)
    minutes = (time_clocked_out.min - time_clocked_in.min)
    (hours*60) + minutes
  end

  # class << self
  #   def incomplete
  #     where(time_clocked_out: nil)
  #   end
  # end

end
