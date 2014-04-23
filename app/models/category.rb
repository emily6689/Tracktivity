class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :categorizations
  has_many :activities,
    through: :categorizations
  has_many :logs,
    through: :activities
end


