require "bundler/capistrano"
require "capistrano-rbenv"

# Pre-compile assets
load 'deploy/assets'

set :application, "wattball"
set :repository,  "git@github.com:homelinen/wattball.git"

set :branch, "master"

# Only pull diffs from remote
set :deploy_via, :remote_cache

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "dracula.homelinen.org", :app, :web, :db, :primary => true

set :deploy_to, "/srv/ruby/#{application}"

ssh_options[:forward_agent] = true

set :use_sudo, false

set :default_environment, {
    'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}


#set :rvm_ruby_string, "1.9.3@wattball"
#before 'deploy:setup', 'rvm:export_gemset'

set :rbenv_ruby_version, "1.9.3-p392"
set :rbenv_setup_shell, true
set :rbenv_setup_default_environment, true

#Bundler
set :bundle_flags, "--deployment --quiet --binstubs"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  #task :start do ; end
  #task :stop do ; end
  #task :restart, :roles => :app, :except => { :no_release => true } do
    #run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  #end

  desc "Wattball stop"
  task :stop, :roles => :app do
      invoke_command "cd #{current_path}; bundle exec thin -C /etc/thin/wattball stop"
  end

  desc "Wattball start."
  task :start, :roles => :app do
      invoke_command "cd #{current_path}; bundle exec thin -C /etc/thin/wattball start"
  end  

  desc "Wattball Restart"
  task :restart, :roles => :app do
      invoke_command "cd #{current_path}; bundle exec thin -C /etc/thin/wattball stop"
      invoke_command "cd #{current_path}; bundle exec thin -C /etc/thin/wattball start"
  end
end
