require 'open-uri'
require 'json'

set :deploy_to, "/var/www/translating/production"
set :deploy_via, :remote_cache
set :deploy_env, 'production'
set :rails_env, "production"
set :use_sudo, false
ssh_options[:keys] = [File.join(File.dirname(File.dirname(__FILE__)),"ssh.key")]

server '54.166.115.42', :user => 'ec2-user', :roles => ['app','web','db']
