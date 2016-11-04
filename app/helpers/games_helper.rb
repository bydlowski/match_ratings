module GamesHelper
  # RETURNS THE COUNT, THE NUMBER OF COMPLETED SURVEYS
  def grid_date
    # page = ''
    # page +=  game['game']['date']
    # page += surround '(', ')' do
    # page += game['game']['time']
    # return page.html_safe
  end
  def grid_suggestion(date,away,home,time)
    page = ''
    year = date.split('-').first
    month = date.split('-').second
    day = date.split('-').third
    game_date = DateTime.new(year.to_i, month.to_i, day.to_i)

    if (game_date.wday == 4 || game_date.wday == 1 || time == '8:30PM')
      if (away.to_i - home.to_i).abs < 6
        page += '<div class="hidden-score hidden-rating"><p class="hidden-text">Click to show</p></div>YES!!'
      else
        page += '<div class="hidden-score hidden-rating"><p class="hidden-text">Click to show</p></div>No'
      end
    else
      if (away.to_i - home.to_i).abs < 6
        page += 'YES!!'
      else
        page += 'No'
      end
    end

    return page.html_safe
  end
  def awe_replace(text)
    page = ''
    page += 'AAA: ' + c.name
    return page.html_safe
  end
  def score(date,time,game,counter)
    page = ''
    year = date.split('-').first
    month = date.split('-').second
    day = date.split('-').third
    red_score = "col xs-col-4 xs-text-2 fill-red-lighter xs-border-left-lighter"
    yellow_score = "col xs-col-4 xs-text-2 fill-yellow-lighter xs-border-left-lighter"
    green_score = "col xs-col-4 xs-text-2 new-green xs-border-left-lighter"
    game_date = DateTime.new(year.to_i, month.to_i, day.to_i)
    rating = (((game.home_team_score+game.away_team_score).abs)*0.3 + score_diff(game.home_team_score,game.away_team_score,game.quarter_count) + down_diff((game.stats_home_team_downs-game.stats_away_team_downs).abs) + game.stats_interceptions*2 + game.stats_fumbles*1.5).round(0)

    if (game_date.wday == 4 || game_date.wday == 1 || time == '8:30PM')
      page += '<div class="hid' + counter.to_s + ' hidden-score col xs-col-12 hidden-rating"><p class="hidt' + counter.to_s + '">Click to show</p></div>'
      if rating.to_i <= 20
        page += '<div class="col xs-col-8">Score:</div><div class="' + red_score + '">' + rating.to_s + '</div>'
      elsif rating.to_i <= 30
        page += '<div class="col xs-col-8">Score:</div><div class="' + yellow_score + '">' + rating.to_s + '</div>'
      else
        page += '<div class="col xs-col-8">Score:</div><div class="' + green_score + '">' + rating.to_s + '</div>'
      end
    else
      if rating.to_i <= 20
        page += '<div class="col xs-col-8">Score:</div><div class="' + red_score + '">' + rating.to_s + '</div>'
      elsif rating.to_i <= 30
        page += '<div class="col xs-col-8">Score:</div><div class="' + yellow_score + '">' + rating.to_s + '</div>'
      else
        page += '<div class="col xs-col-8">Score:</div><div class="' + green_score + '">' + rating.to_s + '</div>'
      end
    end

    # if (game_date.wday == 4 || game_date.wday == 1 || time == '8:30PM')
    #   if rating > 30
    #     page += '<div class="hidden-score hidden-rating"><p class="hidden-text">Click to show</p></div>'+ rating.to_s
    #   else
    #     page += '<div class="hidden-score hidden-rating"><p class="hidden-text">Click to show</p></div>'  + rating.to_s
    #   end
    # else
    #   if rating > 30
    #     page += rating.to_s
    #   else
    #     page += rating.to_s
    #   end
    # end

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
end
