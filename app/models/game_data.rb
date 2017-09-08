class GameData
  include Mongoid::Document
  include Mongoid::Timestamps

  before_save :get_win_loss
  before_save :get_game_score

  field :game_url_name, type: String
  field :game_date, type: String
  field :game_time, type: String
  field :game_period, type: String
  field :game_week_number, type: Integer
  field :home_team_abrev, type: String
  field :away_team_abrev, type: String
  field :home_team_complete, type: String
  field :away_team_complete, type: String
  field :home_team_score, type: Integer
  field :away_team_score, type: Integer
  field :quarter_count, type: Integer
  field :winner_team, type: String
  field :loser_team, type: String
  field :stats_interceptions, type: Integer
  field :stats_fumbles, type: Integer
  field :stats_home_team_downs, type: Integer
  field :stats_away_team_downs, type: Integer
  field :lead_changes, type: Integer
  field :lead_ties, type: Integer
  field :score, type: String, default: 'N/A'

  private

  def get_win_loss
    if self.home_team_score.to_i > self.away_team_score.to_i
      self.winner_team = self.home_team_abrev
      self.loser_team = self.away_team_abrev
    elsif self.home_team_score.to_i < self.away_team_score.to_i
      self.winner_team = self.away_team_abrev
      self.loser_team = self.home_team_abrev
    elsif self.home_team_score.to_i == self.away_team_score.to_i
      self.winner_team = self.away_team_abrev + 'TIE'
      self.loser_team = self.home_team_abrev + 'TIE'
    end
  end

  def get_game_score
    unless self.winner_team.blank?
      score_rating = ((self.home_team_score + self.away_team_score).abs) * 0.3
      score_diff_rating = score_diff(self.home_team_score,self.away_team_score,self.quarter_count)
      down_diff_rating = down_diff(self.stats_home_team_downs - self.stats_away_team_downs).abs
      interceptions_rating = self.stats_interceptions * 2
      fumbles_rating = self.stats_fumbles * 1.5
      final_rating = (score_rating + score_diff_rating + down_diff_rating + interceptions_rating + fumbles_rating).round(0)
      self.score = final_rating
    end
  end

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
