require 'bundler/capistrano'
require 'new_relic/recipes'
require 'app_version/recipes'

# load RVM's capistrnao plugin
require 'rvm/capistrano'

# load whenever's capistrano support
set :whenever_command, "bundle exec whenever"
set :whenever_environment, defer {stage}

require 'whenever/capistrano'

# Multi-stage support
set :stages, %w(staging production bluebox)
require 'capistrano/ext/multistage'

# set :rvm_pth, "$HOME/.rvm"
set :rvm_ruby_string, "1.9.3"
set :rvm_type, :user

set :application, "confreaks.tv"
set :repository,  "git@github.com:confreaks/tv.git"

set :scm, :git
ssh_options[:forward_agent] = true

set :keep_release, 5

set :branch, 'master'

set :user, 'deploy'
set :use_sudo, false

set :home_dir, "/home/#{user}/#{application}"

set :deploy_to, "#{home_dir}"
set :deploy_via, :copy
set :scm_verbose, true
set :copy_exclude, [".git", ".DS_Store", ".gitignore", ".gitmodules"]

set :bundle_roles, [:app]

# if you want to clean up old releases on each deploy uncomment this:
after "deploy", "deploy:cleanup"
after "deploy:update", "newrelic:notice_deployment"
after "deploy:update_code", "custom:data_symlink"
after "deploy:update_code", "app_version:generate_version_info"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  namespace :web do
    task :disable, :roles => :web, :except => {:no_release => true} do
      require 'haml'
      on_rollback {run "rm #{shared_path}/system/maintenance.html"}

      reason = ENV['REASON']
      deadline = ENV['UNTIL']

      template = File.read("./app/views/layouts/maintenance.html.haml")

      result = Haml::Engine.new(template).render

      put result, "#{shared_path}/system/maintenance.html", :mode =>0644
    end
  end
end

namespace :custom do
  task :data_symlink do
    run "ln -nfs #{shared_path}/data #{release_path}/db/data"
  end
end
