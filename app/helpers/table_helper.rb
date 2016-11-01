module TableHelper
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
    elsif diff == 2 || diff == 3
      14
    elsif diff == 1
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
