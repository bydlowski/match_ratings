class Public::WeeksController < ApplicationController
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
  def one
    date1 = 20160908
    date2 = date1 + 3
    date3 = date2 + 1
    auth = {:username => "pbyd", :password => "pbydpass"}
    @json1 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date1}",basic_auth: auth)
    @games1 = @json1['scoreboard']['gameScore']
    @json2 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date2}",basic_auth: auth)
    @games2 = @json2['scoreboard']['gameScore']
    @json3 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date3}",basic_auth: auth)
    @games3 = @json3['scoreboard']['gameScore']
  end
  def two
    date1 = 20160915
    date2 = date1 + 3
    date3 = date2 + 1
    auth = {:username => "pbyd", :password => "pbydpass"}
    @json1 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date1}",basic_auth: auth)
    @games1 = @json1['scoreboard']['gameScore']
    @json2 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date2}",basic_auth: auth)
    @games2 = @json2['scoreboard']['gameScore']
    @json3 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date3}",basic_auth: auth)
    @games3 = @json3['scoreboard']['gameScore']
  end
  def three
    date1 = 20160922
    date2 = date1 + 3
    date3 = date2 + 1
    auth = {:username => "pbyd", :password => "pbydpass"}
    @json1 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date1}",basic_auth: auth)
    @games1 = @json1['scoreboard']['gameScore']
    @json2 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date2}",basic_auth: auth)
    @games2 = @json2['scoreboard']['gameScore']
    @json3 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date3}",basic_auth: auth)
    @games3 = @json3['scoreboard']['gameScore']
  end
  def four
    date1 = 20160929
    date2 = 20161002
    date3 = date2 + 1
    auth = {:username => "pbyd", :password => "pbydpass"}
    @json1 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date1}",basic_auth: auth)
    @games1 = @json1['scoreboard']['gameScore']
    @json2 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date2}",basic_auth: auth)
    @games2 = @json2['scoreboard']['gameScore']
    @json3 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date3}",basic_auth: auth)
    @games3 = @json3['scoreboard']['gameScore']
  end
  def five
    date1 = 20161006
    date2 = date1 + 3
    date3 = date2 + 1
    auth = {:username => "pbyd", :password => "pbydpass"}
    @json1 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date1}",basic_auth: auth)
    @games1 = @json1['scoreboard']['gameScore']
    @json2 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date2}",basic_auth: auth)
    @games2 = @json2['scoreboard']['gameScore']
    @json3 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date3}",basic_auth: auth)
    @games3 = @json3['scoreboard']['gameScore']
  end
  def six
    date1 = 20161013
    date2 = date1 + 3
    date3 = date2 + 1
    auth = {:username => "pbyd", :password => "pbydpass"}
    @json1 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date1}",basic_auth: auth)
    @games1 = @json1['scoreboard']['gameScore']
    @json2 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date2}",basic_auth: auth)
    @games2 = @json2['scoreboard']['gameScore']
    @json3 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date3}",basic_auth: auth)
    @games3 = @json3['scoreboard']['gameScore']
  end
  def seven
    date1 = 20161020
    date2 = date1 + 3
    date3 = date2 + 1
    auth = {:username => "pbyd", :password => "pbydpass"}
    @json1 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date1}",basic_auth: auth)
    @games1 = @json1['scoreboard']['gameScore']
    @json2 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date2}",basic_auth: auth)
    @games2 = @json2['scoreboard']['gameScore']
    @json3 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date3}",basic_auth: auth)
    @games3 = @json3['scoreboard']['gameScore']
  end
  def eight
    date1 = 20161027
    date2 = date1 + 3
    date3 = date2 + 1
    auth = {:username => "pbyd", :password => "pbydpass"}
    @json1 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date1}",basic_auth: auth)
    @games1 = @json1['scoreboard']['gameScore']
    @json2 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date2}",basic_auth: auth)
    @games2 = @json2['scoreboard']['gameScore']
    @json3 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date3}",basic_auth: auth)
    @games3 = @json3['scoreboard']['gameScore']
  end
  def nine
    date1 = 20161103
    date2 = date1 + 3
    date3 = date2 + 1
    auth = {:username => "pbyd", :password => "pbydpass"}
    @json1 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date1}",basic_auth: auth)
    @games1 = @json1['scoreboard']['gameScore']
    @json2 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date2}",basic_auth: auth)
    @games2 = @json2['scoreboard']['gameScore']
    @json3 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date3}",basic_auth: auth)
    @games3 = @json3['scoreboard']['gameScore']
  end
  def ten
    date1 = 20161110
    date2 = date1 + 3
    date3 = date2 + 1
    auth = {:username => "pbyd", :password => "pbydpass"}
    @json1 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date1}",basic_auth: auth)
    @games1 = @json1['scoreboard']['gameScore']
    @json2 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date2}",basic_auth: auth)
    @games2 = @json2['scoreboard']['gameScore']
    @json3 = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/scoreboard.json?fordate=#{date3}",basic_auth: auth)
    @games3 = @json3['scoreboard']['gameScore']
  end
end
