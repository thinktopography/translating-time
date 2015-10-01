set :stages, %w(production)
set :default_stage, "production"

set :application, "translatingtime"
set :domain, "translatingtime.org"
set :repo_url, "git@github.com:thinktopography/translating-time.git"
set :scm, "git"
set :keep_releases, 2
set :normalize_asset_timestamps, false
set :workers, { :worker => { "email" => 2 } }

linked = []
["smtp","aws","database","secrets"].each do |config|
  linked << "config/#{config}.yml"
end

set :linked_files, linked
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}