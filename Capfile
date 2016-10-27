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
        context.execute "[ $(ls -A #{release_path} | wc -l) -gt 0 ] || ( cd #{release_path} && tar -v -xzf #{repo_path}/#{release_timestamp}.tar.gz )"
    end

    def fetch_revision
        context.capture "cat #{repo_path}/#{release_timestamp}_REVISION"
    end
end

set :git_strategy, ScpStrategy
set :scm, :git

before :deploy, "deploy:create_archive"


namespace :deploy do
    desc "Bananarama"
    task :create_archive do
        archive_file = "/tmp/#{release_timestamp}.tar.gz"
        revision_file = "/tmp/#{release_timestamp}_REVISION"
        # pack code and set revision
        system "tar -czf  #{archive_file} ."
        system "git log -1 | head -1 | awk '{print $2}' > #{revision_file}"
        system "scp #{archive_file} #{revision_file} #{fetch(:ssh_user)}@#{fetch(:ssh_host)}:#{repo_path}"
    end
end
