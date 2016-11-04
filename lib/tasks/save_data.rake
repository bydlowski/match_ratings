require "#{Rails.root}/app/helpers/rake_helper"
include RakeHelper

desc "Save data through rake"
task import_data: :environment do
  #Article.create({name: 'John'})
  #batch = [{:name => "mongodb"}, {:name => "mongoid"}]
  #Article.collection.insert_many(batch) unless Article.find_by(name: 'mongoid')
  #Article.collection.insert_one({name: hi})
  #ArrayGame.collection.push("AAA")
  #ArrayGame.collection.insert_one({game_url: "Test"})
  # Ver essa função no arquivo rake_helper.rb
  #today
  #all_dates
  games_from_array
end
task import_week_stats: :environment do
  team_stats
end
