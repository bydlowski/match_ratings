class Public::TestsController < ApplicationController
  layout 'public'
  def index
    @json = ActiveSupport::JSON.decode(open("#{Rails.root}/file.json").read)
    @games = @json['scoreboard']['gameScore']
    #@json = ActiveSupport::JSON.decode(open("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=20160925").read)
    #FUNC auth = {:username => ENV['API_USER'], :password => ENV['API_PASS']}
    #FUNC @json = HTTParty.get('https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=20160925',basic_auth: auth)
    #FUNC @json2 = HTTParty.get('https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/daily_game_schedule.json?fordate=20160911',basic_auth: auth)
    # json['data'].each do |element|
    #   element.each do |key, value|
    #     Model.create(date: key, number: value) # This Model is the name of your model
    #   end
    # end
  end
  def stats
    @json = ActiveSupport::JSON.decode(open("#{Rails.root}/file.json").read)
  end
  def games
    @json = ActiveSupport::JSON.decode(open("#{Rails.root}/file.json").read)
    @games = @json['scoreboard']['gameScore']
  end
  def full
    @json = ActiveSupport::JSON.decode(open("#{Rails.root}/file2.json").read)
    #@json = ActiveSupport::JSON.decode(open("#{Rails.root}/overtime.json").read)
    @games = @json['gameboxscore']
    #json2 = ActiveSupport::JSON.decode(open("#{Rails.root}/daily.json").read)
    #daily = @json2['dailygameschedule']['gameentry']
    new_date = DateTime.new(2016, 9, 8)
    a = 1
    @all_dates = []
    loop do
      @all_dates << (new_date.strftime('%Y%m%d')).to_s
      new_date += 1
      a += 1
      break if a == 3
    end
    @date_array = []
    @all_dates.each do |all|
      auth = {:username => ENV['API_USER'], :password => ENV['API_PASS']}
      json2 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/daily_game_schedule.json?fordate=#{all}",basic_auth: auth)
      daily = json2['dailygameschedule']
      #@date_array << daily
      unless daily['gameentry'].nil?
        daily['gameentry'].each do |this|
          year = this['date'].split('-').first
          month = this['date'].split('-').second
          day = this['date'].split('-').third
          team1 = this['awayTeam']['Abbreviation']
          team2 = this['homeTeam']['Abbreviation']
          @date_array << year.to_s + month.to_s + day.to_s + '-' + team1 + '-' + team2
        end
      end
    end
    @all_games_array = []
  end
  def table
    @array = ArrayGame.first
    @games_array = @array.game_url
    @stats = GameData.all
  end
end
