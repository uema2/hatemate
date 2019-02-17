class RatingsController < ApplicationController
  
  require 'json'
  require 'open-uri'
  
  def create
    @anime = Anime.find_or_initialize_by(code: params[:anime_code])
    # binding.pry
    unless @anime.persisted?
    
      uri = URI('https://api.annict.com/v1/works')
      uri.query = {
        access_token: ENV['ANNICT_ACCESS_TOKEN'],
        filter_ids: @anime.code
      }.to_param
      
      results = JSON.parse open(uri).read, {symbolize_names: true}
      
      @anime = Anime.new(read(results[:works].first))
      @anime.save!
    end
    
    if params[:type] == 'Love'
      current_user.love(@anime, params[:comment])
    end
    
    if params[:type] == 'Hate'
      current_user.hate(@anime, params[:comment])
    end
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @anime = Anime.find(params[:anime_id])
    
    if params[:type] == 'Love'
      current_user.unlove(@anime)
    end
    
    if params[:type] == 'Hate'
      current_user.unhate(@anime)
    end
    
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    @rating = Rating.find(params[:id])
  end
  
  def update
    @rating.updete(params[:id])
  end
end
