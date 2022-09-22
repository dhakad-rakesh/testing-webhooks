require 'mina/multistage'
require 'mina/rails'
require 'mina/git'
require 'mina/puma'
# require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
require 'mina/rvm' # for rvm support. (https://rvm.io)
require 'mina_sidekiq/tasks'

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)
# set :application_name, 'bwinner'
# set :domain, '18.211.66.9'
# set :domain, '18.214.197.18'
# set :domain, 'ec2-3-13-199-159.us-east-2.compute.amazonaws.com'
# set :deploy_to, '/var/www/apps/bwinner/staging'
# set :repository, 'git@bitbucket.org:rigupta/gammabet.git'
# set :branch, 'staging'
# set :rails_env, 'staging'
# set :rvm_use_path, '$HOME/.rvm/scripts/rvm'

set :execution_mode, :system

# Optional settings:
set :user, 'ubuntu' # Username in the server to SSH to.
set :port, '22' # SSH port number.
set :forward_agent, true # SSH forward_agent.

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
# set :shared_dirs, fetch(:shared_dirs, []).push('public/assets')
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')
set :shared_dirs, fetch(:shared_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/assets', 'tmp/storage')
set :shared_files, fetch(:shared_files, []).push(
  'config/database.yml', 'config/storage.yml', 'config/secrets.yml', 'config/puma.rb', 'config/application.yml',
  'config/firebase_keyfile.json'
)
# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
# set :puma_env,       -> { fetch(:rails_env, 'staging') }
# set :puma_env,       -> { fetch(:rails_env, 'staging') }

task :remote_environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load', 'ruby-2.4.3'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use', 'ruby-2.4.3'
  invoke :'rvm:use', "ruby-2.4.3@bwinner"
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.0 --skip-existing}
  command %{mkdir -p "#{fetch(:shared_path)}/tmp/sockets"}
  command %{mkdir -p "#{fetch(:shared_path)}/tmp/pids"}
  command %{mkdir -p "#{fetch(:shared_path)}/log/mongo"}
  command %(touch "#{fetch(:shared_path)}/config/database.yml")
  command %(touch "#{fetch(:shared_path)}/config/secrets.yml")
  command %(touch "#{fetch(:shared_path)}/config/puma.rb")
  command %(touch "#{fetch(:shared_path)}/config/storage.rb")
  command %(touch "#{fetch(:shared_path)}/config/application.yml")
  command %(touch "#{fetch(:shared_path)}/config/firebase_keyfile.json")
  comment "Be sure to edit '#{fetch(:shared_path)}/config/database.yml', 'storage.rb', 'secrets.yml' and puma.rb."
  command %{sudo apt-get install imagemagick}

  # invoke :'rvm:use', 'ruby-2.4.3'
  # sidekiq needs a place to store its pid file and log file
  # command %{mkdir -p "#{fetch(:shared_path)}/shared/pids/"}
  # command %{mkdir -p "#{fetch(:shared_path)}/shared/log/"}
end

desc 'Deploys the current version to the server.'
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    comment "Deploying #{fetch(:application_name)} to #{fetch(:domain)}:#{fetch(:deploy_to)}"
    # invoke :'rvm:use', 'ruby-2.4.3'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'
    # stop accepting new workers
    # invoke :'sidekiq:quiet'

    on :launch do
      # in_path(fetch(:current_path)) do
      #   # invoke :'puma:start'
      #   # restart puma
      #   invoke :'rvm:use', 'ruby-2.4.3'
      #   # command "sudo god stop puma_sidekiq"

      #   command "ps -ef | grep puma | grep -v grep | awk '{print $2}' | sudo xargs kill -9"
      #   command "ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | sudo xargs kill -9"
      #   command 'sleep 5; sudo god start puma_sidekiq'
      #   # command %{bundle exec rails runner BR::AMQP::WatcherJob.perform_later }
      # end
      # in_path(fetch(:current_path)) do
      #   command %{mkdir -p tmp/}
      #   command %{touch tmp/restart.txt}
      # end
      # uncomment OR run this manually after deployment to restart sidekiq 
      # invoke :'sidekiq:restart'
      invoke :'puma:phased_restart'
      # Create live_data folder after deploy for live odds
      # command %{mkdir -p "#{$HOME}/tmp/live_data"}
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
