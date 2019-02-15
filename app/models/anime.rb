class Anime < ApplicationRecord
  validates :code, presence:true, length: { maximum: 255 }
  validates :title, presence:true, length: { maximum: 255 }
  validates :media, length: { maximum: 255 }
  validates :season, length: { maximum: 255 }
  validates :url, length: { maximum: 255 }
  validates :image_url, length: { maximum: 255 }
  
  has_many :ratings
  has_many :users, through: :ratings
  has_many :loves, class_name: "Love"
  has_many :love_users, through: :loves, source: :user
  has_many :hates
  has_many :hate_users, through: :hates, source: :user
end
