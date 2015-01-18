Orienteering
================

Rails project for Orienteering



Ruby on Rails
-------------

This application requires:

- Ruby 2.1.3
- Rails 4.1.6


Travis CI
-------------

- https://travis-ci.org/neutrino/orienteering_app


Dependencies
=================

Server needs:

* Ruby 2.1.3
* PostgreSQL >= 8.4
* Nginx (production use)

Other packages that might be needed (if not installed already):

* Openssl
* ImageMagick


Server deployment
================

** TESTED IN UBUNTU 14.04 (Trusty) **


Pull the repository, change to project directory and run `bundle install`. This will install all gems for the system.

Once gems are installed, run `rails server` to start development server. If everything is OK WEBrick server should start successfully. Ctrl - C to shutdown the server.

# Unicorn configuration

Unicorn is the (production) application server for Ruby on Rails application

1. Copy config template

    cp config/unicorn.example.rb config/unicorn.rb

2. Check that `config/unicorn.rb` config looks ok, application directory is used as root. By default we listen for socket, but can also be configured to listen for TCP ports etc...

## Unicorn service

Create service for unicorn for easy start/stop/upgrade.

1. Copy script to `/etc/init.d/unicorn`

    sudo cp config/unicorn_init.sh /etc/init.d/unicorn

2. Configure `/etc/init.d/unicorn`:
- Set **APP_ROOT** as the path for the application root
- Set **AS_USER** to be the current user
- Check that **PID** is the same as in `config/unicorn.rb`

3. Make sure that file is executable (if not, use `chmod +x /etc/init.d/unicorn`)


# Nginx configuration

All commands are run from application root directory.

## Copy config templates for nginx, assuming application is the "default" site for nginx
    sudo cp config/nginx.config.example /etc/nginx/nginx.conf
    sudo cp config/nginx.config.app.example /etc/nginx/sites-available/default
    sudo rm /etc/nginx/sites-enabled/default # NOTE: this removes old default configs, use with care if there are other sites used with nginx too

    # symlink config to enable site
    sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

## Configure configs

**/etc/nginx/nginx.conf**

If you are using linux, uncomment the line `use epoll;`

Check that pid, error_log and access_log paths are OK & writable

**/etc/nginx/sites-available/default**

- Set server socket path to match unicorn socket path (from `config/unicorn.rb`): `server unix:/path/to/app/tmp/unicorn.appname.sock fail_timeout=0;`
- Set `root` path to your rails application /public folder: `root /path/to/app/public/`


# Set Ruby on Rails environment

## Database.yml

Database.yml has database configs, copy example:

    cp config/database.yml.example config/database.yml

Check it and config for example the db username for the application. Password for production user is set below (.env.production)

## Secrets.yml

Control secrets for the application. Is used to generate user for the application.
Copy:

    cp config/secrets.yml.example config/secrets.yml

Set secrets for development and test environments as you wish. Production secrets are controlled with environemnt variables, see below.

## Environment variables

**Dotenv** gem is used to manage some environment variables. Copy example file:

    cp .env.production.example .env.production

Then edit `.env.production` and set variables for your environment:

- ADMIN_NAME
- ADMIN_EMAIL (username for admin user)
- ADMIN_PASSWORD (admin password)
- DOMAIN_NAME
- DB_PASSWORD (password for default db user "postgres", for more precise control use `config/database.yml`)
- SECRET_KEY_BASE (check below)

### Create secret key for Rails app

Append secret key to environment variable file:

    rake secret >> .env.production

Edit `.env.production` and set appended key as value for variable **SECRET_KEY_BASE**


## Misc

- `mkdir log` to create folder for logs.
- Make sure folders under tmp/ are writable for the user (chown -R userX:userX tmp/)


# Start services

Start nginx: `sudo service nginx start`

Start Unicorn `sudo service unicorn start`


# Init the Ruby on Rails application (Production use)

Run command `RAILS_ENV=production rake db:create db:migrate assets:precompile`

- **RAILS_ENV=production** sets the Rails app to start in production mode
- **db:create** will create the database based on database.yml
- **db:migrate** will migrate the database structure to the latest version
- **assets:precompile** will compile JS & CSS files into smaller files

If this is fresh install, you might want to run also `RAILS_ENV=production rake db:seed`, which will insert admin user into database (admin user details from `.env.production` (ADMIN_NAME, ADMIN_PASSWORD))


** Orienteering application is now running with Nginx as HTTP proxy, Unicorn as application server


# Problems?

Check logs from `log/production.log` and `log/unicorn.log` to debug issues with application. Or Google.
