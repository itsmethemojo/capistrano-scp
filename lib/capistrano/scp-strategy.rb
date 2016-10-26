# Usage: 
# 1. Drop this file into lib/capistrano/submodule_strategy.rb
# 2. Add the following to your Capfile:
#   require 'capistrano/git'
#   require './lib/capistrano/submodule_strategy'
# 3. Add the following to your config/deploy.rb
#   set :git_strategy, SubmoduleStrategy

module SubmoduleStrategy
  # do all the things a normal capistrano git session would do
  include Capistrano::Git::DefaultStrategy
  
  # check for a .git directory
  def test

  end

  # same as in Capistrano::Git::DefaultStrategy
  def check

  end

  def clone

  end

  # same as in Capistrano::Git::DefaultStrategy
  def update

  end

  # put the working tree in a release-branch,
  # make sure the submodules are up-to-date
  # and copy everything to the release path
  def release
    context.execute "echo tar -xzf #{repo_path}/#{release_timestamp}.tar.gz #{release_path}/"
  end


def fetch_revision
    context.execute "echo `cat #{repo_path}/#{release_timestamp}_REVISION`"
end

end
