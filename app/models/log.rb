class Log < ActiveRecord::Base
  validates :activity, presence: true
  validates :time_clocked_in, presence: true

  belongs_to :activity
  has_many :categories, through: :activity

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
    def sort_by_week(date)
      Log.where(time_clocked_in: date.beginning_of_week..date.end_of_week)
    end

    def list_categories
      categories = Hash.new(0)
      logs = self.includes(:categories)
      logs.each do |log|
        log.categories.each do |category|
          categories[category.name] += (log.duration/60.0).round(2) if log.duration
        end
      end
      categories.each do |key, value|
        categories[key] = categories[key].round(2)
      end
      categories
    end

    def list_activities
      activities = Hash.new(0)
      logs = self.includes(:activity)
      logs.each do |log|
        activities[log.activity.name] += (log.duration/60.0).round(2) if log.duration
      end
      activities
    end

    def total_productivity
      productivity = {'Time Spent Clocked In' => 0, 'Time Spent Clocked Out'=> 112}
      Log.all.each do |log|
        productivity['Time Spent Clocked In'] += (log.duration/60.0)
        productivity['Time Spent Clocked Out'] -= (log.duration/60.0)
      end
      productivity['Time Spent Clocked In'] = productivity['Time Spent Clocked In'].round(2)
      productivity['Time Spent Clocked Out'] = productivity['Time Spent Clocked Out'].round(2)
      productivity
    end
  end
end

