module GamesHelper

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
