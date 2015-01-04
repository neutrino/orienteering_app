#!/usr/bin/env bash

echo "install: --no-document" > ~/.gemrc
echo "update: --no-document" >> ~/.gemrc

cd /vagrant
cp config/database.example.yml config/database.yml
cp config/secrets.example.yml config/secrets.yml
bundle
echo "Refreshing $PATH..."
. ~/.bashrc
echo "done."
echo "Creating databases, migrations and seeds. Admin user is added based on secrets.yml.."
bundle exec rake db:create db:migrate db:seed
echo "done."
echo "Starting rails server (detached)..."
rails server -d
