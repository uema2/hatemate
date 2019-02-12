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
        anime = Anime.new(read(result))
        @animes << anime
      end   
    end
  end
  
  private  
  
  def read(result)
    code = result[:id]
    title = result[:title]
    media = result[:media_text]
    season = result[:season_name_text]
    url = result[:official_site_url]
    image_url = result[:images][:recommended_url]
    
    
    {
      code: code,
      title: title,
      media: media,
      season: season,
      url: url,
      image_url: image_url,
    }
  end
end
