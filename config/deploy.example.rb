set :application, 'orienteering'

set :scm, :git
set :repo_url, 'https://github.com/NFC-Orienteering/orienteering_app.git'
set :branch, 'master'

set :deploy_to, '<deploy_path>'
server '<server_url>', user: '<user>', roles: %w{web app db}

# We don't want to use sudo (root) - for security reasons
set :use_sudo, false

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml config/secrets.yml config/unicorn.rb }
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:reload'
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
