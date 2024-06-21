#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails db:create
bundle exec rails db:schema:load db:migrate
