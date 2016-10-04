# config valid only for current version of Capistrano
lock '3.6.1'

# application name
set :application, 'runforjoy'

# deploy directory on the server. Will be ie: '/var/www/myapp_production'
set :deploy_to, -> { "/root/#{fetch(:application)}_#{fetch(:stage)}" }

# capistrano will download an app from "master" branch of this repository:
set :repo_url, 'git@github.com:bbsoft0/runforjoy.git'


set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{tmp/pids}

set :unicorn_config_path, "config/unicorn.rb"

set :rbenv_path, '/root/.rbenv/'
set :rbenv_type, :user # or :system, depends on your rbenv setup
# change to ruby version you need
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end