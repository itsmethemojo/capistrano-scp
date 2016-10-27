# capistrano-scp

This is a plugin for [capistrano 3](http://capistranorb.com/) to deploy code via scp. It is made for git projects and meant to work with [jenkins.](https://jenkins.io/)

## Installation

run this commands with the user that will later run the **cap** commands 
```bash
cd ~
git clone https://github.com/itsmethemojo/capistrano-scp.git
cd capistrano-scp
bundle install
```

## Configure your project

### Capfile

create a file named **Capfile** in your git project
```ruby
require '~/capistrano-scp/plugin.rb'
```

### stage config

create following folder structure

```
config -> deploy.rb
       -> deploy     -> testing.rb
                     -> staging.rb
                     -> production.rb
```

**lazy?** use this bash commands
```
echo "require '~/capistrano-scp/plugin.rb'" > Capfile
mkdir -p config/deploy
touch config/deploy.rb
touch config/deploy/production.rb
touch config/deploy/staging.rb
touch config/deploy/testing.rb
```

### configure a stage
```ruby
set :deploy_to, "/path/on/remote/server"
set :ssh_user, "userForSsh"
set :ssh_host, "hostForSsh"
server "#{fetch(:ssh_host)}", user: "#{fetch(:ssh_user)}", roles: %w{web}, primary: true
```

**optional keys**
```ruby
set :excludes, %w{"**/.git" "**/node_modules"}
```