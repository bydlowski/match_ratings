class AdminLogs
  include Mongoid::Document
  include Mongoid::Timestamps
  field :log_date, type: Date
  field :log_info, type: String
end
