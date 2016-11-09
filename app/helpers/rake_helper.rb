module RakeHelper

  def data_import
    @games_array = ArrayGame.first
    #today = DateTime.new(2016, 10, 31)
    today = DateTime.now
    the_date = today.strftime('%Y%m%d').to_s
    games_array = []
    all_urls = []
    games_array = today(the_date)
    save_games_array(games_array) unless games_array == '[]'
    GameData.each do |url|
      all_urls << url.game_url_name
    end
    games_from_array(games_array,all_urls) unless games_array == '[]'
    team_stats
    p games_array
  end

  def today(the_date)
    auth = {:username => ENV['API_USER'], :password => ENV['API_PASS']}
    json_date = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/daily_game_schedule.json?fordate=#{the_date}",basic_auth: auth)
    daily = json_date['dailygameschedule']
    games_array = []
    unless daily['gameentry'].nil?
      daily['gameentry'].each do |this|
        year = this['date'].split('-').first
        month = this['date'].split('-').second
        day = this['date'].split('-').third
        team1 = this['awayTeam']['Abbreviation']
        team2 = this['homeTeam']['Abbreviation']
        games_array.push(year.to_s + month.to_s + day.to_s + '-' + team1 + '-' + team2)
      end
    end
    return games_array
  end

  def save_games_array(array)
    games_array = ArrayGame.first
    array.each do |game|
      unless games_array.game_url.include? game
        games_array.game_url.push(game)
      end
    end
    games_array.save
  end

  def games_from_array(array,url)
    array.each do |game_url|
      unless url.include? game_url
        p 'Scheduler included: ' + game_url
        auth = {:username => ENV['API_USER'], :password => ENV['API_PASS']}
        json = HTTParty.get("https://www.mysportsfeeds.com/api/feed/pull/nfl/2016-2017-regular/game_boxscore.json?gameid=#{game_url}",basic_auth: auth)
        games = json['gameboxscore']
        s_game_date = games['game']['date']
        s_game_time = games['game']['time']
        s_game_period = game_period(games['game']['time'])
        s_game_week_number = whats_the_week(s_game_date)
        s_home_team_abrev = games['game']['homeTeam']['Abbreviation']
        s_away_team_abrev = games['game']['awayTeam']['Abbreviation']
        s_home_team_complete = games['game']['homeTeam']['City'] + ' ' + games['game']['homeTeam']['Name']
        s_away_team_complete = games['game']['awayTeam']['City'] + ' ' + games['game']['awayTeam']['Name']
        s_home_team_score = games['quarterSummary']['quarterTotals']['homeScore'].to_i
        s_away_team_score = games['quarterSummary']['quarterTotals']['awayScore'].to_i
        s_quarter_count = games['quarterSummary']['quarter'].count
        s_winner_team = who_won(s_home_team_abrev,s_away_team_abrev,s_home_team_score,s_away_team_score)
        s_loser_team = who_lost(s_home_team_abrev,s_away_team_abrev,s_home_team_score,s_away_team_score)
        s_stats_interceptions = games['homeTeam']['homeTeamStats']['Interceptions']['#text'].to_i + games['awayTeam']['awayTeamStats']['Interceptions']['#text'].to_i
        s_stats_fumbles = games['homeTeam']['homeTeamStats']['Fumbles']['#text'].to_i + games['awayTeam']['awayTeamStats']['Fumbles']['#text'].to_i
        s_stats_home_team_downs = games['homeTeam']['homeTeamStats']['FirstDownsTotal']['#text'].to_i
        s_stats_away_team_downs = games['awayTeam']['awayTeamStats']['FirstDownsTotal']['#text'].to_i
        GameData.collection.insert_one({game_url_name: game_url, game_date: s_game_date, game_period: s_game_period,  game_time: s_game_time, game_week_number: s_game_week_number, home_team_abrev: s_home_team_abrev, away_team_abrev: s_away_team_abrev, home_team_complete: s_home_team_complete, away_team_complete: s_away_team_complete, home_team_score: s_home_team_score, away_team_score: s_away_team_score, quarter_count: s_quarter_count, winner_team: s_winner_team, loser_team: s_loser_team, stats_interceptions: s_stats_interceptions, stats_fumbles: s_stats_fumbles, stats_home_team_downs: s_stats_home_team_downs, stats_away_team_downs: s_stats_away_team_downs})
      end
    end
  end

  def team_stats
    GameData.each do |game|
      winner_team = game.winner_team
      loser_team = game.loser_team
      week = game.game_week_number.to_s
      unless winner_team.include? 'TIE'
        winning_team = TeamStats.find_by(team_abrev: winner_team)
        winning_team.stats[week.to_s] = 'W'
        winning_team.save
        loser_team = TeamStats.find_by(team_abrev: loser_team)
        loser_team.stats[week.to_s] = 'L'
        loser_team.save
      end
    end
  end

  def team_stats_backup
    p GameData.count
    GameData.each do |game|
      winner_team = game.winner_team
      loser_team = game.loser_team
      week = game.game_week_number.to_s
      if winner_team.count('TIE') == 0
        winning_team = TeamStats.find_by(team_abrev: winner_team)
        #p week.to_s + ': ' + winner_team
        #p winning_team.to_a
        #p winning_team.stats # {"1"=>"", "2"=>"", "3"=>""}
        #p winning_team.stats[week.to_s]
        # winning_team.stats['3'] = 'W'
        #p winning_team.stats
        value = winning_team.stats
        value[week.to_s] = 'W'
        winning_team.save
      end
      if loser_team.count('TIE') == 0
        loser_team = TeamStats.find_by(team_abrev: loser_team)
        loser_team.stats[week.to_s] = 'L'
        loser_team.save
      end
    end
  end

  def old_team_stats
    @team_array = ['CLE', 'TB', 'MIN', 'CIN', 'OAK', 'SD', 'MIA', 'NYG', 'DET', 'NE', 'PIT', 'LA', 'NYJ', 'CAR', 'GB', 'BUF', 'CHI', 'TEN', 'BAL', 'DAL', 'NO', 'SF', 'KC', 'SEA', 'JAX', 'ATL', 'IND', 'PHI', 'HOU', 'ARI', 'DEN', 'WAS']
    @hash = {}
    @team_array.each do |team|
      GameData.where(winner_team: team).each do |game|
        @hash[(game.game_week_number).to_i] = "W"
      end
      GameData.where(loser_team: team).each do |game|
        @hash[(game.game_week_number).to_i] = "L"
      end
      @selected_games = Hash[@hash.sort_by { |k, v| k }]
      TeamStats.collection.update_one({team_abrev: team}, '$set' => {:stats => @selected_games})

    end
  end

  def who_won(team1name,team2name,team1score,team2score)
    if team1score > team2score
      team1name
    elsif team1score < team2score
      team2name
    elsif team1score == team2score
      team1name + 'TIE'
    else
      'error'
    end
  end

  def who_lost(team1name,team2name,team1score,team2score)
    if team1score < team2score
      team1name
    elsif team1score > team2score
      team2name
    elsif team1score == team2score
      team2name + 'TIE'
    else
      'error'
    end
  end

  def game_period(time)
    if time.count('A') == 0
      'PM'
    else
      'AM'
    end
  end

  def whats_the_week(date)
    year = (date.split('-').first).to_i
    month = (date.split('-').second).to_i
    day = (date.split('-').third).to_i
    game_date = DateTime.new(year, month, day)
    b1,e1,b2,e2,b3,e3,b4,e4,b5,e5,b6,e6,b7,e7,b8,e8,b9,e9,b10,e10,b11,e11,b12,e12,b13,e13,b14,e14,b15,e15,b16,e16,b17,e17,b18,e18,b19,e19,b20,e20 = DateTime.new(2016, 9, 8),DateTime.new(2016, 9, 12),DateTime.new(2016, 9, 15),DateTime.new(2016, 9, 19), DateTime.new(2016, 9, 22), DateTime.new(2016, 9, 26), DateTime.new(2016, 9, 29), DateTime.new(2016, 10, 3), DateTime.new(2016, 10, 6), DateTime.new(2016, 10, 10), DateTime.new(2016, 10, 13),DateTime.new(2016, 10, 17), DateTime.new(2016, 10, 20), DateTime.new(2016, 10, 24), DateTime.new(2016, 10, 27), DateTime.new(2016, 10, 31), DateTime.new(2016, 11, 3), DateTime.new(2016, 11, 7),DateTime.new(2016, 11, 10), DateTime.new(2016, 11, 14), DateTime.new(2016, 11, 17), DateTime.new(2016, 11, 21), DateTime.new(2016, 11, 24), DateTime.new(2016, 11, 28), DateTime.new(2016, 12, 1), DateTime.new(2016, 12, 5), DateTime.new(2016, 12, 8), DateTime.new(2016, 12, 12), DateTime.new(2016, 12, 15), DateTime.new(2016, 12, 19), DateTime.new(2016, 12, 22), DateTime.new(2016, 12, 26),DateTime.new(2016, 12, 29), DateTime.new(2017, 1, 2), DateTime.new(2017, 1, 5), DateTime.new(2017, 1, 9), DateTime.new(2017, 1, 12), DateTime.new(2017, 1, 16), DateTime.new(2017, 1, 19), DateTime.new(2017, 1, 23)
    if game_date >= b1 && game_date <= e1
      1
    elsif game_date >= b2 && game_date <= e2
      2
    elsif game_date >= b3 && game_date <= e3
      3
    elsif game_date >= b4 && game_date <= e4
      4
    elsif game_date >= b5 && game_date <= e5
      5
    elsif game_date >= b6 && game_date <= e6
      6
    elsif game_date >= b7 && game_date <= e7
      7
    elsif game_date >= b8 && game_date <= e8
      8
    elsif game_date >= b9 && game_date <= e9
      9
    elsif game_date >= b10 && game_date <= e10
      10
    elsif game_date >= b11 && game_date <= e12
      11
    elsif game_date >= b12 && game_date <= e12
      12
    elsif game_date >= b13 && game_date <= e13
      13
    elsif game_date >= b14 && game_date <= e14
      14
    elsif game_date >= b15 && game_date <= e15
      15
    elsif game_date >= b16 && game_date <= e16
      16
    elsif game_date >= b17 && game_date <= e17
      17
    elsif game_date >= b18 && game_date <= e18
      18
    elsif game_date >= b19 && game_date <= e19
      19
    elsif game_date >= b20 && game_date <= e20
      20
    else
      'error'
    end
  end

end
