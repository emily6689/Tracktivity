class Activity < ActiveRecord::Base
  validates :name, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :name, scope: :user_id


  belongs_to :user
  has_many :categorizations
  has_many :categories,
    through: :categorizations
  has_many :logs

  def incomplete_logs
    logs.where(time_clocked_out: nil)
  end


end
