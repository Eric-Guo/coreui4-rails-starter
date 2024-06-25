# config valid for current version and patch releases of Capistrano
lock "~> 3.19.0"

# Default branch is :master
set :branch, :main

# Default deploy_to directory is /var/www/rails_starter
# set :deploy_to, "/var/www/rails_starter"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, *%w[puma.rb config/settings.local.yml config/database.yml config/master.key config/credentials.yml.enc]

# Default value for linked_dirs is []
append :linked_dirs, *%w[log storage tmp/pids tmp/cache tmp/sockets public/packs public/system node_modules]

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :rbenv_type, :user
set :rbenv_ruby, "3.2.2"

set :puma_init_active_record, true
set :puma_phased_restart, true

# https://stackoverflow.com/a/48627238/262826
Rake::Task["deploy:assets:backup_manifest"].clear_actions
Rake::Task["deploy:assets:restore_manifest"].clear_actions
