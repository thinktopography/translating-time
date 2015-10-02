require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'
require 'capistrano/bundler'
require 'capistrano/passenger'
load 'deploy/assets'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }