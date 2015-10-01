require 'open-uri'
require 'json'

set :deploy_to, "/var/www/campgroundcontrol/qa"
set :deploy_via, :remote_cache
set :deploy_env, 'qa'
set :rails_env, "qa"
set :use_sudo, false
set :ssh_options, {
  keys: ['/root/.ssh/id_circleci_github'],
  forward_agent: false,
  auth_methods: %w(publickey)
}

server '52.5.126.45', :user => 'ec2-user', :roles => ['app','web','db','worker','resque_scheduler']
