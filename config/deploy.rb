set :stages, %w(production)
set :default_stage, "production"

set :application, "translatingtime"
set :domain, "translatingtime.org"
set :repo_url, "git@github.com:thinktopography/translating-time.git"
set :scm, "git"
set :keep_releases, 2
set :normalize_asset_timestamps, false
set :workers, { :worker => { "email" => 2 } }
set :passenger_restart_with_touch, true

linked = []
["smtp","aws","database","secrets"].each do |config|
  linked << "config/#{config}.yml"
end

set :linked_files, linked
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

after "deploy:restart", "delayed_job:restart"
