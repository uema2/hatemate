class Anime < ApplicationRecord
  validates :code, presence:true, length: { maximum: 255 }
  validates :title, presence:true, length: { maximum: 255 }
  validates :media, presence:true, length: { maximum: 255 }
  validates :season, presence:true, length: { maximum: 255 }
  validates :url, presence:true, length: { maximum: 255 }
  validates :image_url, presence:true, length: { maximum: 255 }
end
