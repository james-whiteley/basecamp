#!/bin/sh

cd /usr/src/app
while [ $? -ne 0 ]; do !!; done

DATABASE_PORT=${1:-3306} 

DATABASE_UP="false"
CONNECTION_ATTEMPTS=0

while [ $DATABASE_UP == "false" ]; do
	read DATABASE_UP < <(echo > /dev/tcp/database/$DATABASE_PORT && echo "true" || echo "false")
	((CONNECTION_ATTEMPTS++))
	
	if [ $CONNECTION_ATTEMPTS -ge 50 ]
	then
		break
	fi
	
	sleep 1
done

#bundle config set deployment 'true' 
bundle
rake db:create
rake db:migrate #RAILS_ENV=development
#rake db:schema:load
rails server -b 0.0.0.0