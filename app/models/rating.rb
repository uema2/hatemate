class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :anime
  
  validates :comment, length: { maximum: 30 }
end
