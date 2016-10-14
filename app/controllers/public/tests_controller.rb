class Public::TestsController < ApplicationController
  layout 'public'
  def index
    @json = ActiveSupport::JSON.decode(open("#{Rails.root}/file.json").read)
    @games = @json['scoreboard']['gameScore']
    #@json = ActiveSupport::JSON.decode(open("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=20160925").read)
    #FUNC auth = {:username => "pbyd", :password => "pbydpass"}
    #FUNC @json = HTTParty.get('https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=20160925',basic_auth: auth)

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
end
