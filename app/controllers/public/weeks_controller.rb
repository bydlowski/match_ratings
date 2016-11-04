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
    @array = ArrayGame.first
    @games_array = @array.game_url
    @stats = GameData.where(game_week_number: params[:number])
  end
end
