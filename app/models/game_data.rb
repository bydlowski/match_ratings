class GameData
  include Mongoid::Document
  include Mongoid::Timestamps
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
end
