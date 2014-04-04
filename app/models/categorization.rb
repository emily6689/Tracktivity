class Categorization < ActiveRecord::Base
  validates :activity_id, presence: true
  validates :category_id, presence: true

  belongs_to :category
  belongs_to :activity
end
