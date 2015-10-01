set :deploy_to, "/var/www/translatingtime/production"
set :deploy_via, :remote_cache
set :deploy_env, 'production'
set :rails_env, "production"
set :use_sudo, false
set :ssh_options, {
  keys: [File.join(File.dirname(File.dirname(__FILE__)),"ssh.key")],
  forward_agent: false,
  auth_methods: %w(publickey)
}

server '54.166.115.42', :user => 'ec2-user', :roles => ['app','web','db']
