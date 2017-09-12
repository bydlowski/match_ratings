module GameScoreHelper

  # PROXIMOS PASSOS
  # Separar os arquivos de helper em relação ao que cada um faz
  # Pegar os jogos de hoje e dos dois ultimos dias e atualizar no banco de dados aqueles jogos
  # Arrumar o rake pra refletir iss
  # Verificar se deu pau pq tem um time novo
  #

  # https://api.mysportsfeeds.com/v1.1/sample/pull/nfl/2016-2017-regular/full_game_schedule.json?
  # https://api.mysportsfeeds.com/v1.1/pull/nfl/2017-2018-regular/full_game_schedule.json?
  # https://api.mysportsfeeds.com/v1.1/pull/nfl/2017-2018-regular/daily_game_schedule.json?fordate=20170907
  # https://api.mysportsfeeds.com/v1.1/pull/nfl/2017-regular/game_boxscore.json?gameid=20170907-KC-NE

  def save_game_scores

    log_day = AdminLogs.where(log_date: Date.today).first || AdminLogs.create(log_date: Date.today)

    p 'Checking if there were games today, yesterday or the day before'
    log_day.log_info  = log_day.log_info.to_s + 'Checking if there were games today, yesterday or the day before<br/>'
    log_day.save

    games = get_today_games
    if games.blank?
      p 'There were no games on the selected dates'
      log_day.log_info  = log_day.log_info.to_s + 'There were no games on the selected dates<br/>'
      log_day.save
    else
      p 'Number of games: ' + games.count.to_s
      log_day.log_info  = log_day.log_info.to_s + 'Number of games: ' + games.count.to_s + '<br/>'
      log_day.save
      # Passar os jogos encontrados na função para pegar os dados do json
      get_games_info(games,log_day)
      # Passar os jogos encontrados na função para pegar as informações de W/L
      # save_games_stats(games)
    end
  end

  def get_today_games
    today = (DateTime.now )
    yesterday = (DateTime.now - 1)
    before_yesterday = (DateTime.now - 2)
    before_before = (DateTime.now - 4)
    # Salvar data no formato correto
    formatted_today = today.strftime('%Y-%m-%d')
    formatted_yesterday = yesterday.strftime('%Y-%m-%d')
    formatted_before_yesterday = before_yesterday.strftime('%Y-%m-%d')
    f_before_before = before_before.strftime('%Y-%m-%d')
    # Pegar os GameData que tem a data de hoje, ontem e antontem
    games = GameData.where(:game_date.in => [formatted_today,formatted_yesterday,formatted_before_yesterday,f_before_before])
    return games
  end

  def get_games_info(games,log_day)
    p 'Getting games info in json'
    log_day.log_info  = log_day.log_info.to_s + 'Getting games info in json<br/>'
    log_day.save

    games.each do |gamedata|
      p 'Saving info for game ' + gamedata.game_url_name
      log_day.log_info  = log_day.log_info.to_s + 'Saving info for game ' + gamedata.game_url_name + '<br/>'
      log_day.save
      auth = {:username => ENV['API_USER'], :password => ENV['API_PASS']}
      game_json = HTTParty.get("https://api.mysportsfeeds.com/v1.1/pull/nfl/2017-regular/game_boxscore.json?gameid=#{gamedata.game_url_name}",basic_auth: auth)
      if (game_json['gameboxscore'])
        game_json_info = game_json['gameboxscore']
        gamedata.home_team_score = game_json_info['quarterSummary']['quarterTotals']['homeScore'].to_i
        gamedata.away_team_score = game_json_info['quarterSummary']['quarterTotals']['awayScore'].to_i
        gamedata.quarter_count = game_json_info['quarterSummary']['quarter'].count
        gamedata.stats_interceptions = game_json_info['homeTeam']['homeTeamStats']['Interceptions']['#text'].to_i + game_json_info['awayTeam']['awayTeamStats']['Interceptions']['#text'].to_i
        gamedata.stats_fumbles = game_json_info['homeTeam']['homeTeamStats']['Fumbles']['#text'].to_i + game_json_info['awayTeam']['awayTeamStats']['Fumbles']['#text'].to_i
        gamedata.stats_home_team_downs = game_json_info['homeTeam']['homeTeamStats']['FirstDownsTotal']['#text'].to_i
        gamedata.stats_away_team_downs = game_json_info['awayTeam']['awayTeamStats']['FirstDownsTotal']['#text'].to_i
        gamedata.lead_changes = lead_change(game_json_info['quarterSummary']['quarter'],gamedata.home_team_abrev,gamedata.away_team_abrev,'lead_changes')
        gamedata.lead_ties = lead_change(game_json_info['quarterSummary']['quarter'],gamedata.home_team_abrev,gamedata.away_team_abrev,'lead_ties')
        gamedata.save
      end
    end
  end

  def lead_change(game,home_team,away_team,var)
    home_score = 0
    away_score = 0
    lead_changes = 0
    lead_ties = 0
    game.each do |quarter|
      unless quarter['scoring'].nil?
        quarter['scoring']['scoringPlay'].each do |play|
          home_before = home_score
          away_before = away_score
          if play['teamAbbreviation'] == home_team
            if play['playDescription'].include? ('field goal is GOOD')
              home_score += 3
            elsif play['playDescription'].include? ('TOUCHDOWN')
              home_score += 6
            elsif play['playDescription'].include? ('extra point is GOOD')
              home_score += 1
            elsif play['playDescription'].include? ('SAFETY')
              home_score += 2
            elsif play['playDescription'].include? ('ATTEMPT SUCCEEDS')
              home_score += 2
            end
          end
          if play['teamAbbreviation'] == away_team
            if play['playDescription'].include? ('field goal is GOOD')
              away_score += 3
            elsif play['playDescription'].include? ('TOUCHDOWN')
              away_score += 6
            elsif play['playDescription'].include? ('extra point is GOOD')
              away_score += 1
            elsif play['playDescription'].include? ('SAFETY')
              away_score += 2
            elsif play['playDescription'].include? ('ATTEMPT SUCCEEDS')
              away_score += 2
            end
          end
          # Home team was winning
          if home_before > away_before
            if away_score > home_before
              lead_changes += 1
            elsif home_score.to_i == away_score.to_i && away_score != 0
              lead_ties += 1
            end
          # Away team was winning
          elsif  away_before > home_before
            if home_score > away_before
              lead_changes += 1
            elsif home_score.to_i == away_score.to_i && away_score != 0
              lead_ties += 1
            end
          end
        end
      end
    end
    if var == 'lead_changes'
      return lead_changes
    elsif var == 'lead_ties'
      return lead_ties
    end
  end

end
