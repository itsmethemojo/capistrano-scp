require 'capistrano/git'
require './lib/capistrano/scp-strategy'


require 'capistrano/setup'
require 'capistrano/deploy'
set :copy_strategy, :scp
set :stage, :production
set :stages, ["testing","staging", "production"]

set :application, "php_app"

set :scm, :git
set :repo_url, 'git@github.com:itsmethemojo/utils.git'
set :deploy_to, "/tmp/www/php_app"



server '54.93.75.41', user: 'ubuntu', roles: %w{web app db}, primary: true
set :git_strategy, SubmoduleStrategy




before :deploy, "deploy:create_archive"


namespace :deploy do
  desc "Bananarama"
  task :create_archive do
        system "pwd"
        system "echo #{release_timestamp}"
  end
end
