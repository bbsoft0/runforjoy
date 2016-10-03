# config valid only for current version of Capistrano
lock '3.6.1'

# application name
set :application, 'runforjoy'

# deploy directory on the server. Will be ie: '/var/www/myapp_production'
set :deploy_to, -> { "/root/#{fetch(:application)}_#{fetch(:stage)}" }

# capistrano will download an app from "master" branch of this repository:
set :repo_url, 'git@github.com:bbsoft0/runforjoy.git'

# change to ruby version you need
set :rbenv_ruby, '2.3.1'

namespace :figaro do
    desc "SCP transfer figaro configuration to the shared folder"
    task :setup do
        on roles(:app) do
            upload! "config/application.yml", "#{shared_path}/application.yml", via: :scp
        end
    end

    desc "Symlink application.yml to the release path"
    task :symlink do
        on roles(:app) do
            execute "ln -sf #{shared_path}/application.yml #{release_path}/config/application.yml"
        end
    end

end

namespace :deploy do
    before :updated, "figaro:setup"
    before :updated, "figaro:symlink"
end