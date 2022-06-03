#!/usr/bin/env bash

set -o errexit

echo "copying .env"
if [ $IS_PULL_REQUEST = "true" ]; then
  ls -al /etc/secrets/.env.preview
  cp /etc/secrets/.env.preview .env
else
  ls -al /etc/secrets/.env.production
  cp /etc/secrets/.env.production .env
fi

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
