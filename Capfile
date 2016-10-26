require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/git'

module ScpStrategy
    include Capistrano::Git::DefaultStrategy

    # clear method
    def test
    end

    # clear method
    def check
    end

    # clear method
    def clone
    end

    # clear method
    def update
    end

    # TODO really extract Data
    def release
        context.execute "echo tar -xzf #{repo_path}/#{release_timestamp}.tar.gz #{release_path}/"
    end

    def fetch_revision
        context.execute "echo `cat #{repo_path}/#{release_timestamp}_REVISION`"
    end
end

set :git_strategy, ScpStrategy
set :scm, :git

before :deploy, "deploy:create_archive"


namespace :deploy do
  desc "Bananarama"
  task :create_archive do
        system "pwd"
        system "echo #{release_timestamp}"
  end
end
