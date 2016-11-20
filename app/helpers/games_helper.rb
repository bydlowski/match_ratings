module GamesHelper
  def score(date,time,game,counter,algo,user_team,week)
    page = ''
    year = date.split('-').first
    month = date.split('-').second
    day = date.split('-').third
    prev_text = '<div class="col xs-col-8">Rating:</div><div class="'
    red_score = "col xs-col-4 xs-text-2 fill-red-lighter xs-border-left-lighter"
    yellow_score = "col xs-col-4 xs-text-2 fill-yellow-lighter xs-border-left-lighter"
    green_score = "col xs-col-4 xs-text-2 new-green xs-border-left-lighter"
    game_date = DateTime.new(year.to_i, month.to_i, day.to_i)
    rating = game_rating(game,algo,user_team,week)
    #rating = (((game.home_team_score+game.away_team_score).abs)*0.3 + score_diff(game.home_team_score,game.away_team_score,game.quarter_count) + down_diff((game.stats_home_team_downs-game.stats_away_team_downs).abs) + game.stats_interceptions*2 + game.stats_fumbles*1.5).round(0)

    if (game_date.wday == 4 || game_date.wday == 1 || time == '8:30PM' || time == '9:30AM') && @hide == 'HideR'
      page += '<div class="hid' + counter.to_s + ' hidden-score col xs-col-12 hidden-rating"><p class="hidt' + counter.to_s + '">Click to show</p></div>'
      if rating.to_i <= 20
        page += prev_text + red_score + '">' + rating.to_s + '</div>'
      elsif rating.to_i <= 30
        page += prev_text + yellow_score + '">' + rating.to_s + '</div>'
      else
        page += prev_text + green_score + '">' + rating.to_s + '</div>'
      end
    else
      if rating.to_i <= 20
        page += prev_text + red_score + '">' + rating.to_s + '</div>'
      elsif rating.to_i <= 30
        page += prev_text + yellow_score + '">' + rating.to_s + '</div>'
      else
        page += prev_text + green_score + '">' + rating.to_s + '</div>'
      end
    end

  return page.html_safe

  end

  def team_stats_week(team,chosen_week)
    @wins = 0
    @loss = 0
    @team_hash = TeamStats.find_by(team_abrev: team)
    @team_hash.stats.each do |week,result|
      if result == 'W' && week.to_i < chosen_week.to_i
        @wins += 1
      elsif result == 'L' && week.to_i < chosen_week.to_i
        @loss += 1
      else
        @wins += 0
      end
    end
    return @wins.to_s + ' - ' + @loss.to_s
  end

  # SCORE DIFFERENTIAL PPOINTS #
  def score_diff(team1score,team2score,quarter_count)
    diff = (team1score - team2score).abs
    if quarter_count > 4
      16
    elsif diff >= 10
      -15
    elsif diff >= 7 && diff < 10
      -5
    elsif diff >= 4 && diff <= 6
      7
    elsif diff == 3
      16
    elsif diff == 2
      14
    elsif diff == 1
      15
    elsif diff == 0
      15
    else
      'error'
    end
  end

  def down_diff(diff)
    if diff >= 20
      -15
    elsif diff >= 10 && diff < 20
      -2
    elsif diff >= 5 && diff <= 9
      4
    elsif diff >= 0 && diff <= 4
      8
    else
      'error'
    end
  end

  def game_rating(game,algo,user_team,week)
    total_score = ((game.home_team_score+game.away_team_score).abs) * 0.3
    score_diferential = score_diff(game.home_team_score,game.away_team_score,game.quarter_count)
    down_difference = down_diff((game.stats_home_team_downs-game.stats_away_team_downs).abs)
    intercaptions = game.stats_interceptions * 2
    fumbles = game.stats_fumbles * 1.5
    lead = game.lead_changes * 2.5
    tie = game.lead_ties * 0.8
    chosen_team = (game.away_team_abrev == user_team || game.home_team_abrev == user_team) ? 3 : 0

    if algo == 'FullAlgo'
      #rivals(game.home_team_abrev, game.away_team_abrev)
      #divisional(game.home_team_abrev, game.away_team_abrev)
      #chosen_team
      #win_loss(week,game.home_team_abrev,game.away_team_abrev)
      (rivals(game.home_team_abrev, game.away_team_abrev) + divisional(game.home_team_abrev, game.away_team_abrev) + chosen_team + win_loss(week,game.home_team_abrev,game.away_team_abrev) + total_score + score_diferential + down_difference + intercaptions + fumbles + lead + tie).round(0)
    else
      (total_score + score_diferential + down_difference + intercaptions + fumbles + lead + tie).round(0)
    end
  end

  def rivals(home, away)
    rivalry_array = [['CHI','GB',5],['DEN','OAK',3],['CLE','CIN',3],['PIT','BAL',5],['WAS','DAL',4],['SF','SEA',2],['PHI','NYG',2],['NE','NYJ',3],['PIT','CLE',2],['MIN','GB',1],['ATL','NO',3],['BUF','MIA',1],['DEN','MIA',1],['DAL','PHI',1],['BAL','NE',2],['NE','IND',1],['DAL','NYG',2],['OAK','KC',1],['TEN','HOU',1],['NYJ','NYG',1],['DET','GB',1]]
    rivalry_array.each do |game|
      score = 0
      result = 0
      game.each do |team|
        if team == home
          score += 1
        elsif team == away
          score += 1
        elsif team.is_a? Integer
          result += team
        end
      end
      if score == 2
        return result.to_i
      else
        return 0
      end
    end
  end

  def divisional(home,away)
    divisions_array = [['NE','CIN','HOU','DEN'],['NYJ','PIT','IND','KC'],['BUF','BAL','JAX','OAK'],['MIA','CLE','TEN','SD'],['WAS','MIN','CAR','ARI'],['PHI','GB','ATL','SEA'],['NYG','DET','NO','LA'],['DAL','CHI','TB','SF']]
    divisions_array.each do |game|
      score = 0
      game.each do |team|
        if team == home
          score += 1
        elsif team == away
          score += 1
        end
      end
      if score == 2
        return 3
      else
        return 0
      end
    end
  end

  def win_loss(week,home,away)
    home_record = team_stats_week(home,week)
    away_record = team_stats_week(away,week)
    home_games = (home_record.split('-').first).to_i + (home_record.split('-').second).to_i
    home_coef = (home_record.split('-').first).to_i - (home_record.split('-').second).to_i
    away_games = (away_record.split('-').first).to_i + (away_record.split('-').second).to_i
    away_coef = (away_record.split('-').first).to_i - (away_record.split('-').second).to_i
    return ((win_loss_score(home_games,home_coef) + win_loss_score(away_games,away_coef)) * 5).round(1)
  end

  def win_loss_score(games,coef)
    if games < 3
      0
    elsif (coef.to_f / games.to_f) > 0.3
      0.3
      #(coef.to_f / games.to_f)
    else
      (coef.to_f / games.to_f)
    end
  end

end
