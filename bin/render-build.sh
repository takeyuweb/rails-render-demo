#!/usr/bin/env bash

set -o errexit

echo "copying .env"
if [ $IS_PULL_REQUEST = "true" ]; then
  cp .env.preview .env
else
  cp .env.production .env
fi
rm .env.*

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
