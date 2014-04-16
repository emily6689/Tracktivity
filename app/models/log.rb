class Log < ActiveRecord::Base
  validates :activity, presence: true
  validates :time_clocked_in, presence: true

  belongs_to :activity

  before_save :set_duration, if: Proc.new { |log| log.time_clocked_out.present? }

  def set_duration
    self.duration = calculate_duration
  end

  def calculate_duration
    hours   = (time_clocked_out.hour - time_clocked_in.hour)
    minutes = (time_clocked_out.min - time_clocked_in.min)
    (hours*60) + minutes
  end

  def date_parser(y, m, d)

  end

  class << self
    def sort_by_day(y, m, d)
      Log.all.select { |log| log.time_clocked_in.to_date == DateTime.new(y, m, d)}
    end

    def sort_by_week(y, m, d)
      sort_by_day(y, m, d)


    end
  end

end
