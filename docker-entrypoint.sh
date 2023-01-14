#!/bin/sh

set -e

echo "ENVIRONMENT: $RAILS_ENV"

# install missing gems
bundle check || bundle install --jobs 20 --retry 5

# remove pid from previous session (puma server)

rm -f $APP_PATH/tmp/pids/server.pid

# run anything by prepending bundle exec to the passed command

${@}
