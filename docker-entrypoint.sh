#!/bin/sh
set -e

rm -rf tmp

exec bundle exec "$@"
