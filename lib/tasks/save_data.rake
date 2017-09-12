require "rake_helpers/schedule_helper"
require "rake_helpers/game_score_helper"
require "rake_helpers/team_stats_helper"
include ScheduleHelper
include GameScoreHelper
include TeamStatsHelper

desc "Save data through rake"
task import_data: :environment do
  check_if_full_game_schedule_changed
  save_game_scores
  update_team_stats
end
