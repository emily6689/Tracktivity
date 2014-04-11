class Activity < ActiveRecord::Base
  validates :name, presence: true
  validates :user_id, presence: true


  belongs_to :user
  has_many :categorizations
  has_many :categories,
    through: :categorizations
  has_many :logs


end
