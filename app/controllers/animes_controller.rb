class AnimesController < ApplicationController
  before_action :require_user_logged_in
  
  require 'json'
  require 'open-uri'
  
  def new
    @animes = []
    
    @keyword = params[:keyword]
    if @keyword.present?
      uri = URI('https://api.annict.com/v1/works')
      uri.query = {
        access_token: ENV['ANNICT_ACCESS_TOKEN'],
        filter_title: @keyword
      }.to_param
      
      results = JSON.parse open(uri).read, {symbolize_names: true}
      
      results[:works].each do |result|
        anime = Anime.find_or_initialize_by(read(result))
        @animes << anime
      end
      
      if results[:works].empty?
        flash.now[:danger] = "検索結果が得られませんでした。"
      end
    end
  end
  
  def show
    @anime = Anime.find(params[:id])
    @love_users = @anime.love_users
    @hate_users = @anime.hate_users
  end
  
  def season
    @animes = []
    
    uri = URI('https://api.annict.com/v1/works')
    uri.query = {
      access_token: ENV['ANNICT_ACCESS_TOKEN'],
      filter_season: '2019-winter',
      sort_watchers_count: 'desc',
      per_page: '50'
    }.to_param
    
    results = JSON.parse open(uri).read, {symbolize_names: true}
    
    results[:works].each do |result|
      anime = Anime.find_or_initialize_by(read(result))
      @animes << anime
    end   
    
  end
end
