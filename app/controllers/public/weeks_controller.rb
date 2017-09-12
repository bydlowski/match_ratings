class Public::WeeksController < ApplicationController
  layout 'public'
  def index
  end
  def show
    # @array = ArrayGame.first
    # @games_array = @array.game_url
    @stats = GameData.where(game_week_number: params[:number])
    save_my_previous_url

  end
  def save_my_previous_url
    #session[:my_previous_url] = URI(request.referer || '').path
    session[:my_previous_url] = URI(request.url || '').path
  end
end
