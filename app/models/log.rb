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

  class << self
    def sort_by_day(y, m, d)
      date = Date.new(y,m,d)
      Log.where(time_clocked_in: date.beginning_of_day..date.end_of_day)
    end

    def sort_by_week(date)
      Log.where(time_clocked_in: date.beginning_of_week..date.end_of_week)
    end

    def sort_by_month(y, m)
      date = Date.new(y, m)
      Log.where(time_clocked_in: date.beginning_of_month..date.end_of_month)
    end

    def search(params)
      binding.pry
    end
  end
end

