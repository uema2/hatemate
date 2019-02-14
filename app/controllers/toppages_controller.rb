class ToppagesController < ApplicationController
  def index
    @animes = Anime.order('updated_at DESC')
  end

  def show
  end
end
