class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
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
