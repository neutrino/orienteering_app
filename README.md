Orienteering
================

[Ruby on Rails](http://guides.rubyonrails.org/) project for Orienteering



Ruby on Rails
-------------

This application requires:

- Ruby 2.1.3
- Rails 4.1.6


Travis CI
-------------

- https://travis-ci.org/neutrino/orienteering_app

Development
===================

There are two choices for development environment:

1) For fast start of development you can use Vagrant [(check the wikipage for step-by-step guides on how to get server running locally)](https://github.com/NFC-Orienteering/orienteering_app/wiki/Vagrant-with-Chef). **Windows user!** If you use Windows installation of Git, check [this issue before proceeding](https://github.com/NFC-Orienteering/orienteering_app/wiki/Vagrant-with-Chef#check-line-endings-of-ruby-version-file). Having Windows line endings when running Unix scripts potentially has strange outcomes...

2) Install everything from scratch. If you want to develop in your computer without Vagrant's virtual machine install dependencies (Ruby 2.1.3, ImageMagik, PostgreSQL). The run `bundle install` in the application folder. This will install all the Gems listed in **Gemfile**. Re-open your console window to refresh PATH. Run `rake db:create db:migrate` (and `rake db:seed` to create default admin user) to initialize database. Then run `rails s` to start development server in [localhost port 3000](http://localhost:3000). Running `rails s -d` will run the server in background.




Dependencies
=================

Server needs:

* Ruby 2.1.3
* PostgreSQL >= 8.4
* ImageMagick
* Nginx (for production use)

Other packages that might be needed (if not installed already):

* Openssl


Server deployment
================

**TESTED IN UBUNTU 14.04 (Trusty)**

Assuming you have all of the above listed dependencies installed.


Pull or clone the repository, **change to project directory** and run `bundle install`. This will install all gems for the system.

# Set Ruby on Rails environment files

## Database.yml

Database.yml has database configs. Copy example from config-directory:

    cp config/database.yml.example config/database.yml

Check `database.yml` and change for example the db username to suit your installation for the application. If you are planning to run server in production mode, password for production user is set below (.env.production)

## Secrets.yml

Control secrets for the application. Admin user for the application is generated from secrets.yml.

Copy example file:

    cp config/secrets.yml.example config/secrets.yml

Edit `secrets.yml` and set secrets for development and test environments as you wish. Production secrets are controlled with environemnt variables, see below.

## Environment variables

This step is only needed when running the application in production mode.

**Dotenv** gem is used to manage some environment variables. Copy example file:

    cp .env.production.example .env.production

Then edit `.env.production` and set variables for your environment:

- ADMIN_NAME
- ADMIN_EMAIL (username for admin user)
- ADMIN_PASSWORD (admin password)
- DOMAIN_NAME
- DB_PASSWORD (password for default db user "postgres", for more precise control use `config/database.yml`)
- SECRET_KEY_BASE (check below)

**Create secret key for Rails app**

By using `rake secret`, append secret key to environment variable file:

    rake secret >> .env.production

Edit `.env.production` and set appended key as value for variable **SECRET_KEY_BASE**



# Test Rails application

Configurations for development environment is now done (installed gem, setup database.yml, secrets.yml...)

Run `rails server` in project root to start development server. If everything is OK WEBrick server should start successfully. Nice!
If it doesn't start it might be because you don't have database configured, run `rake db:create db:migrate` to create database, then `rails server` to start server again.

If you are running server locally, you can now see your application running in [localhost:3000](http://localhost:3000). WEBrick server is only intended to be used in development mode.

If you want to run server only in development mode you can now stop reading and start coding! If you however are planning to setup production server also, Ctrl - C to shutdown the WEBrick server and continue reading.

# Unicorn configuration

Unicorn is the (production) application server for Ruby on Rails application

1. Copy config template

    `cp config/unicorn.example.rb config/unicorn.rb`

2. Check that `config/unicorn.rb` config looks ok, application directory is used as root. By default we listen for socket, but can also be configured to listen for TCP ports etc...

## Unicorn service

Create service for unicorn for easy start/stop/upgrade.

1. Copy script to `/etc/init.d/unicorn`

    `sudo cp config/unicorn_init.sh /etc/init.d/unicorn`

2. Configure `/etc/init.d/unicorn`:
- Set **APP_ROOT** as the directory path for the application root
- Set **AS_USER** to be the current user
- Check that **PID** is the same as in `config/unicorn.rb`

3. Make sure that file is executable (if not, use `chmod +x /etc/init.d/unicorn`)


# Nginx configuration

Nginx is used as HTTP proxy, it takes all HTTP requests to port :80 and forwards them to the Rails app (Unicorn)

## Copy config templates for nginx, assuming application is the "default" site for nginx
    sudo cp config/nginx.config.example /etc/nginx/nginx.conf
    sudo cp config/nginx.config.app.example /etc/nginx/sites-available/default
    sudo rm /etc/nginx/sites-enabled/default # NOTE: this removes old default configs, use with care if there are other sites used with nginx too

    # symlink config to enable site
    sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

## Configure configs

### General nginx config - /etc/nginx/nginx.conf

Open file in editor. If you are using linux, uncomment the line `use epoll;`

Check that pid, error_log and access_log paths defined in `nginx.conf` are OK & writable

### Rails app specific config - /etc/nginx/sites-available/default

- Set server socket path to match unicorn socket path (which is defined in `config/unicorn.rb`): `server unix:/path/to/app/tmp/unicorn.appname.sock fail_timeout=0;`
- Set `root` to be the path to your rails application **/public** folder (not the application root!): `root /path/to/app/public/;`
- As you will be precompiling the assets below, uncomment line `gzip_static on;`. Nginx will provide clients with compiled assets from gzipped files, thus reducing needed bandwith.

Test that nginx configs are valid with `sudo nginx -t`. They should be valid, but if not double check for spelling mistakes etc. If no help try to Google the issue.


# Misc

- `mkdir log` to create folder for logs.
- Make sure folders under tmp/ are writable for the user (if not then `chown -R userX:userX tmp/`)


# Start services

Start nginx: `sudo service nginx start` - starts nginx which forwards http requests from port 80 to the Unicorn socket

Start Unicorn `sudo service unicorn start` - listens for the sockets and executes Rails app on request


# Init the Ruby on Rails application (Production use)

Run command `RAILS_ENV=production rake db:create db:migrate assets:precompile`

- **RAILS_ENV=production** sets the Rails app to start in production mode
- **db:create** will create the `orienteering_production` database based on database.yml
- **db:migrate** will migrate the database structure to the latest version
- **assets:precompile** will compile JS & CSS files into smaller files

If this is fresh install, you might want to run also `RAILS_ENV=production rake db:seed`, which will insert admin user into database (admin user details from `.env.production` (ADMIN_NAME, ADMIN_PASSWORD)).


**Orienteering application is now running with Nginx as HTTP proxy, Unicorn as application server**


If there are changes to code, run `sudo service unicorn stop` and then start Unicorn again `sudo service unicorn start`.


# Problems?

Check logs from `log/production.log` and `log/unicorn.log` to debug issues with application. Or Google.

There is plenty of guides´, articles and solutions about Ruby on Rails available throughout Internet.
