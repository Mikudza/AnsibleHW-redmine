#!/bin/sh
# start.sh

set -e
  
host="mysql"
  
until mysql -h "$host" -uredmine -predmine; do
  >&2 echo "MySQL is unavailable - sleeping"
  sleep 5
done
  
>&2 echo "MySQL is up - executing command"

bundle exec rake db:migrate
bundle exec rake redmine:load_default_data
apachectl -D FOREGROUND