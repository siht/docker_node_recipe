#!/bin/sh
echo "Waiting mongo to start on 27017..."
while ! nc -z $CONTAINER_DB_NAME 27017; do
  sleep 0.1
done
echo "mongo started"
