module ScheduleHelper

  def check_if_full_game_schedule_changed

    log_day = AdminLogs.where(log_date: Date.today).first || AdminLogs.create(log_date: Date.today)
    log_day.log_info  = ''
    log_day.save

    p 'Connecting to the API'
    log_day.log_info  = log_day.log_info.to_s + 'Connecting to the API<br/>'
    log_day.save

    # Essa parte serve para ver o json com as datas de todos os jogos da temporada
    # e, caso algum jogo tenha mudado de data, atualizar isso no banco de dados

    require 'fileutils'
    auth = {:username => ENV['API_USER'], :password => ENV['API_PASS']}
    original_file = 'public/json/full_schedule.json'
    temporary_file  = 'public/json/temporary_json.json'

    online_json_1 = HTTParty.get("https://api.mysportsfeeds.com/v1.1/pull/nfl/2017-2018-regular/full_game_schedule.json",basic_auth: auth)
    online_json_2 = HTTParty.get("https://api.mysportsfeeds.com/v1.1/pull/nfl/2017-regular/full_game_schedule.json",basic_auth: auth)
    online_json_3 = HTTParty.get("https://api.mysportsfeeds.com/v1.1/pull/nfl/2018-playoff/full_game_schedule.json",basic_auth: auth)

    if (online_json_1['fullgameschedule'])
    #   online_json = online_json_1
    #   p 'Creating temporary json'
    #   log_day.log_info  = log_day.log_info.to_s + 'Creating temporary json (1)<br/>'
    #   log_day.save

    #   File.open(temporary_file, "w+") do |f|
    #     f.write(online_json)
    #   end

    # elsif (online_json_2['fullgameschedule'])
    #   online_json = online_json_2
    #   p 'Creating temporary json'
    #   log_day.log_info  = log_day.log_info.to_s + 'Creating temporary json (2)<br/>'
    #   log_day.save

    #   File.open(temporary_file, "w+") do |f|
    #     f.write(online_json)
    #   end

    # elsif (online_json_3['fullgameschedule'])
      online_json = online_json_3
      p 'Creating temporary json'
      log_day.log_info  = log_day.log_info.to_s + 'Creating temporary json (3)<br/>'
      log_day.save

      File.open(temporary_file, "w+") do |f|
        f.write(online_json)
      end

    else
      p 'Could not get schedule from API'
      log_day.log_info  = log_day.log_info.to_s + 'Could not get schedule from API<br/>'
      log_day.save
      return false
    end

    p 'Checking if schedule changed'
    log_day.log_info  = log_day.log_info.to_s + 'Checking if schedule changed<br/>'
    log_day.save

    scheduled_not_changed = FileUtils.compare_file(original_file,temporary_file)

    if scheduled_not_changed
      p 'Schedule has not changed'
      log_day.log_info  = log_day.log_info.to_s + 'Schedule has not changed<br/>'
      log_day.save
    else
      p 'Schedule HAS changed'
      log_day.log_info  = log_day.log_info.to_s + 'Schedule HAS changed<br/>'
      log_day.save

      p 'Overwriting old schedule with new one'
      log_day.log_info  = log_day.log_info.to_s + 'Overwriting old schedule with new one<br/>'
      log_day.save

      File.open(original_file, "w+") do |f|
        f.write(online_json)
      end

      p 'Rewriting the schedule information for each game'
      log_day.log_info  = log_day.log_info.to_s + 'Rewriting the schedule information for each game<br/>'
      log_day.save

      online_json['fullgameschedule']['gameentry'].each do |game|
        year = game['date'].split('-').first
        month = game['date'].split('-').second
        day = game['date'].split('-').third
        team1 = game['awayTeam']['Abbreviation']
        team2 = game['homeTeam']['Abbreviation']
        url_name = year.to_s + month.to_s + day.to_s + '-' + team1 + '-' + team2
        game_data = GameData.where(game_url_name: url_name).first || GameData.create(game_url_name: url_name)
        game_data.game_url_name = url_name
        game_data.game_date = game['date']
        game_data.game_time = game['time']
        game_data.game_period = game_period(game['time'])
        game_data.game_week_number = whats_the_week(game['date'])
        game_data.home_team_abrev = game['homeTeam']['Abbreviation']
        game_data.away_team_abrev = game['awayTeam']['Abbreviation']
        game_data.home_team_complete = game['homeTeam']['City'] + ' ' + game['homeTeam']['Name']
        game_data.away_team_complete = game['awayTeam']['City'] + ' ' + game['awayTeam']['Name']

        # game_data.update(
        #   game_url_name: url_name,
        #   game_date: game['date'],
        #   game_time: game['time'],
        #   game_period: game_period(game['time']),
        #   game_week_number: whats_the_week(game['date']),
        #   home_team_abrev: game['homeTeam']['Abbreviation'],
        #   away_team_abrev: game['awayTeam']['Abbreviation'],
        #   home_team_complete: game['homeTeam']['City'] + ' ' + game['homeTeam']['Name'],
        #   away_team_complete: game['awayTeam']['City'] + ' ' + game['awayTeam']['Name']
        #   )

        game_data.save
      end

      p 'Finished rewriting the schedule information for each game'
      log_day.log_info  = log_day.log_info.to_s + 'Finished rewriting the schedule information for each game<br/>'
      log_day.save
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
    week_begin = DateTime.new(2017, 9, 7)
    week_end = DateTime.new(2017, 9, 13)
    if game_date < week_begin
      0
    elsif game_date >= week_begin && game_date <= week_end
      1
    elsif game_date >= (week_begin + (7*1)) && game_date <= (week_end + (7*1))
      2
    elsif game_date >= (week_begin + (7*2)) && game_date <= (week_end + (7*2))
      3
    elsif game_date >= (week_begin + (7*3)) && game_date <= (week_end + (7*3))
      4
    elsif game_date >= (week_begin + (7*4)) && game_date <= (week_end + (7*4))
      5
    elsif game_date >= (week_begin + (7*5)) && game_date <= (week_end + (7*5))
      6
    elsif game_date >= (week_begin + (7*6)) && game_date <= (week_end + (7*6))
      7
    elsif game_date >= (week_begin + (7*7)) && game_date <= (week_end + (7*7))
      8
    elsif game_date >= (week_begin + (7*8)) && game_date <= (week_end + (7*8))
      9
    elsif game_date >= (week_begin + (7*9)) && game_date <= (week_end + (7*9))
      10
    elsif game_date >= (week_begin + (7*10)) && game_date <= (week_end + (7*10))
      11
    elsif game_date >= (week_begin + (7*11)) && game_date <= (week_end + (7*11))
      12
    elsif game_date >= (week_begin + (7*12)) && game_date <= (week_end + (7*12))
      13
    elsif game_date >= (week_begin + (7*13)) && game_date <= (week_end + (7*13))
      14
    elsif game_date >= (week_begin + (7*14)) && game_date <= (week_end + (7*14))
      15
    elsif game_date >= (week_begin + (7*15)) && game_date <= (week_end + (7*15))
      16
    elsif game_date >= (week_begin + (7*16)) && game_date <= (week_end + (7*16))
      17
    elsif game_date >= (week_begin + (7*17)) && game_date <= (week_end + (7*17))
      18
    elsif game_date >= (week_begin + (7*18)) && game_date <= (week_end + (7*18))
      19
    elsif game_date >= (week_begin + (7*19)) && game_date <= (week_end + (7*19))
      20
    else
      'error'
    end
  end

  # PROXIMOS PASSOS
  # Separar os arquivos de helper em relação ao que cada um faz
  # Pegar os jogos de hoje e dos dois ultimos dias e atualizar no banco de dados aqueles jogos
  # Arrumar o rake pra refletir iss
  # Verificar se deu pau pq tem um time novo
  #

  # https://api.mysportsfeeds.com/v1.1/sample/pull/nfl/2016-2017-regular/full_game_schedule.json?
  # https://api.mysportsfeeds.com/v1.1/pull/nfl/2017-2018-regular/full_game_schedule.json?
  # https://api.mysportsfeeds.com/v1.1/pull/nfl/2017-2018-regular/daily_game_schedule.json?fordate=20170907

end
