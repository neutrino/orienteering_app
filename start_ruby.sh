#!/usr/bin/env bash

cd /vagrant
cp config/database.example.yml config/database.yml
cp config/secrets.example.yml config/secrets.yml
bundle
echo "Creating databases, migrations and seeds. Admin user is added based on secrets.yml.."
bundle exec rake db:drop db:create db:migrate db:seed
echo "done."
echo "Starting rails server..."
rails server
