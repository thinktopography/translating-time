set :stages, %w(qa staging production circleci)
set :default_stage, "production"

set :application, "campgroundcontrol"
set :domain, "campgroundcontrol.com"
set :repo_url, "git@github.com:thinktopography/campgroundcontrol.git"
set :scm, "git"
set :keep_releases, 2
set :normalize_asset_timestamps, false
set :workers, { :worker => { "email" => 2 } }
set :resque_environment_task, true

linked = []
["smtp","aws","database","secrets","redis"].each do |config|
  linked << "config/#{config}.yml"
end

set :linked_files, linked
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# after "deploy:updating", "deploy:config"
# after 'deploy:updated', "assets:compile"
after "deploy:restart", "resque:restart"
after "deploy:restart", "resque:scheduler:restart"