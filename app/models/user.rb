class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :ratings
  has_many :animes, through: :ratings
  has_many :loves, class_name: "Love"
  has_many :love_animes, through: :loves, source: :anime
  has_many :hates
  has_many :hate_animes, through: :hates, source: :anime
  
  def love(anime, comment)
    self.loves.find_or_create_by(anime_id: anime.id, comment: comment)
  end
  
  def unlove(anime)
    love = self.loves.find_by(anime_id: anime.id)
    love.destroy if love
  end
  
  def love?(anime)
    self.love_animes.include?(anime)
  end
  
  def hate(anime, comment)
    self.hates.find_or_create_by(anime_id: anime.id, comment: comment)
  end
  
  def unhate(anime)
    hate = self.hates.find_by(anime_id: anime.id)
    hate.destroy if hate
  end
  
  def hate?(anime)
    self.hate_animes.include?(anime)
  end
end
