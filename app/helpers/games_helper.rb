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
        page += game_date.wday.to_s
      end
    end

    return page.html_safe
  end
  def awe_replace(text)
    page = ''
    page += 'AAA: ' + c.name
    return page.html_safe
  end
end
