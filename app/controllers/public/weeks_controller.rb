class Public::WeeksController < ApplicationController
  layout 'public'
  def index
    @json = ActiveSupport::JSON.decode(open("#{Rails.root}/file.json").read)
    @games = @json['scoreboard']['gameScore']
    #@json = ActiveSupport::JSON.decode(open("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=20160925").read)
    #FUNC auth = {:username => ENV['API_USER'], :password => ENV['API_PASS']}
    #FUNC @json = HTTParty.get('https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=20160925',basic_auth: auth)

    # json['data'].each do |element|
    #   element.each do |key, value|
    #     Model.create(date: key, number: value) # This Model is the name of your model
    #   end
    # end
  end
  def show
    # @array = ArrayGame.first
    # @games_array = @array.game_url
    @stats = GameData.where(game_week_number: params[:number])
    save_my_previous_url

    @user = current_user
    if current_user
      @team = current_user.user_team
      @algo = current_user.user_algo
      @hide = current_user.user_hide
    else
      @team = session[:user_team]
      @algo = session[:algo_choice]
      @hide = session[:hide_score_value]
    end

  end
  def save_my_previous_url
    #session[:my_previous_url] = URI(request.referer || '').path
    session[:my_previous_url] = URI(request.url || '').path
  end
end
