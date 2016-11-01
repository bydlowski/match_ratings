class ArrayGame
  include Mongoid::Document
  include Mongoid::Timestamps
  field :game_url, type: Array, default: []
end
