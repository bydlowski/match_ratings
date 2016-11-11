module GamesHelper
  def score(date,time,game,counter)
    page = ''
    year = date.split('-').first
    month = date.split('-').second
    day = date.split('-').third
    prev_text = '<div class="col xs-col-8">Rating:</div><div class="'
    red_score = "col xs-col-4 xs-text-2 fill-red-lighter xs-border-left-lighter"
    yellow_score = "col xs-col-4 xs-text-2 fill-yellow-lighter xs-border-left-lighter"
    green_score = "col xs-col-4 xs-text-2 new-green xs-border-left-lighter"
    game_date = DateTime.new(year.to_i, month.to_i, day.to_i)
    rating = (((game.home_team_score+game.away_team_score).abs)*0.3 + score_diff(game.home_team_score,game.away_team_score,game.quarter_count) + down_diff((game.stats_home_team_downs-game.stats_away_team_downs).abs) + game.stats_interceptions*2 + game.stats_fumbles*1.5).round(0)

    if (game_date.wday == 4 || game_date.wday == 1 || time == '8:30PM' || time == '9:30AM') && session[:hide_score_value] == 'HideR'
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

end
