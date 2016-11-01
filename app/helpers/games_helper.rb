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
  def score(date,time,game)
    page = ''
    year = date.split('-').first
    month = date.split('-').second
    day = date.split('-').third
    game_date = DateTime.new(year.to_i, month.to_i, day.to_i)
    rating = (((game.home_team_score+game.away_team_score).abs)*0.3 + score_diff(game.home_team_score,game.away_team_score,game.quarter_count) + down_diff((game.stats_home_team_downs-game.stats_away_team_downs).abs) + game.stats_interceptions*2 + game.stats_fumbles*1.5).round(0)

    if (game_date.wday == 4 || game_date.wday == 1 || time == '8:30PM')
      if rating > 30
        page += '<div class="hidden-score hidden-rating"><p class="hidden-text">Click to show</p></div>'+ rating.to_s
      else
        page += '<div class="hidden-score hidden-rating"><p class="hidden-text">Click to show</p></div>'  + rating.to_s
      end
    else
      if rating > 30
        page += rating.to_s
      else
        page += rating.to_s
      end
    end

  return page.html_safe

  end
end
