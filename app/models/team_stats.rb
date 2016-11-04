class TeamStats
  include Mongoid::Document
  include Mongoid::Timestamps
  field :team_abrev, type: String
  field :stats, type: Hash
end
