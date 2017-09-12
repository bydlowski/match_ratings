class Admin::LogsController < ApplicationController
  layout 'admin'
  def index
    ten_days = Date.today - 10
    @logs = AdminLogs.where(:log_date.gte => ten_days).desc(:log_date)
  end
end
