

set :stage, :production
set :stages, ["testing","staging", "production"]

set :application, "php_app"

set :repo_url, 'git@github.com:itsmethemojo/utils.git'
set :deploy_to, "/tmp/www/php_app"


set :ssh_user, "ubuntu"
set :ssh_host, "54.93.75.41"
server '54.93.75.41', user: 'ubuntu', roles: %w{web app db}, primary: true