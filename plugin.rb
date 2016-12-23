# set default stages
set :stages, ["testing", "staging", "production"]

# set default exclude list
set :excludes, %w{"**/.git"}

set :application, %x( echo "${PWD##*/}")

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

    # TODO for some reason this is called twice, so make sure we don't extract twice
    def release
        context.execute "[ $(ls -A #{release_path} | wc -l) -gt 0 ] || ( cd #{release_path} && tar -xzf #{repo_path}/#{release_timestamp}.tar.gz )"
    end

    # expect Revision in uploaded [TIMESTAMP]_REVISION file
    def fetch_revision
        context.capture "cat #{repo_path}/#{release_timestamp}_REVISION"
    end
end

set :git_strategy, ScpStrategy
set :scm, :git

before :deploy, "deploy:create_artefact"

namespace :deploy do
    desc "creates and uploads deploy artefacts"
    task :create_artefact do

        excludeOptions = ""
        fetch(:excludes).each { |exclude| excludeOptions.concat("--exclude #{exclude} ") }

        archive_file = "/tmp/#{release_timestamp}.tar.gz"
        revision_file = "/tmp/#{release_timestamp}_REVISION"

        # stop if dir is no git repo
        system("git log -1  > /dev/null") or exit

        # pack code and set revision
        system "echo tar #{excludeOptions} -czf #{archive_file} ."
        system "tar #{excludeOptions} -czf #{archive_file} ."
        system "git log -1 | head -1 | awk '{print $2}' > #{revision_file}"
        system "ssh #{fetch(:ssh_user)}@#{fetch(:ssh_host)} 'mkdir -p #{repo_path}'"
        system "echo scp #{archive_file} #{revision_file} #{fetch(:ssh_user)}@#{fetch(:ssh_host)}:#{repo_path}"
        system "scp #{archive_file} #{revision_file} #{fetch(:ssh_user)}@#{fetch(:ssh_host)}:#{repo_path}"
        system "rm #{archive_file} #{revision_file}"
    end
end

after "deploy:log_revision", "deploy:remove_artefact"

# this should be done on the server itself, but hey, this works too
namespace :deploy do
    desc "removes deploy artefacts"
    task :remove_artefact do
        system "ssh #{fetch(:ssh_user)}@#{fetch(:ssh_host)} 'rm #{repo_path}/#{release_timestamp}.tar.gz #{repo_path}/#{release_timestamp}_REVISION'"
    end
end
