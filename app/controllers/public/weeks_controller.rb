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
  def one
    @array = ArrayGame.first
    @games_array = @array.game_url
    @stats = GameData.where(game_week_number: 1)
  end
  def two
    @array = ArrayGame.first
    @games_array = @array.game_url
    @stats = GameData.where(game_week_number: 2)
  end
  def three
    @array = ArrayGame.first
    @games_array = @array.game_url
    @stats = GameData.where(game_week_number: 3)
  end
  def four
    @array = ArrayGame.first
    @games_array = @array.game_url
    @stats = GameData.where(game_week_number: 4)
  end
  def five
    @array = ArrayGame.first
    @games_array = @array.game_url
    @stats = GameData.where(game_week_number: 5)
  end
  def six
    @array = ArrayGame.first
    @games_array = @array.game_url
    @stats = GameData.where(game_week_number: 6)
  end
  def seven
    @array = ArrayGame.first
    @games_array = @array.game_url
    @stats = GameData.where(game_week_number: 7)
  end
  def eight
    @array = ArrayGame.first
    @games_array = @array.game_url
    @stats = GameData.where(game_week_number: 8)
  end
  def nine
    @array = ArrayGame.first
    @games_array = @array.game_url
    @stats = GameData.where(game_week_number: 9)
  end
  def ten
    @array = ArrayGame.first
    @games_array = @array.game_url
    @stats = GameData.where(game_week_number: 10)
  end
end
