#!/usr/bin/env bash

set -o errexit

# .env.production だと dotenv-rails が RAILS_ENV=productionの時に選択してしまうのでこの名前
echo "copying .env"
if [ $IS_PULL_REQUEST = "true" ]; then
  cp dotenv-prev .env
else
  cp dotenv-prod .env
fi

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
