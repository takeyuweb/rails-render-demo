#!/usr/bin/env bash

set -o errexit

printenv

echo "copying .env"
if [ $IS_PULL_REQUEST = "true" ]; then
  echo "cp /etc/secrets/.env.preview .env"
  cp /etc/secrets/.env.preview .env
else
  echo "cp /etc/secrets/.env.production .env"
  cp /etc/secrets/.env.production .env
fi

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
