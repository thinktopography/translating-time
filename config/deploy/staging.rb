set :deploy_to, "/var/www/#{application}/staging"
set :deploy_via, :remote_cache
set :deploy_env, 'production'
set :db_env, 'staging'
set :use_sudo, false

ssh_options[:username] = "root"
ssh_options[:keys] = [File.join(File.dirname(File.dirname(__FILE__)),"ssh.key")]

role :app, "staging.#{domain}"