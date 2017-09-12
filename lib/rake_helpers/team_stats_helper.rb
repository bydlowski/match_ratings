module TeamStatsHelper

  def update_team_stats
    p 'Recreating team stats'
    TeamStats.destroy_all
    teams_array = ['LA', 'LAR', 'CLE', 'TB', 'MIN', 'CIN', 'OAK',  'MIA', 'NYG', 'DET', 'NE', 'PIT', 'LAC', 'NYJ', 'CAR', 'GB', 'BUF', 'CHI', 'TEN', 'BAL', 'DAL', 'NO', 'SF', 'KC', 'SEA', 'JAX', 'ATL', 'IND', 'PHI', 'HOU', 'ARI', 'DEN', 'WAS']
    teams_array.each do |team|
      TeamStats.create!(team_abrev: team.to_s, :stats => {1 => '',2 => '',3 => '',4 => '',5 => '',6 => '',7 => '',8 => '',9 => '',10 => '',11 => '',12 => '',13 => '',14 => '',15 => '',16 => '',17 => '',18 => '',19 => '',20 => '',21 => ''})
    end
    p 'Updating team stats'
    all_games = GameData.where(:game_week_number.gt => 0, :home_team_score.ne => nil).asc(:game_week_number)
    all_games.each do |game|
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
    p 'Team Stats Updated'
  end

end
